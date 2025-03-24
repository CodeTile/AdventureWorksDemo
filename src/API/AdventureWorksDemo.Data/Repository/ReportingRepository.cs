using AdventureWorksDemo.Data.DbContexts;
using AdventureWorksDemo.Data.Models.Reports;

namespace AdventureWorksDemo.Data.Repository
{
	public interface IReportingRepository
	{
		IQueryable<SalesSummary> ReportOnLineVsOffLine();

		IQueryable<SaleByTerritory> ReportSalesByTerritory();
	}

	public partial class ReportingRepository(AdventureWorksContext _context) : IReportingRepository
	{
		public IQueryable<SalesSummary> ReportOnLineVsOffLine()
		{
			return _context.SalesOrderHeaders
						.GroupBy(o => new
						{
							Year = o.OrderDate.Year,
							Month = o.OrderDate.Month,
							o.OnlineOrderFlag
						})
						  .Select(g => new SalesSummary
						  {
							  Year = g.Key.Year,
							  Month = g.Key.Month,
							  OnlineOrderFlag = g.Key.OnlineOrderFlag,
							  SalesCount = g.Count()
						  })
						.OrderByDescending(x => x.Year)
						.ThenBy(x => x.OnlineOrderFlag);
		}

		public IQueryable<SaleByTerritory> ReportSalesByTerritory()
		{
			return _context.SalesTerritories
				.Select(m => new SaleByTerritory
				{
					CountryRegion = m.Name,
					SalesYTD = m.SalesYtd,
					SalesLastYear = m.SalesLastYear
				})
				.OrderBy(m => m.CountryRegion);
		}
	}
}