using System.Diagnostics.CodeAnalysis;
using System.Net;
using System.Threading;

using AdventureWorksDemo.Common.Tests.Helpers;

//using AdventureWorksDemo.Data.Tests.reqnroll.Helpers;

using Docker.DotNet;

using DotNet.Testcontainers.Builders;
using DotNet.Testcontainers.Containers;

using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Microsoft.Testing.Platform.Configurations;

using Polly;

using Testcontainers.MsSql;

namespace AdventureWorksDemo.Common.Tests
{
	[ExcludeFromCodeCoverage]
	public class DockerMsSqlServerDatabase : IAsyncDisposable
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

		// internal Microsoft.Extensions.Configuration.IConfiguration? configuration;
		private const string Image = "mcr.microsoft.com/mssql/server";

		private const string Password = "!Passw0rd";
		private const string Tag = "latest";
		private static readonly int ContainerPort = 1433;
		private static IContainer? _sqlServerContainer;
		private bool _deleted;
		private SemaphoreSlim semaphore = new(1, 1);

		public static DockerMsSqlServerDatabase? Current { get; set; }

		public string ConnectionString =>
							$"server=localhost,{PublicPort};database={DatabaseName};User Id=sa;Password={Password};Encrypt=false";

		internal Microsoft.Extensions.Configuration.IConfiguration AppSettings => CommonHelper.Configuration.GetConfiguration;
		private static int PublicPort => _sqlServerContainer!.GetMappedPublicPort(ContainerPort);

		private string? GetBackupFullName => Path.Combine(GetBackupLocation!, AppSettings["Database:DataBaseForTesting"]!);

		private string? GetBackupLocation => AppSettings["Database:Location"]?
														.Replace("<<sln>>", CommonHelper.IO.TryGetSolutionDirectoryInfo()?.FullName);

		public static async Task<DockerMsSqlServerDatabase> Create(CancellationToken cancellationToken = default, bool backupTestDatabase = false)
		{
			var db = new DockerMsSqlServerDatabase();

			await db.CreateAndStartContainer();
			await db.CreateDatabase(cancellationToken);
			await db.PrepareDataForTesting(cancellationToken);
			CommonHelper.Configuration.DatabaseConnectionString = db.ConnectionString;

			if (backupTestDatabase)
				await db.BackUpTestDatabaseAsync(cancellationToken);
			return db;
		}

		public async Task BackUpTestDatabaseAsync(CancellationToken cancellationToken)
		{
			string backupFileName = AppSettings["Database:BackupScriptName"]?
														.Replace("<<sln>>", CommonHelper.IO.TryGetSolutionDirectoryInfo()?.FullName)
														?? string.Empty;
			if (!File.Exists(backupFileName))
			{
				throw new FileNotFoundException(backupFileName);
			}

			string query = File.ReadAllText(backupFileName)
								.Replace("$TARGET_DB_NAME", DatabaseName)
								.Replace("$BackupFileName", AppSettings["Database:DataBaseForTesting"]);

			SqlConnection.ClearAllPools();

			await using var connection = CreateConnection();
			await connection.OpenAsync(cancellationToken);

			await using var command = new SqlCommand("Select db_name();", connection);

			foreach (string commandText in CommonHelper.Sql.SplitSqlQueryOnGo(query))
			{
				command.CommandText = commandText;

				DisplayCommandText(command.CommandText);
				await command.ExecuteNonQueryAsync(cancellationToken);
			}
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
														.Replace("<<sln>>", CommonHelper.IO.TryGetSolutionDirectoryInfo()?.FullName)
														?? string.Empty;
			if (!File.Exists(filename))
			{
				throw new FileNotFoundException(filename);
			}
			string query = File.ReadAllText(filename)
								.Replace("$TARGET_DB_NAME", DatabaseName);

			SqlConnection.ClearAllPools();

			await using var connection = CreateConnection(DatabaseName);

			await connection.OpenAsync(cancellationToken);

			await using var command = new SqlCommand("Select db_name();", connection);

			foreach (string commandText in CommonHelper.Sql.SplitSqlQueryOnGo(query))
			{
				command.CommandText = commandText;
				DisplayCommandText(command.CommandText);
				await command.ExecuteNonQueryAsync(cancellationToken);
			}
		}

		private static SqlConnection CreateConnection(string databaseName = "master")
		{
			var masterConnectionString =
					 $"server=localhost,{PublicPort};User Id=sa;Password={Password};Initial Catalog={databaseName};Encrypt=false";
			var connectionStringBuilder = new SqlConnectionStringBuilder(masterConnectionString);

			System.Diagnostics.Trace.WriteLine($"\r\n\r\n\r\n{masterConnectionString}\r\n\r\n\r\n");

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
				await Task.Delay(2000, cancellationToken);
			}

			return false;
		}

		private async Task CloneBackUpFileAsync()
		{
			var url = AppSettings["GitHub:BackUpFile"];
			if (string.IsNullOrWhiteSpace(url))
			{
				Console.WriteLine("Backup URL is not configured.");
				return;
			}

			var backupLocation = GetBackupLocation;
			var backupFileName = GetBackupFullName;

			try
			{
				Directory.CreateDirectory(backupLocation);

				using HttpClient client = new();
				client.DefaultRequestHeaders.Add("a", "a");

				byte[] fileBytes = await client.GetByteArrayAsync(url);
				await File.WriteAllBytesAsync(backupFileName, fileBytes);

				Console.WriteLine("Backup downloaded successfully.");
			}
			catch (Exception ex)
			{
				Console.WriteLine($"Error downloading backup: {ex}");
			}
		}

		private async Task CreateAndStartContainer()
		{
			if (_sqlServerContainer == null)
			{
				try
				{
					await semaphore.WaitAsync();

					if (_sqlServerContainer == null)
					{
						bool withCleanUp = Convert.ToBoolean(AppSettings["TestContainers:RemoveTestContainersAfterTestRun"]);

						_sqlServerContainer = new MsSqlBuilder()
							.WithImage($"{Image}:{Tag}")
							.WithPassword(Password)
							.WithCleanUp(withCleanUp)
							.WithBindMount(GetBackupLocation, AppSettings["Docker:BindLocation"])
							.WithPortBinding(ContainerPort, true)
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
														.Replace("<<sln>>", CommonHelper.IO.TryGetSolutionDirectoryInfo()?.FullName)
														?? string.Empty;
			if (!File.Exists(filename))
			{
				throw new FileNotFoundException(filename);
			}
			var restoreQuery = File.ReadAllText(filename)
								.Replace("$BackupFileName", AppSettings["Database:DataBaseForTesting"])
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
			DisplayCommandText(command.CommandText);
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
					DisplayCommandText(command.CommandText);
					command.ExecuteNonQuery();
				}

				using (var command = new SqlCommand($"DROP DATABASE [{DatabaseName}]", connection))
				{
					try
					{
						DisplayCommandText(command.CommandText);
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

		private void DisplayCommandText(string commandText)
		{
			string setting = AppSettings["Logging:TestContainers:SQLDBConfiguration"] ?? "";
			if (!setting.Equals("None"))
				System.Diagnostics.Debug.WriteLine(commandText);
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