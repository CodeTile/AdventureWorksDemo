using AdventureWorksDemo.Data.Extentions;
using AdventureWorksDemo.Data.Paging;

namespace AdventureWorksDemo.Data.Tests.Extentions
{
	[TestClass]
	public class QueryExtensionsApplyPagingTests
	{
		private readonly List<string> _data = ["A1", "A2", "A3", "A4", "A5", "B1", "B2", "B3", "B4", "B5", "C1", "C2", "C3", "C4", "C5"];

		//[TestMethod]
		//public void ApplySlice_EmptyQuery_ReturnsDefault()
		//{
		//	// Arrange
		//	var query = Enumerable.Empty<string>().AsQueryable();

		// // Act var result = query.ApplyPageing(new PageingFilter());

		//	// Assert
		//	Assert.AreEqual(Array.Empty<string>(), result);
		//}

		[TestMethod]
		public void ApplySlice_NegativePageSize_ReturnsOriginalQuery()
		{
			// Arrange
			var query = _data.AsQueryable();
			var filterNegativePageSize = new PageingFilter() { PageNumber = 0, PageSize = -2 };
			// Act
			var resultNegativePageSize = query.ApplyPageing(filterNegativePageSize);

			// Assert
			CollectionAssert.AreEqual(_data, resultNegativePageSize.ToList());
		}

		[TestMethod]
		public void ApplySlice_NegativeSkip_ReturnsOriginalQuery()
		{
			// Arrange
			var query = _data.AsQueryable();
			var filterNegativeSkip = new PageingFilter() { PageNumber = -1, PageSize = 2 };
			// Act
			var resultNegativeSkip = query.ApplyPageing(filterNegativeSkip);

			// Assert
			CollectionAssert.AreEqual(_data[0..2], resultNegativeSkip.ToList());
		}


		[TestMethod]
		public void ApplySlice_PageSizeGreaterThanRemaining_ReturnsRemainingElements_WithPagingFilter()
		{
			// Arrange
			var query = _data.AsQueryable();
			var filter = new PageingFilter() { PageNumber = 2, PageSize = 100 };
			// Act
			var result = query.ApplyPageing(filter);

			// Assert
			CollectionAssert.AreEqual(_data[15..15], result.ToList());
		}

		[TestMethod]
		public void ApplySlice_SkipBeyondCount_ReturnsEmpty()
		{
			// Arrange
			var query = _data.AsQueryable();
			var filter = new PageingFilter() { PageNumber = 20, PageSize = 2 };

			// Act
			var result = query.ApplyPageing(filter);

			// Assert
			Assert.AreEqual(0, result.Count());
		}

		[DataRow(0, 2, 0, 2)]
		[DataRow(0, 10, 0, 10)]
		[TestMethod]
		public void ApplySlice_ValidQueryWithSlicing_ReturnsExpectedSlice(int pageNumber, int pageSize, int dataStart, int dataEnd)
		{
			// Arrange
			var query = _data.AsQueryable();
			var filter = new PageingFilter() { PageNumber = pageNumber, PageSize = pageSize };
			// Act
			var result = query.ApplyPageing(filter)!.ToList();

			// Assert
			var expected = _data[dataStart..dataEnd];
			CollectionAssert.AreEqual(expected, result, $"Expected {expected.Count} records.  {result.Count} records returned!");
		}
	}
}