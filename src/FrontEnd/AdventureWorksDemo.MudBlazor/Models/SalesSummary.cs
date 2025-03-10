namespace AdventureWorksDemo.MudBlazor.Models
{
	public record SalesSummary
	{
		public int Year { get; set; }
		public int Month { get; set; }
		public bool OnlineOrderFlag { get; set; }
		public int SalesCount { get; set; }
		public DateTime Period => new(Year, Month, 1, 0, 0, 0, DateTimeKind.Utc);
		////public override int GetHashCode()
		////{
		////	return HashCode.Combine(Year, Month, OnlineOrderFlag);
		////}

		////public int CompareTo(SalesSummary? other)
		////{
		////	if (other is null) return 1;

		////	// Sorting by Year, then Month, then OnlineOrderFlag, then SalesCount
		////	int yearComparison = Year.CompareTo(other.Year);
		////	if (yearComparison != 0) return yearComparison;

		////	int monthComparison = Month.CompareTo(other.Month);
		////	if (monthComparison != 0) return monthComparison;

		////	return OnlineOrderFlag.CompareTo(other.OnlineOrderFlag);
		////}
	}
}