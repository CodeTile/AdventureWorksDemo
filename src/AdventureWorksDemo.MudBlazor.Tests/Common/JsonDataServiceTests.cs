using System.Net;
using System.Net.Http.Json;

using AdventureWorksDemo.MudBlazor.Common;

using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Primitives;

using Moq;

namespace AdventureWorksDemo.MudBlazor.Tests.Common
{
	[TestClass]
	public class JsonDataServiceTests
	{
		private HttpClient _httpClient;
		private JsonDataService _jsonDataService;
		private Mock<IMemoryCache> _mockCache;
		private MockCacheEntry _mockCacheEntry;
		private MockHttpMessageHandler _mockHttpMessageHandler;

		[TestMethod]
		public async Task GetDataAsync_CallsHttpClient_WhenDataNotInCache()
		{
			// Arrange
			string url = "https://api.example.com/data";
			var expectedData = new TestData { Id = 1, Name = "New Item" };

			var responseMessage = new HttpResponseMessage(HttpStatusCode.OK)
			{
				Content = JsonContent.Create(expectedData)
			};

			_mockHttpMessageHandler.SetResponse(responseMessage);

			object cacheEntry;
			_mockCache.Setup(x => x.TryGetValue(url, out cacheEntry)).Returns(false);
			_mockCache.Setup(x => x.CreateEntry(It.IsAny<object>())).Returns(_mockCacheEntry);

			// Act
			var result = await _jsonDataService.GetDataAsync<TestData>(url, _httpClient);

			// Assert
			Assert.IsNotNull(result);
			Assert.AreEqual(expectedData.Id, result.Id);
			Assert.AreEqual(expectedData.Name, result.Name);
		}

		[TestMethod]
		public async Task GetDataAsync_ReturnsCachedData_WhenAvailable()
		{
			// Arrange
			string url = "https://api.example.com/data";
			var expectedData = new TestData { Id = 1, Name = "Cached Item" };
			object cacheEntry = expectedData;

			_mockCache.Setup(x => x.TryGetValue(url, out cacheEntry)).Returns(true);

			// Act
			var result = await _jsonDataService.GetDataAsync<TestData>(url, _httpClient);

			// Assert
			Assert.IsNotNull(result);
			Assert.AreEqual(expectedData.Id, result.Id);
			Assert.AreEqual(expectedData.Name, result.Name);
		}

		[TestInitialize]
		public void Setup()
		{
			_mockCache = new Mock<IMemoryCache>();
			_mockCacheEntry = new MockCacheEntry();
			_mockHttpMessageHandler = new MockHttpMessageHandler();
			_httpClient = new HttpClient(_mockHttpMessageHandler);
			_jsonDataService = new JsonDataService(_mockCache.Object);
		}

		// Custom class to mock CacheEntry
		public class MockCacheEntry : ICacheEntry
		{
			public DateTimeOffset? AbsoluteExpiration { get; set; }
			public TimeSpan? AbsoluteExpirationRelativeToNow { get; set; }
			public IList<IChangeToken> ExpirationTokens { get; } = new List<IChangeToken>();
			public object Key { get; set; }
			public IList<PostEvictionCallbackRegistration> PostEvictionCallbacks { get; } = new List<PostEvictionCallbackRegistration>();
			public CacheItemPriority Priority { get; set; }
			public long? Size { get; set; }
			public TimeSpan? SlidingExpiration { get; set; }
			public object Value { get; set; }

			public void Dispose()
			{ }
		}

		// Custom class to mock HttpMessageHandler
		public class MockHttpMessageHandler : HttpMessageHandler
		{
			private HttpResponseMessage _response;

			public void SetResponse(HttpResponseMessage response)
			{
				_response = response;
			}

			protected override Task<HttpResponseMessage> SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
			{
				return Task.FromResult(_response);
			}
		}

		public class TestData
		{
			public int Id { get; set; }
			public string Name { get; set; }
		}
	}
}