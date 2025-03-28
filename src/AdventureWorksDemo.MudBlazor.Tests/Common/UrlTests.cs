using System;

using AdventureWorksDemo.MudBlazor.Common;

using Microsoft.Extensions.Configuration;
using Microsoft.VisualStudio.TestTools.UnitTesting;

using AdventureWorksDemo.MudBlazor.Models;
using Moq;

namespace AdventureWorksDemo.MudBlazor.Tests.Common
{
	[TestClass]
	public class UrlTests
	{
		private Mock<IConfiguration> _configurationMock;
		private IUrl _url;

		[TestMethod]
		public void Administration_ProductDescription_ShouldReturnCorrectUrl()
		{
			// Act
			var result = _url.Administration_ProductDescription;

			// Assert
			Assert.AreEqual("https://api.example.com/product/description", result);
		}

		[TestMethod]
		public void GetByModelType_WithProductDescriptionModel_ShouldReturnCorrectUri()
		{
			// Act
			var result = _url.GetByModelType(typeof(ProductDescriptionModel));

			// Assert
			Assert.AreEqual(new Uri("https://api.example.com/product/description"), result);
		}

		[TestMethod]
		[ExpectedException(typeof(ArgumentOutOfRangeException))]
		public void GetByModelType_WithUnknownType_ShouldThrowArgumentOutOfRangeException()
		{
			// Act
			_url.GetByModelType(typeof(string));
		}

		[TestMethod]
		public void Report_OnlineVsOffLine_ShouldReturnCorrectUrl()
		{
			// Act
			var result = _url.Report_OnlineVsOffLine;

			// Assert
			Assert.AreEqual("https://api.example.com/reports/online-vs-offline", result);
		}

		[TestMethod]
		public void Report_SalesByTerritory_ShouldReturnCorrectUrl()
		{
			// Act
			var result = _url.Report_SalesByTerritory;

			// Assert
			Assert.AreEqual("https://api.example.com/reports/sales-by-territory", result);
		}

		[TestInitialize]
		public void Setup()
		{
			_configurationMock = new Mock<IConfiguration>();

			_configurationMock.Setup(x => x["Api:base"]).Returns("https://api.example.com/");
			_configurationMock.Setup(x => x["Api:productdescription"]).Returns("product/description");
			_configurationMock.Setup(x => x["Api:Reports:Base"]).Returns("reports/");
			_configurationMock.Setup(x => x["Api:Reports:OnlineVsOffLine"]).Returns("online-vs-offline");
			_configurationMock.Setup(x => x["Api:Reports:SalesByTerritory"]).Returns("sales-by-territory");

			_url = new Url(_configurationMock.Object);
		}
	}
}