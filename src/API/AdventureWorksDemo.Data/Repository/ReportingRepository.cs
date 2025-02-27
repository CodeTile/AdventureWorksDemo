using AdventureWorksDemo.Data.DbContexts;
using AdventureWorksDemo.Data.Models.Reports;

namespace AdventureWorksDemo.Data.Repository
{
	public interface IReportingRepository
	{
		IQueryable<SalesSummaryByYear> ReportOnLineVsOffLine();
	}

	public class ReportingRepository(AdventureWorksContext _context) : IReportingRepository
	{
		public IQueryable<SalesSummaryByYear> ReportOnLineVsOffLine()
		{
			return _context.SalesOrderHeaders
						.GroupBy(o => new { OrderYear = o.OrderDate.Year, o.OnlineOrderFlag })
						  .Select(g => new SalesSummaryByYear
						  {
							  OrderYear = g.Key.OrderYear,
							  OnlineOrderFlag = g.Key.OnlineOrderFlag,
							  SalesCount = g.Count()
						  })
						.OrderByDescending(x => x.OrderYear)
						.ThenBy(x => x.OnlineOrderFlag);
		}
	}
}