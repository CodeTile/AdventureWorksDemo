using Microsoft.VisualStudio.TestTools.UnitTesting;

using System;

namespace AdventureWorksDemo.MudBlazor.Tests.Models
{
	public record SaleByTerritory
	{
		public string? CountryRegion { get; set; }
		public decimal SalesLastYear { get; set; }
		public decimal SalesYTD { get; set; }
		public double SalesYTDToDisplay => Convert.ToDouble(SalesYTD / 1000000);
		public double SalesLastYearToDisplay => Convert.ToDouble(SalesLastYear / 1000000);
	}

	[TestClass]
	public class SaleByTerritoryTests
	{
		[TestMethod]
		public void SalesYTDToDisplay_ShouldReturnCorrectValue()
		{
			// Arrange
			var sale = new SaleByTerritory { SalesYTD = 5000000m };

			// Act
			double result = sale.SalesYTDToDisplay;

			// Assert
			Assert.AreEqual(5.0, result, 0.0001, "SalesYTDToDisplay calculation is incorrect");
		}

		[TestMethod]
		public void SalesLastYearToDisplay_ShouldReturnCorrectValue()
		{
			// Arrange
			var sale = new SaleByTerritory { SalesLastYear = 3000000m };

			// Act
			double result = sale.SalesLastYearToDisplay;

			// Assert
			Assert.AreEqual(3.0, result, 0.0001, "SalesLastYearToDisplay calculation is incorrect");
		}

		[TestMethod]
		public void SalesYTDToDisplay_ShouldHandleZeroValue()
		{
			// Arrange
			var sale = new SaleByTerritory { SalesYTD = 0m };

			// Act
			double result = sale.SalesYTDToDisplay;

			// Assert
			Assert.AreEqual(0.0, result, 0.0001, "SalesYTDToDisplay should return 0 for zero sales");
		}

		[TestMethod]
		public void SalesLastYearToDisplay_ShouldHandleZeroValue()
		{
			// Arrange
			var sale = new SaleByTerritory { SalesLastYear = 0m };

			// Act
			double result = sale.SalesLastYearToDisplay;

			// Assert
			Assert.AreEqual(0.0, result, 0.0001, "SalesLastYearToDisplay should return 0 for zero sales");
		}

		[TestMethod]
		public void SalesYTDToDisplay_ShouldHandleNegativeValue()
		{
			// Arrange
			var sale = new SaleByTerritory { SalesYTD = -1000000m };

			// Act
			double result = sale.SalesYTDToDisplay;

			// Assert
			Assert.AreEqual(-1.0, result, 0.0001, "SalesYTDToDisplay should return correct value for negative sales");
		}

		[TestMethod]
		public void SalesLastYearToDisplay_ShouldHandleNegativeValue()
		{
			// Arrange
			var sale = new SaleByTerritory { SalesLastYear = -2000000m };

			// Act
			double result = sale.SalesLastYearToDisplay;

			// Assert
			Assert.AreEqual(-2.0, result, 0.0001, "SalesLastYearToDisplay should return correct value for negative sales");
		}
	}
}