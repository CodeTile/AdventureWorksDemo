using AdventureWorksDemo.Data.Entities;
using Microsoft.EntityFrameworkCore;
using Moq;

namespace AdventureWorksDemo.Data.Tests.nUnit.Helpers
{
    internal static class MockedDbContext
    {
        public static Mock<DbContexts.dbContext> MockedDbContextAllData()
        {
            Mock<DbContexts.dbContext> dbContext = new();
            // //

            dbContext.Setup(m => m.Set<Address>()).Returns(MockedDbSet<Address>(FakeDbContext.FakeAddresses.AsQueryable()).Object);
            // //

            return dbContext;
        }

        public static Mock<DbSet<TEntity>> MockedDbSet<TEntity>(IQueryable<TEntity> data)
            where TEntity : class
        {
            var retval = new Mock<DbSet<TEntity>>();

            retval.As<IQueryable<TEntity>>().Setup(m => m.Provider).Returns(data.Provider);
            retval.As<IQueryable<TEntity>>().Setup(m => m.Expression).Returns(data.Expression);
            retval.As<IQueryable<TEntity>>().Setup(m => m.ElementType).Returns(data.ElementType);
            retval.As<IQueryable<TEntity>>().Setup(m => m.GetEnumerator()).Returns(data.GetEnumerator());
            return retval;
        }
    }
}