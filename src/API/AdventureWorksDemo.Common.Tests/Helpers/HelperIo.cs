namespace AdventureWorksDemo.Common.Tests.Helpers
{
	public static partial class CommonHelper
	{
		public static partial class IO
		{
			public static DirectoryInfo? TryGetSolutionDirectoryInfo()
			{ return TryGetSolutionDirectoryInfo(currentPath: string.Empty); }

			public static DirectoryInfo? TryGetSolutionDirectoryInfo(string currentPath)
			{
				var directory = new DirectoryInfo(
					!string.IsNullOrEmpty(currentPath) ? currentPath : Directory.GetCurrentDirectory());
				while (directory != null && directory.GetFiles("*.sln").Length == 0)
				{
					directory = directory.Parent;
				}
				return directory;
			}
		}
	}
}