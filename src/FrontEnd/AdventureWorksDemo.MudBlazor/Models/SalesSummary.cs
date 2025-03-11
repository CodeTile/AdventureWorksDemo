namespace AdventureWorksDemo.MudBlazor.Models
{
	public record SalesSummary
	{
		public int Year { get; set; }
		public int Month { get; set; }
		public bool OnlineOrderFlag { get; set; }
		public int SalesCount { get; set; }
		public DateTime Period => new(Year, Month, 1, 0, 0, 0, DateTimeKind.Utc);
	}
}