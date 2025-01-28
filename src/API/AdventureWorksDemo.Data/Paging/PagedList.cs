using Microsoft.EntityFrameworkCore;

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
			CurrentPage = currentPage;
			TotalPages = (int)Math.Ceiling(count / (double)pageSize);
			PageSize = pageSize;
			TotalCount = count;
			AddRange(items);
		}

		public int CurrentPage { get; set; }

		public int PageSize { get; set; }

		public int TotalCount { get; set; }

		public int TotalPages { get; set; }

		public static async Task<PagedList<T>> CreateAsync(IQueryable<T> source, int pageNumber, int pageSize)
		{
			if (pageNumber <= 0)
				throw new ArgumentOutOfRangeException(nameof(pageNumber), $"Parameter {nameof(pageNumber)} must be positive");
			if (pageSize <= 0)
				throw new ArgumentOutOfRangeException(nameof(pageSize), $"Parameter {nameof(pageSize)} must be positive");
			if (source == null)
				return new PagedList<T>([], 0, pageNumber, pageSize);
			var count = await source.CountAsync();
			var totalPages = (decimal)count % (decimal)pageSize;
			if (pageNumber > totalPages)
			{
				var answer = Math.Ceiling(totalPages);
				var debug = Math.Ceiling((decimal)25);
			}

			var items = await source.Skip((pageNumber - 1) * pageSize).Take(pageSize).ToListAsync();
			return new PagedList<T>(items ?? [], count, pageNumber, pageSize);
		}
	}
}