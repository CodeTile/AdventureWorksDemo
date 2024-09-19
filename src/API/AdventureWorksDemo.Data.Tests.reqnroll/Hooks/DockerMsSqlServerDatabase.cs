using System.Diagnostics;
using System.Diagnostics.CodeAnalysis;
using System.Net;

using AdventureWorksDemo.Data.Tests.reqnroll.Helpers;

using Docker.DotNet;

using DotNet.Testcontainers.Builders;
using DotNet.Testcontainers.Containers;

using FluentAssertions.Extensions;

using Microsoft.Data.SqlClient;
using Microsoft.Testing.Platform.Configurations;

using Polly;

namespace AdventureWorksDemo.Data.Tests.reqnroll.Hooks
{
	[ExcludeFromCodeCoverage]
	internal class DockerMsSqlServerDatabase : IAsyncDisposable
	{
		public DockerMsSqlServerDatabase()
		{
			DatabaseName = AppSettings["Database:TestDbPrefix"] + Guid.NewGuid();
		}

		public DockerMsSqlServerDatabase(string databaseName)
		{
			DatabaseName = databaseName;
		}

		public readonly string DatabaseName;
		internal IConfiguration? configuration;
		private const string Image = "mcr.microsoft.com/mssql/server";
		private const string Password = "!Passw0rd";
		private const string Tag = "latest";
		private static readonly int ContainerPort = 1433;
		private static IContainer? _sqlServerContainer;
		private bool _deleted;
		private SemaphoreSlim semaphore = new(1, 1);

		public string ConnectionString =>
					$"server=localhost,{PublicPort};database={DatabaseName};User Id=sa;Password={Password};Encrypt=false";

		internal static DockerMsSqlServerDatabase? Current { get; set; }
		internal Microsoft.Extensions.Configuration.IConfiguration AppSettings => Helper.Configuration.GetConfiguration;
		private static int PublicPort => _sqlServerContainer!.GetMappedPublicPort(ContainerPort);

		private string? GetBackupFullName => Path.Combine(GetBackupLocation!, AppSettings["Database:FileName"]!);

		private string? GetBackupLocation => AppSettings["Database:Location"]?
														.Replace("<<sln>>", Helper.TryGetSolutionDirectoryInfo()?.FullName);

		public static async Task<DockerMsSqlServerDatabase> Create(CancellationToken cancellationToken = default)
		{
			var db = new DockerMsSqlServerDatabase();

			await db.CreateAndStartContainer();
			await db.CreateDatabase(cancellationToken);
			await db.PrepareDataForTesting(cancellationToken);
			Helper.Configuration.DatabaseConnectionString = db.ConnectionString;
			return db;
		}

		public ValueTask DisposeAsync()
		{
			// //
			if (_deleted)
			{
				return new ValueTask();
			}

			DeleteDatabase();

			return new ValueTask();
		}

		public async Task PrepareDataForTesting(CancellationToken cancellationToken = default)
		{
			string filename = AppSettings["Database:ResetDataScriptName"]?
														.Replace("<<sln>>", Helper.TryGetSolutionDirectoryInfo()?.FullName)
														?? string.Empty;
			if (!File.Exists(filename))
			{
				throw new FileNotFoundException(filename);
			}
			string query = File.ReadAllText(filename)
								.Replace("$TARGET_DB_NAME", DatabaseName);

			SqlConnection.ClearAllPools();

			await using var connection = CreateConnection();
			await connection.OpenAsync(cancellationToken);

			await using var command = new SqlCommand("Print 'Hello World';", connection);

			foreach (string commandText in Helper.Sql.SplitSqlQueryOnGo(query))
			{
				command.CommandText = commandText;
				System.Diagnostics.Debug.WriteLine(command.CommandText);
				await command.ExecuteNonQueryAsync(cancellationToken);
			}
		}

		private static SqlConnection CreateConnection()
		{
			var masterConnectionString =
					 $"server=localhost,{PublicPort};User Id=sa;Password={Password};Initial Catalog=master;Encrypt=false";
			var connectionStringBuilder = new SqlConnectionStringBuilder(masterConnectionString);
			System.Diagnostics.Debug.WriteLine($"\r\n\r\n\r\n{masterConnectionString}\r\n\r\n\r\n");

			return new SqlConnection(connectionStringBuilder.ConnectionString);
		}

		private static async Task<bool> HealthCheck(CancellationToken cancellationToken)
		{
			try
			{
				SqlConnection.ClearAllPools();

				await using var connection = CreateConnection();
				await connection.OpenAsync(cancellationToken);

				return true;
			}
			catch (Exception)
			{
				await Task.Delay(1.Seconds(), cancellationToken);
			}

			return false;
		}

		private void CloneBackUpFile()
		{
			var url = AppSettings["GitHub:BackUpFile"];
			if (!Directory.Exists(GetBackupLocation)) { Directory.CreateDirectory(GetBackupLocation!); }
			using WebClient wc = new WebClient();
			wc.Headers.Add("a", "a");
			try
			{
				wc.DownloadFile(url!, GetBackupFullName!);
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.ToString());
			}
		}

		private async Task CreateAndStartContainer()
		{
			if (_sqlServerContainer == null)
			{
				try
				{
					CloneBackUpFile();
					await semaphore.WaitAsync();

					if (_sqlServerContainer == null)
					{
						bool withCleanUp = Convert.ToBoolean(AppSettings["TestContainers:RemoveTestContainersAfterTestRun"]);
						_sqlServerContainer = new ContainerBuilder()
							.WithImage($"{Image}:{Tag}")
							.WithPortBinding(ContainerPort, assignRandomHostPort: true)
							.WithEnvironment("ACCEPT_EULA", "Y")
							.WithEnvironment("SA_PASSWORD", Password)
							.WithCleanUp(cleanUp: withCleanUp)
							.WithWaitStrategy(Wait.ForUnixContainer()
								.UntilOperationIsSucceeded(
									() => HealthCheck(CancellationToken.None).GetAwaiter().GetResult(),
									10))
							.WithBindMount(GetBackupLocation, AppSettings["Docker:BindLocation"])
							.Build();

						_sqlServerContainer.Stopping += OnStopping;

						await _sqlServerContainer.StartAsync();
					}
				}
				catch (DockerImageNotFoundException)
				{
					throw new InvalidOperationException(
						"SQL Server docker image not found. Did you run \"build.ps1 BuildSqlServerWithFtsImage\"");
				}
				//catch (Exception ex)
				//{
				//}
				finally
				{
					semaphore.Release();
				}
			}
		}

		private async Task CreateDatabase(CancellationToken cancellationToken = default)
		{
			string filename = AppSettings["Database:RestoreScriptName"]?
														.Replace("<<sln>>", Helper.TryGetSolutionDirectoryInfo()?.FullName)
														?? string.Empty;
			if (!File.Exists(filename))
			{
				throw new FileNotFoundException(filename);
			}
			var restoreQuery = File.ReadAllText(filename)
								.Replace("$BackupFileName", AppSettings["Database:FileName"])
								.Replace("$TARGET_DB_NAME", DatabaseName);
			SqlConnection.ClearAllPools();

			await using var connection = CreateConnection();
			await connection.OpenAsync(cancellationToken);

			await using var command = new SqlCommand(restoreQuery, connection);

			// HACK: should mitigate (slightly) the bug in MSSQL that prevents us from creating new
			// databases. See https://github.com/Microsoft/mssql-docker/issues/344 for tracking issue.
			var CreatePolicy = Policy
				.Handle<SqlException>(e => e.Number == 5177)
				.WaitAndRetryAsync(
				[
				TimeSpan.FromSeconds(1),
				TimeSpan.FromSeconds(4),
				TimeSpan.FromSeconds(6)
				]);

			await CreatePolicy.ExecuteAsync(async () => { await command.ExecuteNonQueryAsync(cancellationToken); });
		}

		private void DeleteDatabase()
		{
			using (var connection = CreateConnection())
			{
				connection.Open();

				using (var command =
					   new SqlCommand($"ALTER DATABASE [{DatabaseName}] SET SINGLE_USER WITH ROLLBACK IMMEDIATE",
						   connection))
				{
					command.ExecuteNonQuery();
				}

				using (var command = new SqlCommand($"DROP DATABASE [{DatabaseName}]", connection))
				{
					try
					{
						command.ExecuteNonQuery();
					}
					catch (SqlException ex)
					{
						Console.WriteLine(ex.Message);
					}
				}
			}

			_deleted = true;
		}

		private void OnStopping(object sender, EventArgs e)
		{
			try
			{
				semaphore.Wait();

				if (_sqlServerContainer != null)
				{
					_sqlServerContainer.Stopping -= OnStopping;
					_sqlServerContainer = null;
				}
			}
			finally
			{
				semaphore.Release();
			}
		}
	}
}