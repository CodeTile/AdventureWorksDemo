using AdventureWorksDemo.Data.DbContexts;
using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Repository;

using FluentAssertions;

using Microsoft.EntityFrameworkCore;

using MockQueryable;
using MockQueryable.Moq;

namespace AdventureWorksDemo.Data.Tests.MSTest
{
	[TestClass]
	public sealed class GenericCrudRepositoryTests : IDisposable
	{
		public GenericCrudRepositoryTests()
		{
			//create data
			TestEntities = [ProductDescription1, ProductDescription2];
			//build mock
			var mockDbSet = TestEntities.AsQueryable().BuildMockDbSet();
			//setup the mock as Queryable for Moq

			var options = new DbContextOptionsBuilder<AdventureWorksDbContext>()
				.UseInMemoryDatabase(databaseName: Guid.NewGuid().ToString())
				.Options;

			_dbContext = new AdventureWorksDbContext(options);
			_repository = new GenericCrudRepository<ProductDescription>(_dbContext);
		}

		private readonly GenericCrudRepository<ProductDescription> _repository;

		private readonly ProductDescription ProductDescription1 = new() { ProductDescriptionId = 1, Description = "Ping Pong", Rowguid = ToGuid(1), ModifiedDate = Convert.ToDateTime("21 Jan 2024 12:34:56") };
		private readonly ProductDescription ProductDescription2 = new() { ProductDescriptionId = 2, Description = "How Now", Rowguid = ToGuid(2), ModifiedDate = Convert.ToDateTime("21 Feb 2024 12:34:56") };
		private readonly ProductDescription[] TestEntities;

		private AdventureWorksDbContext _dbContext;

		public static Guid ToGuid(int value)
		{
			byte[] bytes = new byte[16];
			BitConverter.GetBytes(value).CopyTo(bytes, 0);
			return new Guid(bytes);
		}

		[TestMethod]
		public async Task AddAsync_Should_AddEntitySuccessfully()
		{
			// Arrange
			var entity = TestEntities[0];

			// Act
			var actual = await _repository.AddAsync(entity);

			// Assert
			actual.IsSuccess.Should().BeTrue();
			actual.Value.Should().BeEquivalentTo(entity);
			_dbContext.Set<ProductDescription>().Should().Contain(entity);
		}

		[TestMethod]
		public async Task AddBatchAsync_Should_AddMultipleEntitiesSuccessfully()
		{
			// Arrange

			// Act
			var actual = await _repository.AddBatchAsync(TestEntities.AsQueryable());

			// Assert
			actual.IsSuccess.Should().BeTrue();
			actual.Value.Should().BeEquivalentTo(TestEntities);
			_dbContext.Set<ProductDescription>().Should().Contain(TestEntities);
		}

		[TestMethod]
		public async Task DeleteAsync_Should_RemoveMatchingEntities()
		{
			// Arrange

			_dbContext.Set<ProductDescription>().AddRange(TestEntities);
			await _dbContext.SaveChangesAsync();

			// Act
			var actual = await _repository.DeleteAsync(e => e.Description.Contains(TestEntities[1].Description));

			// Assert
			actual.IsSuccess.Should().BeTrue();
			_dbContext.Set<ProductDescription>().Should().NotContain(e => e.Description == "Entity1");
			_dbContext.Set<ProductDescription>().Should().Contain(e => e.Description.Contains(TestEntities[0].Description));
		}

		public void Dispose()
		{
			_dbContext!.Dispose();
		}

		[TestMethod]
		public void FindEntities_Should_ReturnFilteredactuals()
		{
			// Arrange

			_dbContext.Set<ProductDescription>().AddRange(TestEntities);
			_dbContext.SaveChanges();

			// Act
			var actual = _repository.FindEntities(e => e.Description.Contains(TestEntities[1].Description));

			// Assert
			actual.Should().NotBeNull();
			actual.Should().HaveCount(1);
		}

		[TestMethod]
		public async Task GetByIdAsync_Should_ReturnEntityWhenFound()
		{
			// Arrange
			var entity = TestEntities[0];
			_dbContext.Set<ProductDescription>().Add(entity);
			await _dbContext.SaveChangesAsync();

			// Act
			var actual = await _repository.GetByIdAsync(e => e.ProductDescriptionId == 1);

			// Assert
			actual.Should().NotBeNull();
			actual.Should().BeEquivalentTo(entity);
		}

		[TestInitialize]
		public void TestInitialize()
		{
		}

		[TestMethod]
		public async Task UpdateAsync_Should_UpdateEntitySuccessfully()
		{
			// Arrange
			var entity = TestEntities[0];
			_dbContext.Set<ProductDescription>().Add(entity);
			await _dbContext.SaveChangesAsync();

			entity.Description = "UpdatedName";

			// Act
			var actual = await _repository.UpdateAsync(entity);

			// Assert
			actual.IsSuccess.Should().BeTrue();
			_dbContext.Set<ProductDescription>().FirstOrDefault(e => e.ProductDescriptionId == 1)?.Description.Should().Be("UpdatedName");
		}
	}
}