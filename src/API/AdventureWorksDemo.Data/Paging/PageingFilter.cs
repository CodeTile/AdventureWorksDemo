namespace AdventureWorksDemo.Data.Paging
{
	public class PageingFilter
	{
		private int _pageNumber = 1;
		private int _pageSize = 25;
		public string[]? Filter { get; set; } = null;

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
					_pageSize = 25;
			}
		}

		public int Skip
		{ get { return (PageNumber - 1) * PageSize; } }
		public string[]? Sorting { get; set; } = null;
		internal int MaxPageSize { get; set; } = 100;

		internal void VerifyValues()
		{
			if (PageSize < 1)
				PageSize = 25;
			if (PageNumber < 1)
				PageNumber = 1;
		}
	}
}