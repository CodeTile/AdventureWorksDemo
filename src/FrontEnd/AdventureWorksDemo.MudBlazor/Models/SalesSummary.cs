namespace AdventureWorksDemo.MudBlazor.Models
{
	public record SalesSummary
	{
		private int _month;
		private int _year;
		private DateTime? _cachedPeriod;

		public int Year
		{
			get => _year;
			set
			{
				_year = value;
				_cachedPeriod = null; // Reset cached period
			}
		}

		public int Month
		{
			get => _month;
			set
			{
				if (value is < 1 or > 12)
					throw new ArgumentOutOfRangeException(nameof(Month), "Month must be between 1 and 12.");
				_month = value;
				_cachedPeriod = null; // Reset cached period
			}
		}

		public bool OnlineOrderFlag { get; set; }
		public int SalesCount { get; set; }

		public DateTime Period => _cachedPeriod ??= new DateTime(Year, Month, 1, 0, 0, 0, DateTimeKind.Utc);
	}
}