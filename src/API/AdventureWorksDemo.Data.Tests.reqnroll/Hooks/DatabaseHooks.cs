using DotNet.Testcontainers.Clients;
using Microsoft.Testing.Platform.Configurations;
using Renci.SshNet;
using Reqnroll;

namespace AdventureWorksDemo.Data.Tests.reqnroll.Hooks
{
    [Binding]
    public sealed class DatabaseHooks : IDisposable
    {
        private static DockerMsSqlServerDatabase? _databaseServer;

        // For additional details on Reqnroll hooks see https://go.reqnroll.net/doc-hooks
        [BeforeTestRun]
        public static async Task DatabaseBeforeTestRunAsync()
        {
            _databaseServer = await DockerMsSqlServerDatabase.Create();
        }

        public void Dispose()
        {
            Task.Run(async () => { await _databaseServer!.DisposeAsync(); });
        }
    }
}