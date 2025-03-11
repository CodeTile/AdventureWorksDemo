using AdventureWorksDemo.Data.Models.Reports;
using AdventureWorksDemo.Data.Repository;
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
			WriteToTraceLog(nameof(AdventureWorksDemo.API.Controllers), nameof(ReportOnlineVsOffLine));
			return Ok(await Task.Run(() => _service.ReportOnlineVsOffLine()));
		}

		[HttpGet("salesbyterritory")]
		[ProducesResponseType<SaleByTerritory>(StatusCodes.Status200OK)]
		public virtual async Task<IActionResult> ReportSalesByTerritory()
		{
			WriteToTraceLog(nameof(AdventureWorksDemo.API.Controllers), nameof(ReportSalesByTerritory));
			return Ok(await Task.Run(() => _service.ReportSalesByTerritory()));
		}

		internal void WriteToTraceLog(string namespaceName, string methodName, string parmeterNames = "")
		{
			string Message = $"{namespaceName}.{methodName}({parmeterNames})";
			_logger.LogTrace("{Message}", Message);
		}
	}
}