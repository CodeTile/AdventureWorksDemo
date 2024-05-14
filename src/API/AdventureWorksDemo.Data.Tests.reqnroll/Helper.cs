using Microsoft.Extensions.Configuration;

namespace AdventureWorksDemo.Data.Tests.reqnroll
{
    internal static class Helper
    {
        internal static IConfiguration GetConfiguration => new ConfigurationBuilder().AddJsonFile("appsettings.json").Build();

        internal static DirectoryInfo? TryGetSolutionDirectoryInfo()
        { return TryGetSolutionDirectoryInfo(currentPath: string.Empty); }

        internal static DirectoryInfo? TryGetSolutionDirectoryInfo(string currentPath)
        {
            var directory = new DirectoryInfo(
                !string.IsNullOrEmpty(currentPath) ? currentPath : Directory.GetCurrentDirectory());
            while (directory != null && !directory.GetFiles("*.sln").Any())
            {
                directory = directory.Parent;
            }
            return directory;
        }
    }
}