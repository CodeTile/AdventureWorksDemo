namespace AdventureWorksDemo.Data.Tests.reqnroll.Hooks
{
    using AdventureWorksDemo.Data.StartUp;
    using Microsoft.Extensions.DependencyInjection;

    [Binding]
    public sealed class DatabaseHooks : IDisposable
    {
        // For additional details on Reqnroll hooks see https://go.reqnroll.net/doc-hooks
        [BeforeTestRun(Order = 10)]
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