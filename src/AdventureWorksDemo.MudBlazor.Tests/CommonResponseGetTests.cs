using System.Net;
using System.Text.Json;

using AdventureWorksDemo.MudBlazor.Common;

using Moq;
using Moq.Protected;

using MudBlazor;

namespace AdventureWorksDemo.MudBlazor.Tests
{
	[TestClass]
	public sealed class CommonResponseGetTests
	{
		private HttpClient? _httpClient;
		private Mock<HttpMessageHandler>? _mockHttpHandler;
		private Mock<IUrl>? _mockUrl;
		private CommonResponseGet? _service;

		[TestMethod]
		public async Task FindAllAsync_ReturnsDataOnSuccess()
		{
			// Arrange
			var testData = new List<TestModel>
			{
				new() { Id = 1, Name = "Test1" },
				new() { Id = 2, Name = "Test2" }
			};

			var jsonResponse = JsonSerializer.Serialize(testData);
			var httpResponse = new HttpResponseMessage
			{
				StatusCode = HttpStatusCode.OK,
				Content = new StringContent(jsonResponse, System.Text.Encoding.UTF8, "application/json")
			};
			httpResponse.Headers.Add("X-Pagination", "CurrentPage:1,PageSize:25,TotalCount:50,TotalPages:2");

			_mockHttpHandler!.Protected()
				.Setup<Task<HttpResponseMessage>>("SendAsync", ItExpr.IsAny<HttpRequestMessage>(), ItExpr.IsAny<CancellationToken>())
				.ReturnsAsync(httpResponse);

			var gridState = new GridState<TestModel> { Page = 0, PageSize = 25 };

			// Act
			var result = await _service!.FindAllAsync(gridState, "Id ASC", _httpClient!);

			// Assert
			Assert.AreEqual(50, result.TotalItems);
			Assert.AreEqual(2, result.Items.Count());
			Assert.AreEqual("Test1", result.Items.First().Name);
		}

		[TestMethod]
		public async Task FindAllAsync_ReturnsEmptyDataOnFailure()
		{
			// Arrange
			var httpResponse = new HttpResponseMessage { StatusCode = HttpStatusCode.BadRequest };

			_mockHttpHandler!.Protected()
				.Setup<Task<HttpResponseMessage>>("SendAsync", ItExpr.IsAny<HttpRequestMessage>(), ItExpr.IsAny<CancellationToken>())
				.ReturnsAsync(httpResponse);

			var gridState = new GridState<TestModel> { Page = 0, PageSize = 25 };

			// Act
			var result = await _service!.FindAllAsync(gridState, "Id ASC", _httpClient!);

			// Assert
			Assert.AreEqual(0, result.TotalItems);
			Assert.AreEqual(0, result.Items.Count());
		}

		[TestInitialize]
		public void Setup()
		{
			_mockUrl = new Mock<IUrl>();
			_mockUrl.Setup(u => u.Administration_ProductDescription).Returns("https://api.example.com/productdescription");

			_mockHttpHandler = new Mock<HttpMessageHandler>();
			_httpClient = new HttpClient(_mockHttpHandler.Object);

			_service = new CommonResponseGet(_mockUrl.Object);
		}

		private class TestModel
		{
			public int Id { get; set; }
			public string? Name { get; set; }
		}
	}
}