using AdventureWorksDemo.Data.Extentions;
using AdventureWorksDemo.Data.Paging;

namespace AdventureWorksDemo.Data.Tests.Extentions
{
	[TestClass]
	public class QueryExtensionsApplyFilterTests
	{
		private IQueryable<TestEntityApplyFilter> _testData;

		[TestInitialize]
		public void Setup()
		{
			_testData = new List<TestEntityApplyFilter>
			{
				new TestEntityApplyFilter { Id = 1, Name = "Alice", Age = 25 },
				new TestEntityApplyFilter { Id = 2, Name = "Bob", Age = 30 },
				new TestEntityApplyFilter { Id = 3, Name = "Charlie", Age = 35 }
			}.AsQueryable();
		}

		[TestMethod]
		public void ApplyFilters_ShouldFilterByEquals()
		{
			var filter = new PageingFilter { Filter = ["Age | Equals | 30"] };
			var result = _testData.ApplyFilters(filter);
			Assert.IsNotNull(result);
			Assert.AreEqual(1, result.Count());
			Assert.AreEqual("Bob", result.First().Name);
		}

		[TestMethod]
		public void ApplyFilters_ShouldFilterByGreaterThan()
		{
			var filter = new PageingFilter { Filter = ["Age | GreaterThan | 25"] };
			var result = _testData.ApplyFilters(filter);
			Assert.IsNotNull(result);
			Assert.AreEqual(2, result.Count());
		}

		[TestMethod]
		public void ApplyFilters_ShouldFilterByContains()
		{
			var filter = new PageingFilter { Filter = ["Name | Contains | Bob"] };
			var result = _testData.ApplyFilters(filter);
			Assert.IsNotNull(result);
			Assert.AreEqual(1, result.Count());
			Assert.AreEqual("Bob", result.First().Name);
		}

		[TestMethod]
		[ExpectedException(typeof(ArgumentException))]
		public void ApplyFilters_ShouldThrowExceptionForInvalidFilterFormat()
		{
			var filter = new PageingFilter { Filter = ["InvalidFormat"] };
			_testData.ApplyFilters(filter);
		}

		[TestMethod]
		[ExpectedException(typeof(ArgumentException))]
		public void ApplyFilters_ShouldThrowExceptionForInvalidExpression()
		{
			var filter = new PageingFilter { Filter = ["Age | InvalidOp | 30"] };
			_testData.ApplyFilters(filter);
		}
		public class TestEntityApplyFilter
		{
			public int Id { get; set; }
			public string Name { get; set; }
			public int Age { get; set; }
		}
	}
}