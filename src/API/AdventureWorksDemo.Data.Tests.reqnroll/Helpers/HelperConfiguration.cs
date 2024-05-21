using Microsoft.Extensions.Configuration;

namespace AdventureWorksDemo.Data.Tests.reqnroll.Helpers
{
    internal static partial class Helper
    {
        public static class Configuration
        {
            private static IConfiguration? _configuration;
            private static string? databaseConnectionString;

            public static string? DatabaseConnectionString
            {
                get => databaseConnectionString;
                set
                {
                    databaseConnectionString = value;
                    _configuration = null;
                    _ = GetConfiguration;
                }
            }

            internal static IConfiguration GetConfiguration
            {
                get
                {
                    if (_configuration == null)
                    {
                        var cb = LoadAppSettingsFiles();
                        if (!string.IsNullOrEmpty(DatabaseConnectionString))
                        {
                            var targetDatabase = new Dictionary<string, string>
                                            {
                                                {"ConnectionStrings:Target",DatabaseConnectionString },
                                            };
                            cb.AddInMemoryCollection(targetDatabase!);
                        }
                        _configuration = cb.Build();
                    };

                    return _configuration;
                }
            }

            private static ConfigurationBuilder LoadAppSettingsFiles()
            {
                var solutionFolder = Path.Combine(TryGetSolutionDirectoryInfo()!.FullName
                                                                            , "API\\AdventureWorksDemo.API"
                                                                            );

                var cb = new ConfigurationBuilder();
                cb.AddJsonFile(Path.Combine(solutionFolder, "appsettings.json"), false);
                cb.AddJsonFile(Path.Combine(solutionFolder, "appsettings.Development.json"), false);
                cb.AddJsonFile("appsettings.json", false);
                return cb;
            }
        }
    }
}