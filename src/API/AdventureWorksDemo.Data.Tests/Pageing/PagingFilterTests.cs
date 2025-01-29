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
			Assert.AreEqual(1, filter.PageNumber);
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
		public void Skip_CalculatesCorrectly()
		{
			// Arrange
			var filter = new PageingFilter { PageNumber = 3, PageSize = 20 };

			// Assert
			Assert.AreEqual(40, filter.Skip);
		}

		[TestMethod]
		public void VerifyValues_ResetsInvalidValues()
		{
			// Arrange
			var filter = new PageingFilter { PageNumber = 0, PageSize = 0 };

			// Act
			filter.VerifyValues();

			// Assert
			Assert.AreEqual(1, filter.PageNumber);
			Assert.AreEqual(25, filter.PageSize);
		}
	}
}