using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Services;

using Microsoft.AspNetCore.Mvc;

namespace AdventureWorksDemo.API.Controllers
{
	[ApiController]
	[Route("api/[controller]")]
	public class ReportsController(ILogger<ReportsController> logger, IReportService service) : Controller
	{
		internal readonly ILogger _logger = logger;
		internal readonly IReportService _service = service;

		[ProducesResponseType<Product>(StatusCodes.Status200OK)]
		public virtual async Task<IActionResult> ReportOnlineVsOffLine()
		{
			return Ok(await Task.Run(() => _service.ReportOnlineVsOffLine()));
		}

		internal void WriteToTraceLog(string namespaceName, string methodName, string parmeterNames = "")
		{
			string Message = $"{namespaceName}.{methodName}({parmeterNames})";
			_logger.LogTrace("{Message}", Message);
		}
	}
}