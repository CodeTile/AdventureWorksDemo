using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Threading;
using System.Threading.Tasks;
using AdventureWorksDemo.MudBlazor.Common;
using AdventureWorksDemo.MudBlazor.Models;
using MudBlazor;

namespace AdventureWorksDemo.MudBlazor.Tests.Common
{
	[TestClass]
	public class CommonResponseTests
	{
		private CommonResponse? _commonResponse;
		private HttpClient? _httpClient;
		private Mock<IUrl>? _mockUrl;

		[TestMethod]
		public async Task FindAllAsync_ReturnsGridData_WhenResponseIsSuccessful()
		{
			// Arrange
			var gridState = new GridState<ProductDescriptionModel>();
			var mockData = new List<ProductDescriptionModel> { new() { ProductDescriptionId = 1, Description = "Test", ModifiedDate = DateTime.UtcNow } };
			var jsonResponse = JsonSerializer.Serialize(mockData);
			var mockResponse = new HttpResponseMessage
			{
				StatusCode = HttpStatusCode.OK,
				Content = new StringContent(jsonResponse, Encoding.UTF8, "application/json")
			};
			mockResponse.Headers.Add("X-Pagination", "{\"TotalCount\":1}");

			_mockUrl.Setup(u => u.Administration_ProductDescription).Returns("https://api.test.com/products");

			var handler = new MockHttpMessageHandler(_ => Task.FromResult(mockResponse));
			_httpClient = new HttpClient(handler);
			_commonResponse = new CommonResponse(_mockUrl.Object);

			// Act
			var result = await _commonResponse.FindAllAsync(gridState, "Default", _httpClient);

			// Assert
			Assert.IsNotNull(result);
			Assert.AreEqual(1, result.TotalItems);
			Assert.AreEqual(1, result.Items.Count());
		}

		[TestInitialize]
		public void Setup()
		{
			_mockUrl = new Mock<IUrl>();
		}

		[TestMethod]
		public async Task UpdateAsync_ReturnsServiceResult_WhenUpdateFails()
		{
			// Arrange
			var product = new ProductDescriptionModel { ProductDescriptionId = 1, Description = "Updated", ModifiedDate = DateTime.UtcNow };
			var errorJson = JsonSerializer.Serialize(new ServiceResult<ProductDescriptionModel> { IsSuccess = false, IsFailure = true, Message = "Update failed" });
			var mockResponse = new HttpResponseMessage
			{
				StatusCode = HttpStatusCode.BadRequest,
				Content = new StringContent(errorJson, Encoding.UTF8, "application/json")
			};

			_mockUrl.Setup(u => u.GetByModelType(typeof(ProductDescriptionModel))).Returns(new Uri("https://api.test.com/products"));

			var handler = new MockHttpMessageHandler(_ => Task.FromResult(mockResponse));
			_httpClient = new HttpClient(handler);
			_commonResponse = new CommonResponse(_mockUrl.Object);

			// Act
			var result = await _commonResponse.UpdateAsync(product, _httpClient);

			// Assert
			Assert.IsFalse(result.IsSuccess);
			Assert.IsTrue(result.IsFailure);
			Assert.AreEqual("System error!", result.Message);
		}
	}
}