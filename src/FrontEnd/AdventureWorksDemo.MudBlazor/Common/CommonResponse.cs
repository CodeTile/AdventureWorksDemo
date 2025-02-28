using System.Net;
using System.Net.Mime;
using System.Text;
using System.Text.Json;

using AdventureWorksDemo.MudBlazor.Models;

using MudBlazor;

namespace AdventureWorksDemo.MudBlazor.Common
{
	public interface ICommonResponseGet
	{
		Task<GridData<T>> FindAllAsync<T>(GridState<T> state, string defaultSorting, HttpClient httpClient);

		Task ReportOnlineVsOfflineSales(HttpClient httpClient, int isOnline);

		Task<IServiceResult<T>> UpdateAsync<T>(T item, HttpClient httpClient);
	}

	public class CommonResponse(IUrl Url) : ICommonResponseGet
	{
		public async Task<GridData<T>> FindAllAsync<T>(GridState<T> state, string defaultSorting, HttpClient httpClient)
		{
			PageingFilter filter = PageingFilter.SetByGridState<T>(state, defaultSorting);

			var request = new HttpRequestMessage
			{
				Method = HttpMethod.Get,
				RequestUri = new Uri(Url.Administration_ProductDescription),
				Content = new StringContent(filter.ToJSON(),
											Encoding.UTF8,
											MediaTypeNames.Application.Json),
			};

			PagedList paging = new();
			IEnumerable<T> data = [];

			var response = await httpClient.SendAsync(request).ConfigureAwait(false);
			if (response.IsSuccessStatusCode)
			{
				data = (await response!.Content!.ReadFromJsonAsync<List<T>>()) ?? [];
				paging = PagedList.FromIEnumerable(response.Headers.GetValues("X-Pagination").SingleOrDefault());
			}

			return new GridData<T>
			{
				TotalItems = paging.TotalCount,
				Items = data,
			};
		}

		public async Task ReportOnlineVsOfflineSales(HttpClient httpClient, int isOnline)
		{
			var url = Url.Report_OnlineVsOffLine;
		}

		public async Task<IServiceResult<T>> UpdateAsync<T>(T item, HttpClient httpClient)
		{
			var json = System.Text.Json.JsonSerializer.Serialize<T>(item);
			var request = new HttpRequestMessage
			{
				Method = HttpMethod.Put,
				RequestUri = Url.GetByModelType(item!.GetType()),
				Content = new StringContent(json,
											Encoding.UTF8,
											MediaTypeNames.Application.Json),
			};

			var response = await httpClient.SendAsync(request).ConfigureAwait(false);
			if (response.IsSuccessStatusCode)
			{
				// Handle BadRequest and extract message
				var errorContent = await response.Content.ReadAsStringAsync();
				return JsonSerializer.Deserialize<ServiceResult<T>>(errorContent, DeserialiseOptions()) ?? new ServiceResult<T>() { Value = item, IsFailure = true, IsSuccess = false };
			}
			else
				return new ServiceResult<T>() { Value = item, IsFailure = true, IsSuccess = false, Message = "System error!" };
		}

		private static JsonSerializerOptions DeserialiseOptions() => new()
		{
			PropertyNameCaseInsensitive = true // ✅ Allows matching lowercase JSON keys
		};
	}
}