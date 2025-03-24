using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using AdventureWorksDemo.MudBlazor.Models;

namespace AdventureWorksDemo.MudBlazor.Tests.Models
{
	[TestClass]
	public class SalesSummaryTests
	{
		public SalesSummaryTests()
		{
		}

		[TestMethod]
		public void SalesSummary_ChangingMonth_ShouldResetPeriod()
		{
			// Arrange
			var salesSummary = new SalesSummary { Year = 2023, Month = 5 };
			DateTime initialPeriod = salesSummary.Period;

			// Act
			salesSummary.Month = 6;
			DateTime updatedPeriod = salesSummary.Period;

			// Assert
			Assert.AreNotEqual(initialPeriod, updatedPeriod);
			Assert.AreEqual(new DateTime(2023, 6, 1, 0, 0, 0, DateTimeKind.Utc), updatedPeriod);
		}

		[DataTestMethod]
		[DataRow(2023, 0)]
		[DataRow(2022, 1234)]
		[DataRow(2020, 13)]
		[DataRow(0, 3)]
		[DataRow(-1234, 4)]
		[ExpectedException(typeof(ArgumentOutOfRangeException))]
		public void SalesSummary_Period_ShouldHandleBadMonth(int year, int month)
		{
			// Arrange & act
			var salesSummary = new SalesSummary
			{
				Year = year,
				Month = month,
				OnlineOrderFlag = true,
				SalesCount = 100
			};
			// cause error
			Console.WriteLine(salesSummary.Period);
		}

		[DataTestMethod]
		[DataRow(2023, 1)]
		[DataRow(2022, 5)]
		[DataRow(2020, 12)]
		[DataRow(2019, 7)]
		public void SalesSummary_Period_ShouldReturnCorrectDate(int year, int month)
		{
			// Arrange
			var salesSummary = new SalesSummary
			{
				Year = year,
				Month = month,
				OnlineOrderFlag = true,
				SalesCount = 100
			};

			// Act
			DateTime expectedDate = new(year, month, 1, 0, 0, 0, DateTimeKind.Utc);
			DateTime actualDate = salesSummary.Period;

			// Assert
			Assert.AreEqual(expectedDate, actualDate);
		}

		[TestMethod]
		public void SalesSummary_Properties_ShouldStoreValuesCorrectly()
		{
			// Arrange
			var salesSummary = new SalesSummary
			{
				Year = 2022,
				Month = 12,
				OnlineOrderFlag = false,
				SalesCount = 50
			};

			// Act & Assert
			Assert.AreEqual(2022, salesSummary.Year);
			Assert.AreEqual(12, salesSummary.Month);
			Assert.IsFalse(salesSummary.OnlineOrderFlag);
			Assert.AreEqual(50, salesSummary.SalesCount);
		}
	}
}