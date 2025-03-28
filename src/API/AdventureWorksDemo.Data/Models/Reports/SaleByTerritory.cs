namespace AdventureWorksDemo.Data.Models.Reports
{
	public record SaleByTerritory
	{
		public string? CountryRegion { get; set; }
		public decimal SalesLastYear { get; set; }
		public decimal SalesYTD { get; set; }
	}
}