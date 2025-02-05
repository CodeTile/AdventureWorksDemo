using AdventureWorksDemo.Data.Extentions;
using AdventureWorksDemo.Data.Paging;

namespace AdventureWorksDemo.Data.Tests.Extentions
{
	[TestClass]
	public class QueryExtensionsApplyFilterTests
	{
		private IQueryable<TestEntityApplyFilter>? _testData;

		[TestInitialize]
		public void Setup()
		{
			_testData = new List<TestEntityApplyFilter>
			{
				new() { Id = 1, Name = "Alice", Age = 25 },
				new() { Id = 2, Name = "Bob", Age = 30 },
				new() { Id = 3, Name = "Charlie", Age = 35 }
			}.AsQueryable();
		}

		[TestMethod]
		public void ApplyFiltersShouldFilterByEquals()
		{
			var filter = new PageingFilter { Filter = ["Age | Equals | 30"] };
			var result = _testData!.ApplyFilters(filter);
			Assert.IsNotNull(result);
			Assert.AreEqual(1, result.Count());
			Assert.AreEqual("Bob", result.First().Name);
		}

		[TestMethod]
		public void ApplyFiltersShouldFilterByGreaterThan()
		{
			var filter = new PageingFilter { Filter = ["Age | GreaterThan | 25"] };
			var result = _testData!.ApplyFilters(filter);
			Assert.IsNotNull(result);
			Assert.AreEqual(2, result.Count());
		}

		[TestMethod]
		public void ApplyFiltersShouldFilterByContains()
		{
			var filter = new PageingFilter { Filter = ["Name | Contains | Bob"] };
			var result = _testData!.ApplyFilters(filter);
			Assert.IsNotNull(result);
			Assert.AreEqual(1, result.Count());
			Assert.AreEqual("Bob", result.First().Name);
		}

		[TestMethod]
		public void ApplyFiltersShouldThrowExceptionForInvalidFilterFormat()
		{
			var filter = new PageingFilter { Filter = ["InvalidFormat"] };
			Assert.ThrowsException<ArgumentException>(() => _testData!.ApplyFilters(filter));
		}

		[TestMethod]
		public void ApplyFiltersShouldThrowExceptionForInvalidExpression()
		{
			var filter = new PageingFilter { Filter = ["Age | InvalidOp | 30"] };
			Assert.ThrowsException<ArgumentException>(() => _testData!.ApplyFilters(filter));
		}
		public class TestEntityApplyFilter
		{
			public int Id { get; set; }
			public string? Name { get; set; }
			public int Age { get; set; }
		}
	}
}