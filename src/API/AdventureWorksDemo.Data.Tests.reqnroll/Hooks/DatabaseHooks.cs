namespace AdventureWorksDemo.Data.Tests.reqnroll.Hooks
{
	using AdventureWorksDemo.Common.Tests;
	using AdventureWorksDemo.Common.Tests.Helpers;
	using AdventureWorksDemo.Data.Tests.reqnroll.Helpers;
	using AdventureWorksDemo.Data.Tests.reqnroll.ValueRetrievers;

	using Reqnroll.Assist;

	[Binding]
	public sealed class DatabaseHooks : IDisposable
	{
		internal static Microsoft.Extensions.Configuration.IConfiguration AppSettings => CommonHelper.Configuration.GetConfiguration;

		[BeforeTestRun(Order = 1)]
		public static void BeforeTestRun()
		{
			Service.Instance.ValueComparers.Register(new StringValueComparer());
		}

		[AfterScenario(Order = 100)]
		public static async Task DataBaseBeforeScenario()
		{
			if (Helper.ScenarioContexts.GetFlag(ScenarioContextKey.FlagResetDatabase))
			{
				await DockerMsSqlServerDatabase.Current!.PrepareDataForTesting();
				Helper.ScenarioContexts.UpdateFlag(ScenarioContextKey.FlagResetDatabase, false);
			}
		}

		// For additional details on Reqnroll hooks see https://go.reqnroll.net/doc-hooks
		[BeforeTestRun(Order = 10)]
		public static async Task DatabaseBeforeTestRunAsync()
		{
			DockerMsSqlServerDatabase.Current = await DockerMsSqlServerDatabase.Create(default, CreateTestingDatabaseBakFile());
			Helper.ScenarioContexts.UpdateFlag(ScenarioContextKey.FlagResetDatabase, false);
			Helper.DateTimeHelpers.SetTimeProvider();
		}

		public void Dispose()
		{
			Task.Run(async () => { await DockerMsSqlServerDatabase.Current!.DisposeAsync(); });
		}

		private static bool CreateTestingDatabaseBakFile()
		{
			string location = AppSettings["Database:Location"]?
														.Replace("<<sln>>", CommonHelper.IO.TryGetSolutionDirectoryInfo()?.FullName)
														?? string.Empty;
			string source = Path.Combine(location, AppSettings["Database:SourceDatabase"] ?? "<null>");
			string destination = Path.Combine(location, AppSettings["Database:DataBaseForTesting"] ?? "<null>");
			if (!File.Exists(destination))
			{
				File.Copy(source, destination);
				return true;
			}
			return false;
		}
	}
}