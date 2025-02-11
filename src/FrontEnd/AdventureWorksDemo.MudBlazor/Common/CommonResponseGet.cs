using System.Net.Mime;
using System.Text;

using AdventureWorksDemo.MudBlazor.Models;

using MudBlazor;

namespace AdventureWorksDemo.MudBlazor.Common
{
	public interface ICommonResponseGet
	{
		Task<GridData<T>> FindAllAsync<T>(GridState<T> state, string defaultSorting, HttpClient httpClient);
	}

	public class CommonResponseGet(IUrl Url) : ICommonResponseGet
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
	}
}