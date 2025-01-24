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
			var items = await source.Skip((pageNumber - 1) * pageSize).Take(pageSize).ToListAsync();
			return new PagedList<T>(items ?? [], count, pageNumber, pageSize);
		}
	}

	public class PageingFilter
	{
		private int _pageNumber = 1;
		private int _pageSize = 25;

		public int PageNumber
		{
			get => _pageNumber;
			set
			{
				_pageNumber = value;
				if (value < 1)
					_pageNumber = 1;
			}
		}

		public int PageSize
		{
			get => _pageSize;
			set
			{
				_pageSize = (value > MaxPageSize) ? MaxPageSize : value;
				if (_pageSize < 1)
					_pageNumber = 25;
			}
		}

		internal int MaxPageSize { get; set; } = 100;
	}
}