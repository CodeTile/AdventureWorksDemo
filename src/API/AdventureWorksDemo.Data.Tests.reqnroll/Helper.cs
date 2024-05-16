using AdventureWorksDemo.Data.StartUp;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Newtonsoft.Json.Linq;
using static System.Formats.Asn1.AsnWriter;

namespace AdventureWorksDemo.Data.Tests.reqnroll
{
    internal static class Helper
    {
        internal static readonly string[] separator = ["GO\r\n"];

        internal static DirectoryInfo? TryGetSolutionDirectoryInfo()
        { return TryGetSolutionDirectoryInfo(currentPath: string.Empty); }

        internal static DirectoryInfo? TryGetSolutionDirectoryInfo(string currentPath)
        {
            var directory = new DirectoryInfo(
                !string.IsNullOrEmpty(currentPath) ? currentPath : Directory.GetCurrentDirectory());
            while (directory != null && !directory.GetFiles("*.sln").Any())
            {
                //var debug = directory.GetFiles("*.sln");
                //var debug2 = directory.GetFiles();
                directory = directory.Parent;
            }
            return directory;
        }

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
                var solutionFolder = Path.Combine(Helper.TryGetSolutionDirectoryInfo()!.FullName
                                                                            , "API\\AdventureWorksDemo.API"
                                                                            );

                var cb = new ConfigurationBuilder();
                cb.AddJsonFile(Path.Combine(solutionFolder, "appsettings.json"), false);
                cb.AddJsonFile(Path.Combine(solutionFolder, "appsettings.Development.json"), false);
                cb.AddJsonFile("appsettings.json", false);
                return cb;
            }
        }

        public static class Ioc
        {
            public static ServiceProvider BuildIoc()
            {
                var services = new ServiceCollection();
                var config = Helper.Configuration.GetConfiguration;

                new IocData(config).ConfigureServices(services);

                return services.BuildServiceProvider();
            }

            public static T? ResolveObject<T>()
            {
                var service = BuildIoc().GetService(typeof(T));
                return (T?)service;
            }
        }

        public static class Sql
        {
            internal static string[] SplitSqlQueryOnGo(string query)
            {
                return query.Split(separator, StringSplitOptions.RemoveEmptyEntries);
            }
        }
    }
}