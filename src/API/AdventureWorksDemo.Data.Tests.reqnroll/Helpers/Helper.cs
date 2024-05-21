using AdventureWorksDemo.Data.StartUp;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace AdventureWorksDemo.Data.Tests.reqnroll.Helpers
{
    internal static partial class Helper
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
                directory = directory.Parent;
            }
            return directory;
        }
    }
}