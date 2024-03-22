using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Repository;
using AdventureWorksDemo.Data.Tests.nUnit.Helpers;
using FluentAssertions;

namespace AdventureWorksDemo.Data.Tests.nUnit
{
    // //https://code-maze.com/ef-core-mock-dbcontext/
    public class GenericCRUDRepositoryTests
    {
        //private IMapper _mapper;

        [Test]
        public void AddAddress()
        {
            // Arrange
            var dbContext = MockedDbContext.MockedDbContextAllData();
            var uot = new GenericCRUDRepository<Address>(dbContext.Object);
            var newAddress = new Address() { AddressLine1 = "Ping", };
            // Act
            var actual = uot.FindEntities(null)?.ToArray();
            //Assert
            actual.Should().NotBeNull();
            actual?.Length.Should().Be(FakeDbContext.FakeAddresses.Count);
        }

        [Test]
        public void FindEntities()
        {
            // Arrange
            var dbContext = MockedDbContext.MockedDbContextAllData();
            var uot = new GenericCRUDRepository<Address>(dbContext.Object);
            // Act
            var actual = uot.FindEntities(null)?.ToArray();
            //Assert
            actual.Should().NotBeNull();
            actual?.Length.Should().Be(FakeDbContext.FakeAddresses.Count);
        }

        [Test]
        public void FindEntity_0()
        {
            // Arrange
            var dbContext = MockedDbContext.MockedDbContextAllData();
            var uot = new GenericCRUDRepository<Address>(dbContext.Object);
            // Act
            var actual = uot.FindEntities(m => m.AddressId == 0)?.ToArray();
            //Assert
            actual.Should().BeNullOrEmpty();
            actual?.Length.Should().Be(0);
        }

        [Test]
        public void FindEntity_2()
        {
            // Arrange
            var dbContext = MockedDbContext.MockedDbContextAllData();
            var uot = new GenericCRUDRepository<Address>(dbContext.Object);
            // Act
            var actual = uot.FindEntities(m => m.AddressId == 2)?.ToArray();
            //Assert
            actual.Should().NotBeEmpty();
            actual?.Length.Should().Be(1);
        }

        [Test]
        public void FindEntity_5678()
        {
            // Arrange
            var dbContext = MockedDbContext.MockedDbContextAllData();
            var uot = new GenericCRUDRepository<Address>(dbContext.Object);
            // Act
            var actual = uot.FindEntities(m => m.AddressId == 5678)?.ToArray();
            //Assert
            actual.Should().BeEmpty();
            actual?.Length.Should().Be(0);
        }

        [SetUp]
        public void Setup()
        {
            //var config = new MapperConfiguration(cfg => cfg.AddProfile<MappingProfile>());
            //_mapper = config.CreateMapper();
        }
    }
}