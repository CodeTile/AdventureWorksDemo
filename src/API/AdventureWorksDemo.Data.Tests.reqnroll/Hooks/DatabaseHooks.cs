namespace AdventureWorksDemo.Data.Tests.reqnroll.Hooks
{
	using AdventureWorksDemo.Common.Tests;
	using AdventureWorksDemo.Data.Tests.reqnroll.Helpers;

	[Binding]
	public sealed class DatabaseHooks : IDisposable
	{
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
			DockerMsSqlServerDatabase.Current = await DockerMsSqlServerDatabase.Create();
			Helper.ScenarioContexts.UpdateFlag(ScenarioContextKey.FlagResetDatabase, false);
			Helper.DateTimeHelpers.SetTimeProvider();
		}

		public void Dispose()
		{
			Task.Run(async () => { await DockerMsSqlServerDatabase.Current!.DisposeAsync(); });
		}
	}
}