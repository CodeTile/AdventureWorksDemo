using Microsoft.Extensions.Caching.Memory;

namespace AdventureWorksDemo.MudBlazor.Common
{
	public interface IJsonDataService
	{
		Task<T?> GetDataAsync<T>(string url, HttpClient httpClient);
	}

	public class JsonDataService(IMemoryCache _cache) : IJsonDataService
	{
		private readonly TimeSpan _cacheDuration = TimeSpan.FromMinutes(1);

		// Cache duration
		public async Task<T?> GetDataAsync<T>(string url, HttpClient httpClient)
		{
			if (_cache.TryGetValue(url, out T cachedData))
			{
				return cachedData; // Return cached data if available
			}

			T? data = await httpClient.GetFromJsonAsync<T>(url);

			if (data != null)
			{
				_cache.Set(url, data, _cacheDuration); // Cache the data
			}

			return data;
		}
	}
}