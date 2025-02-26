using AdventureWorksDemo.Data.Entities;

using MockQueryable.Moq;

using Moq;

namespace AdventureWorksDemo.Data.Tests.Fakes
{
	internal static class MockedDbContext
	{
		internal static Mock<DbContexts.AdventureWorksContext> MockedDbContextAllData()
		{
			Mock<DbContexts.AdventureWorksContext> dbContext = new();
			// //

			dbContext.Setup(m => m.Set<Address>()).Returns(FakeDbContext.FakeAddresses.BuildMockDbSet<Address>().Object);
			// //

			return dbContext;
		}
	}
}