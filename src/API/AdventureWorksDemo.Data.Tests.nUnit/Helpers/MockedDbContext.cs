using AdventureWorksDemo.Data.Entities;

using MockQueryable.Moq;

using Moq;

namespace AdventureWorksDemo.Data.Tests.nUnit.Helpers
{
	internal static class MockedDbContext
	{
		public static Mock<DbContexts.dbContext> MockedDbContextAllData()
		{
			Mock<DbContexts.dbContext> dbContext = new();
			// //

			dbContext.Setup(m => m.Set<Address>()).Returns(FakeDbContext.FakeAddresses.BuildMockDbSet<Address>().Object);
			// //

			return dbContext;
		}
	}
}