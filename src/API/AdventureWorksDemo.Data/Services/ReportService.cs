using AdventureWorksDemo.Data.Models.Reports;
using AdventureWorksDemo.Data.Repository;

namespace AdventureWorksDemo.Data.Services
{
	public interface IReportService
	{
		IQueryable<SalesSummary> ReportOnlineVsOffLine();
	}

	public class ReportService(IReportingRepository _repository) : IReportService
	{
		public IQueryable<SalesSummary> ReportOnlineVsOffLine() => _repository.ReportOnLineVsOffLine();
	}
}