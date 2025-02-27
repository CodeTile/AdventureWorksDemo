namespace AdventureWorksDemo.Data.Models.Reports
{
	public record SalesSummaryByYear
	{
		public int OrderYear { get; set; }
		public bool OnlineOrderFlag { get; set; }
		public int SalesCount { get; set; }
	}
}