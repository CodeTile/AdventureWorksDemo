using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Services;
using AdventureWorksDemo.Data.StartUp;
using AdventureWorksDemo.Data.Tests.nUnit.Helpers;
using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Moq;
using FluentAssertions;
using Moq.EntityFrameworkCore;

namespace AdventureWorksDemo.Data.Tests.nUnit
{
    // //https://code-maze.com/ef-core-mock-dbcontext/
    public class AddressTests
    {
        private IMapper _mapper;
        private Mock<DbContexts.dbContext> _moqDbContext;

        [SetUp]
        public void Setup()
        {
            var config = new MapperConfiguration(cfg => cfg.AddProfile<MappingProfile>());
            _mapper = config.CreateMapper();

            _moqDbContext = new Mock<AdventureWorksDemo.Data.DbContexts.dbContext>();
            _moqDbContext.Setup<DbSet<Address>>(m => m.Addresses).ReturnsDbSet(FakeDbContext.FakeAddresses);
        }

        [Test]
        public void Test1()
        {
            // Arrange
            var service = new AddressService(_moqDbContext.Object, _mapper);
            // Act
            var actual = service.FindAllAsync(new Paging.PageingFilter());
            //Assert
            actual.Result.Should().NotBeNull();
            actual.Result.Count.Should().Be(FakeDbContext.FakeAddresses.Count());
        }
    }
}