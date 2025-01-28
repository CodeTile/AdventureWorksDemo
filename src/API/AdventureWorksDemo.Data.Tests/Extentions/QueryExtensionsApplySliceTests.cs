using AdventureWorksDemo.Data.Paging;
using AdventureWorksDemo.Data.QueryExtentions;

namespace AdventureWorksDemo.Data.Tests.Extentions
{
	[TestClass]
	public class QueryExtensionsApplySliceTests
	{
		private readonly List<string> _data = ["A1", "A2", "A3", "A4", "A5", "B1", "B2", "B3", "B4", "B5", "C1", "C2", "C3", "C4", "C5"];

		[TestMethod]
		public void ApplySlice_EmptyQuery_ReturnsDefault()
		{
			// Arrange
			var query = Enumerable.Empty<string>().AsQueryable();

			// Act
			var result = query.ApplySlice(0, 10);

			// Assert
			Assert.IsNull(result);
		}

		[TestMethod]
		public void ApplySlice_EmptyQuery_ReturnsDefault_WithPageingFilter()
		{
			// Arrange
			var query = Enumerable.Empty<string>().AsQueryable();

			// Act
			var result = query.ApplySlice(new PageingFilter());

			// Assert
			Assert.IsNull(result);
		}

		[TestMethod]
		public void ApplySlice_NegativeSkipOrPageSize_ReturnsOriginalQuery()
		{
			// Arrange
			var query = _data.AsQueryable();

			// Act
			var resultNegativeSkip = query.ApplySlice(-1, 2);
			var resultNegativePageSize = query.ApplySlice(1, -2);

			// Assert
			CollectionAssert.AreEqual(query.ToList(), resultNegativeSkip.ToList());
			CollectionAssert.AreEqual(query.ToList(), resultNegativePageSize.ToList());
		}

		[TestMethod]
		public void ApplySlice_NegativeSkipOrPageSize_ReturnsOriginalQuery_WithPageingFilter()
		{
			// Arrange
			var query = _data.AsQueryable();
			var filterNegativeSkip = new PageingFilter() { PageNumber = -1, PageSize = 2 };
			var filterNegativePageSize = new PageingFilter() { PageNumber = 1, PageSize = -2 };
			// Act
			var resultNegativeSkip = query.ApplySlice(filterNegativeSkip);
			var resultNegativePageSize = query.ApplySlice(filterNegativePageSize);

			// Assert
			CollectionAssert.AreEqual(_data[0..2], resultNegativeSkip.ToList());
			CollectionAssert.AreEqual(_data, resultNegativePageSize.ToList());
		}

		[TestMethod]
		public void ApplySlice_NullQuery_ReturnsDefault()
		{
			// Arrange
			IQueryable<string>? query = null;

			// Act
			var result = query!.ApplySlice(0, 10);

			// Assert
			Assert.IsNull(result);
		}

		[TestMethod]
		public void ApplySlice_NullQuery_ReturnsDefault_WithPageingFilter()
		{
			// Arrange
			IQueryable<string>? query = null;
			var filter = new PageingFilter() { PageNumber = 1, PageSize = 5 };
			// Act
			var result = query!.ApplySlice(filter);

			// Assert
			Assert.IsNull(result);
		}

		[TestMethod]
		public void ApplySlice_PageSizeGreaterThanRemaining_ReturnsRemainingElements()
		{
			// Arrange
			var query = _data.AsQueryable();

			// Act
			var result = query.ApplySlice(2, 100);

			// Assert
			CollectionAssert.AreEqual(_data[2..15], result.ToList());
		}

		[TestMethod]
		public void ApplySlice_PageSizeGreaterThanRemaining_ReturnsRemainingElements_WithPagingFilter()
		{
			// Arrange
			var query = _data.AsQueryable();
			var filter = new PageingFilter() { PageNumber = 2, PageSize = 100 };
			// Act
			var result = query.ApplySlice(filter);

			// Assert
			CollectionAssert.AreEqual(_data[15..15], result.ToList());
		}

		[TestMethod]
		public void ApplySlice_SkipBeyondCount_ReturnsEmpty()
		{
			// Arrange
			var query = _data.AsQueryable();

			// Act
			var result = query.ApplySlice(20, 2);

			// Assert
			Assert.AreEqual(0, result.Count());
		}

		[TestMethod]
		public void ApplySlice_SkipBeyondCount_ReturnsEmpty_WithPageingFilter()
		{
			// Arrange
			var query = _data.AsQueryable();
			var filter = new PageingFilter() { PageNumber = 20, PageSize = 2 };

			// Act
			var result = query.ApplySlice(filter);

			// Assert
			Assert.AreEqual(0, result.Count());
		}

		[TestMethod]
		public void ApplySlice_ValidQueryWithSlicing_ReturnsExpectedSlice()
		{
			// Arrange
			var query = _data.AsQueryable();

			// Act
			var result = query.ApplySlice(1, 2);

			// Assert
			CollectionAssert.AreEqual(_data[1..3], result.ToList());
		}

		[DataRow(1, 2, 0, 2)]
		[DataRow(1, 10, 0, 10)]
		[TestMethod]
		public void ApplySlice_ValidQueryWithSlicing_ReturnsExpectedSlice_WithPageingFilter(int pageNumber, int pageSize, int dataStart, int dataEnd)
		{
			// Arrange
			var query = _data.AsQueryable();
			var filter = new PageingFilter() { PageNumber = pageNumber, PageSize = pageSize };
			// Act
			var result = query.ApplySlice(filter);

			// Assert
			CollectionAssert.AreEqual(_data[dataStart..dataEnd], result.ToList());
		}
	}
}