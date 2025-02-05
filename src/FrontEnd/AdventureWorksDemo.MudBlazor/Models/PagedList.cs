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
}