using Microsoft.Extensions.Caching.Memory;

namespace AdventureWorksDemo.MudBlazor.Common
{
	public interface IJsonDataService
	{
		Task<T?> GetDataAsync<T>(string url, HttpClient httpClient);
	}

	public class JsonDataService(IMemoryCache _cache, ILogger<JsonDataService>? _logger) : IJsonDataService
	{
		private readonly TimeSpan _cacheDuration = TimeSpan.FromMinutes(1);

		// Cache duration
		public async Task<T?> GetDataAsync<T>(string url, HttpClient httpClient)
		{
			if (string.IsNullOrWhiteSpace(url))
				throw new ArgumentException("URL cannot be null or empty.", nameof(url));

			if (_cache.TryGetValue(url, out T? cachedData))
			{
				_logger?.LogInformation("Cache hit for {Url}", url);
				return cachedData; // Return cached data if available
			}

			try
			{
				_logger?.LogInformation("Fetching data from {Url}", url);
				T? data = await httpClient.GetFromJsonAsync<T>(url);

				if (!EqualityComparer<T>.Default.Equals(data, default)) // Compare using EqualityComparer

				{
					_cache.Set(url, data, _cacheDuration);
				}

				return data;
			}
#pragma warning disable S2139 // Either log this exception and handle it, or rethrow it with some contextual information
			catch (HttpRequestException ex)
			{
				_logger?.LogError(ex, "HTTP request failed for {Url}", url);
				throw;
			}
			catch (Exception ex)
			{
				_logger?.LogError(ex, "Unexpected error fetching data from {Url}", url);
				throw;
			}
#pragma warning restore S2139 // Re-enable warning
		}
	}
}