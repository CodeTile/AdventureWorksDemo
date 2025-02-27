using AdventureWorksDemo.Data.Models.Reports;
using AdventureWorksDemo.Data.Repository;

namespace AdventureWorksDemo.Data.Services
{
	public interface IReportService
	{
		IQueryable<SalesSummaryByYear> ReportOnlineVsOffLine();
	}

	public class ReportService(IReportingRepository _repository) : IReportService
	{
		public IQueryable<SalesSummaryByYear> ReportOnlineVsOffLine() => _repository.ReportOnLineVsOffLine();
	}
}