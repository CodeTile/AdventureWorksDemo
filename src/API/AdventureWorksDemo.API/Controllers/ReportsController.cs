using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Models.Reports;
using AdventureWorksDemo.Data.Services;

using Microsoft.AspNetCore.Mvc;

namespace AdventureWorksDemo.API.Controllers
{
	[ApiController]
	[Route("api/[controller]")]
	public class ReportsController(ILogger<ReportsController> logger, IReportService service) : ControllerBase
	{
		internal readonly ILogger _logger = logger;
		internal readonly IReportService _service = service;

		[HttpGet("onlinevsoffline")]
		[ProducesResponseType<SalesSummary>(StatusCodes.Status200OK)]
		public virtual async Task<IActionResult> ReportOnlineVsOffLine()
		{
			return Ok(await Task.Run(() =>
		_service.ReportOnlineVsOffLine()));
		}

		internal void WriteToTraceLog(string namespaceName, string methodName, string parmeterNames = "")
		{
			string Message = $"{namespaceName}.{methodName}({parmeterNames})";
			_logger.LogTrace("{Message}", Message);
		}
	}
}