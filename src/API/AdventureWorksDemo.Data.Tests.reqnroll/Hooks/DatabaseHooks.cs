namespace AdventureWorksDemo.Data.Tests.reqnroll.Hooks
{
    [Binding]
    public sealed class DatabaseHooks : IDisposable
    {
        // For additional details on Reqnroll hooks see https://go.reqnroll.net/doc-hooks
        [BeforeTestRun]
        public static async Task DatabaseBeforeTestRunAsync()
        {
            DockerMsSqlServerDatabase.Current = await DockerMsSqlServerDatabase.Create();
        }

        public void Dispose()
        {
            Task.Run(async () => { await DockerMsSqlServerDatabase.Current!.DisposeAsync(); });
        }
    }
}