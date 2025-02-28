namespace AdventureWorksDemo.Data.Models.Reports
{
	public record SalesSummary
	{
		public int Year { get; set; }
		public int Month { get; set; }
		public bool OnlineOrderFlag { get; set; }
		public int SalesCount { get; set; }
	}
}