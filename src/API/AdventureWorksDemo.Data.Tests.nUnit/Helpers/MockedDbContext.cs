using AdventureWorksDemo.Data.Entities;

using MockQueryable.Moq;

using Moq;

namespace AdventureWorksDemo.Data.Tests.nUnit.Helpers
{
	internal static class MockedDbContext
	{
		internal static Mock<DbContexts.AdventureWorksDbContext> MockedDbContextAllData()
		{
			Mock<DbContexts.AdventureWorksDbContext> dbContext = new();
			// //

			dbContext.Setup(m => m.Set<Address>()).Returns(FakeDbContext.FakeAddresses.BuildMockDbSet<Address>().Object);
			// //

			return dbContext;
		}
	}
}