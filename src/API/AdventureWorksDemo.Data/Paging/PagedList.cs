using Microsoft.EntityFrameworkCore;
using AdventureWorksDemo.Data.Extentions;

namespace AdventureWorksDemo.Data.Paging
{
	public interface IPagedList
	{
		int CurrentPage { get; set; }
		int PageSize { get; set; }
		int TotalCount { get; set; }
		int TotalPages { get; set; }
	}

	/// <summary>
	/// https://bsavindu1998.medium.com/using-a-custom-pagelist-class-for-generic-pagination-in-net-core-2403a14c0c15
	/// </summary>
	public class PagedList<T> : List<T>, IPagedList
	{
		//TODO: paging needs improving.
		public PagedList()
		{ }

		public PagedList(IEnumerable<T> items, int count, int currentPage, int pageSize)
		{
			TotalPages = (int)Math.Ceiling(count / (double)pageSize);
			CurrentPage = (currentPage > TotalPages) ? TotalPages : currentPage;
			PageSize = pageSize;
			TotalCount = count;
			AddRange(items);
		}

		/// <summary>
		/// zero index, for example the first page is page 0
		/// </summary>
		public int CurrentPage { get; set; }

		public int PageSize { get; set; }

		public int TotalCount { get; set; }

		public int TotalPages { get; set; }

		public static int CalculateLastPageNumber(int recordCount, int pageSize)
		{
			if (recordCount < pageSize)
				return 0;
			return (int)Math.Floor((decimal)recordCount / (decimal)pageSize);
		}

		public static async Task<PagedList<T>> CreateAsync(IQueryable<T>? source, PageingFilter filter)
		{
			filter.Sanitise();
			if (source == null)
				return new PagedList<T>([], 0, 0, filter.PageSize);
			var count = await source.CountAsync();
			var lastPageNumber = CalculateLastPageNumber(count, filter.PageSize);
			if (filter.PageNumber > lastPageNumber)
				filter.PageNumber = lastPageNumber;
			var items = await source.ApplyPageing<T>(filter)!.ToListAsync();

			return new PagedList<T>(items ?? [], count, filter.PageNumber, filter.PageSize);
		}
	}
}