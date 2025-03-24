namespace AdventureWorksDemo.MudBlazor.Models
{
	public record SaleByTerritory()
	{
		public string? CountryRegion { get; set; }
		public decimal SalesLastYear { get; set; }
		public decimal SalesYTD { get; set; }
		public double SalesYTDToDisplay => Convert.ToDouble(SalesYTD / 1000000);
		public double SalesLastYearToDisplay => Convert.ToDouble(SalesLastYear / 1000000);
	}
}