using MudBlazor;

namespace AdventureWorksDemo.MudBlazor.Models
{
	public class PagedList
	{
		public int CurrentPage { get; set; }
		public int PageSize { get; set; }
		public int TotalCount { get; set; }
		public int TotalPages { get; set; }

		public static PagedList FromIEnumerable(string? value)
		{
			if (value == null)
				return new PagedList();
			var values = value!.Split(',');
			return new PagedList()
			{
				CurrentPage = PagedList.ExtractValue(values, nameof(CurrentPage)),
				PageSize = PagedList.ExtractValue(values, nameof(PageSize)),
				TotalCount = PagedList.ExtractValue(values, nameof(TotalCount)),
				TotalPages = PagedList.ExtractValue(values, nameof(TotalPages)),
			}
				;
		}

		private static int ExtractValue(string[] values, string key)
		{
			string? extracted = values.SingleOrDefault(m => m.Contains(key, StringComparison.CurrentCultureIgnoreCase))?.Split(':')[1].Replace('}', ' ');

			return int.Parse(extracted ?? "0");
		}
	}

	public class PageingFilter
	{
		public string[]? Filter { get; set; } = null;
		public int PageNumber { get; set; } = 1;
		public int PageSize { get; set; } = 25;
		public string[]? Sorting { get; set; } = null;

		public static PageingFilter SetByGridState<T>(GridState<T> state)
		{
			var filters = state.FilterDefinitions;
			var filterArray = (from IFilterDefinition<T> filter in filters
							   select $"{filter!.Column!.PropertyName} | {filter.Operator} | {filter.Value}").ToArray();

			return new PageingFilter()
			{
				PageNumber = state.Page,
				PageSize = state.PageSize,
				Filter = filterArray,
				Sorting = SortingArray(state.SortDefinitions),
			};
		}

		private static string DescendingText(bool isDescending) => isDescending ? "DESC" : "";

		private static string[]? SortingArray<T>(ICollection<SortDefinition<T>>? sortDefinitions)
		{
			if (sortDefinitions == null || sortDefinitions.Count == 0)
				return null;

			return (from m in sortDefinitions
					select $"{m.SortBy} | {DescendingText(m.Descending)}"
				).ToArray();
		}
	}
}