using Microsoft.EntityFrameworkCore;

namespace AdventureWorksDemo.Data.Paging
{
    /// <summary>
    /// https://bsavindu1998.medium.com/using-a-custom-pagelist-class-for-generic-pagination-in-net-core-2403a14c0c15
    /// </summary>
    public class PagedList<T> : List<T>
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
            var count = await source.CountAsync();
            var items = await source.Skip(pageNumber * pageSize).Take(pageSize).ToListAsync();
            return new PagedList<T>(items, count, pageNumber, pageSize);
        }
    }

    public class PageingFilter
    {
        private int _pageSize = 25;
        public int MaxPageSize { get; set; } = 100;
        public int PageNumber { get; set; } = 1;

        public int PageSize
        {
            get => _pageSize;
            set => _pageSize = (value > MaxPageSize) ? MaxPageSize : value;
        }
    }
}