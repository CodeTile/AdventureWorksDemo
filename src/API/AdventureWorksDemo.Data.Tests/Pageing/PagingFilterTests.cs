using Microsoft.VisualStudio.TestTools.UnitTesting;
using AdventureWorksDemo.Data.Paging;

namespace AdventureWorksDemo.Tests.Data.Paging
{
	[TestClass]
	public class PagingFilterTests
	{
		[TestMethod]
		public void PageNumber_SetNegativeValue_ResetsToOne()
		{
			// Arrange
			var filter = new PageingFilter { PageNumber = -5 };

			// Assert
			Assert.AreEqual(0, filter.PageNumber);
		}

		[TestMethod]
		public void PageSize_SetNegativeValue_ResetsToDefault()
		{
			// Arrange
			var filter = new PageingFilter { PageSize = -10 };

			// Assert
			Assert.AreEqual(25, filter.PageSize);
		}

		[TestMethod]
		public void PageSize_SetValueAboveMax_SetsToMaxPageSize()
		{
			// Arrange
			var filter = new PageingFilter { PageSize = 150 };

			// Assert
			Assert.AreEqual(100, filter.PageSize);
		}

		[TestMethod]
		public void Sanitise_ResetsInvalidValues()
		{
			// Arrange
			var filter = new PageingFilter { PageNumber = 0, PageSize = 0 };

			// Act
			filter.Sanitise();

			// Assert
			Assert.AreEqual(0, filter.PageNumber);
			Assert.AreEqual(25, filter.PageSize);
		}

		[DataRow(0, 5, 0)]
		[DataRow(0, 20, 0)]
		[DataRow(1, 20, 20)]
		[DataRow(2, 20, 40)]
		[TestMethod]
		public void Skip_CalculatesCorrectly(int pageNumber, int pageSize, int expectedSkip)
		{
			// Arrange
			var filter = new PageingFilter { PageNumber = pageNumber, PageSize = pageSize };

			// Assert
			Assert.AreEqual(expectedSkip, filter.Skip);
		}
	}
}