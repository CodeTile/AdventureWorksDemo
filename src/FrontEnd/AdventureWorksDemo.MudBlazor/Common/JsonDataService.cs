using Microsoft.Extensions.Caching.Memory;

namespace AdventureWorksDemo.MudBlazor.Common
{
	public interface IJsonDataService
	{
		Task<T?> GetDataAsync<T>(string url);
	}

	public class JsonDataService : IJsonDataService
	{
		public JsonDataService(HttpClient httpClient, IMemoryCache cache)
		{
			_httpClient = httpClient;
			_cache = cache;
		}

		private readonly IMemoryCache _cache;
		private readonly TimeSpan _cacheDuration = TimeSpan.FromMinutes(1);
		private readonly HttpClient _httpClient;

		// Cache duration
		public async Task<T?> GetDataAsync<T>(string url)
		{
			if (_cache.TryGetValue(url, out T cachedData))
			{
				return cachedData; // Return cached data if available
			}

			T? data = await _httpClient.GetFromJsonAsync<T>(url);

			if (data != null)
			{
				_cache.Set(url, data, _cacheDuration); // Cache the data
			}

			return data;
		}
	}
}