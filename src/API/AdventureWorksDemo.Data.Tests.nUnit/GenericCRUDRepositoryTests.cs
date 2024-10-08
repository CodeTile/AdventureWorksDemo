//using AdventureWorksDemo.Data.Entities;
//using AdventureWorksDemo.Data.Repository;
//using AdventureWorksDemo.Data.Tests.nUnit.Helpers;

//using FluentAssertions;

//using Microsoft.Extensions.Time.Testing;

//namespace AdventureWorksDemo.Data.Tests.nUnit
//{
//#nullable disable

// // //https://code-maze.com/ef-core-mock-dbcontext/ public class GenericCRUDRepositoryTests {
// private FakeTimeProvider _fakeTimeProvider;

// [Test] public async Task AddAddressAsync() { // Arrange var dbContext =
// MockedDbContext.MockedDbContextAllData(); var uot = new
// GenericCrudRepository<Address>(dbContext.Object, _fakeTimeProvider); // Act var actual = await
// uot.AddAsync(FakeDbContext.NewAddress1()); //Assert actual.Should().NotBeNull();
// actual.Should().BeEquivalentTo(FakeDbContext.NewAddress1()); }

// [Test] public async Task AddAddressNullAsync() { // Arrange var dbContext =
// MockedDbContext.MockedDbContextAllData(); var uot = new
// GenericCrudRepository<Address>(dbContext.Object, _fakeTimeProvider); // Act var actual = await
// uot.AddAsync(null); //Assert actual.Should().BeNull(); }

// [Test] public async Task DeleteAddressAsync1234() { // Arrange var dbContext =
// MockedDbContext.MockedDbContextAllData(); var uot = new
// GenericCrudRepository<Address>(dbContext.Object, _fakeTimeProvider); // Act var actual = await
// uot.DeleteAsync(m => m.AddressId == 1234); //Assert actual.IsSuccess.Should().BeFalse();
// actual.IsFailure.Should().BeTrue(); }

// [Test] public async Task DeleteAddressAsync3() { // Arrange var dbContext =
// MockedDbContext.MockedDbContextAllData(); var uot = new
// GenericCrudRepository<Address>(dbContext.Object, _fakeTimeProvider); // Act

// // var entitiesBefore = uot.FindEntities().ToArray(); var actual = await uot.DeleteAsync(m =>
// m.AddressId == 3); //Assert actual.IsSuccess.Should().BeTrue();
// actual.IsFailure.Should().BeFalse(); var deletedEntity = uot.FindEntities(m => m.AddressId == 3);

// var entitiesRemaining = uot.FindEntities().ToArray(); }

// [Test] public void FindEntities() { // Arrange var dbContext =
// MockedDbContext.MockedDbContextAllData(); var uot = new
// GenericCrudRepository<Address>(dbContext.Object, _fakeTimeProvider); // Act var actual =
// uot.FindEntities(null)?.ToArray(); //Assert actual.Should().NotBeNull();
// actual?.Length.Should().Be(FakeDbContext.FakeAddresses.Count); }

// [Test] public void FindEntity_0() { // Arrange var dbContext =
// MockedDbContext.MockedDbContextAllData(); var uot = new
// GenericCrudRepository<Address>(dbContext.Object, _fakeTimeProvider); // Act var actual =
// uot.FindEntities(m => m.AddressId == 0)?.ToArray(); //Assert actual.Should().BeNullOrEmpty();
// actual?.Length.Should().Be(0); }

// [Test] public void FindEntity_2() { // Arrange var dbContext =
// MockedDbContext.MockedDbContextAllData(); var uot = new
// GenericCrudRepository<Address>(dbContext.Object, _fakeTimeProvider); // Act var actual =
// uot.FindEntities(m => m.AddressId == 2)?.ToArray(); //Assert actual.Should().NotBeEmpty();
// actual?.Length.Should().Be(1); }

// [Test] public void FindEntity_5678() { // Arrange var dbContext =
// MockedDbContext.MockedDbContextAllData(); var uot = new
// GenericCrudRepository<Address>(dbContext.Object, _fakeTimeProvider); // Act var actual =
// uot.FindEntities(m => m.AddressId == 5678)?.ToArray(); //Assert actual.Should().BeEmpty();
// actual?.Length.Should().Be(0); }

// [Test] public async Task GetByIdAsync_1234() { // Arrange var dbContext =
// MockedDbContext.MockedDbContextAllData(); var uot = new
// GenericCrudRepository<Address>(dbContext.Object, _fakeTimeProvider); // Act var actual = await
// uot.GetByIdAsync(m => m.AddressId == 1234); //Assert actual.Should().BeNull(); }

// [Test] public async Task GetByIdAsync_3() { // Arrange var dbContext =
// MockedDbContext.MockedDbContextAllData(); var uot = new
// GenericCrudRepository<Address>(dbContext.Object, _fakeTimeProvider); // Act var actual = await
// uot.GetByIdAsync(m => m.AddressId == 3); //Assert actual.Should().NotBeNull(); }

// [SetUp] public void Setup() { _fakeTimeProvider = new FakeTimeProvider();
// _fakeTimeProvider.SetUtcNow(new DateTimeOffset(new DateTime(2024, 8, 17, 12, 34, 56,
// DateTimeKind.Local))); }

//		[Test]
//		public async Task Update_1()
//		{
//			// Arrange
//			var dbContext = MockedDbContext.MockedDbContextAllData();
//			var uot = new GenericCrudRepository<Address>(dbContext.Object, _fakeTimeProvider);
//			var entity = await uot.GetByIdAsync(m => m.AddressId == 1);
//			// Act
//			entity!.PostalCode = "11111";
//			entity.ModifiedDate = _fakeTimeProvider.GetLocalNow().DateTime;
//			var actual = await uot.UpdateAsync(entity);
//			//Assert
//			actual.Should().NotBeNull();
//			actual.PostalCode.Should().Be(entity.PostalCode);
//			actual.ModifiedDate.Should().Be(_fakeTimeProvider.GetLocalNow().DateTime);
//		}
//	}
//}