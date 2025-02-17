using System.Text.Json;

using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Models;
using AdventureWorksDemo.Data.Paging;
using AdventureWorksDemo.Data.Services;

using Microsoft.AspNetCore.Mvc;

namespace AdventureWorksDemo.API.Controllers
{
	[ApiController]
	public abstract class GenericControllerBase<TModel>(ILogger logger,
													dynamic service) : ControllerBase
													where TModel : class
	{
		internal readonly ILogger _logger = logger;
		internal readonly IService _service = service;

		[HttpPost()]
		[ProducesResponseType<Product>(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status400BadRequest)]
		public virtual async Task<IActionResult> AddAsync([FromBody] TModel model)
		{
			WriteToTraceLog(nameof(GenericControllerBase<TModel>), nameof(AddAsync));
			IServiceResult<TModel> result = await ((IAddService<TModel>)_service).AddAsync(model);
			if (result != null)
				return Ok(result);
			else
				return BadRequest(result);
		}

		[HttpDelete("id")]
		[ProducesResponseType<Product>(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status400BadRequest)]
		public virtual async Task<IActionResult> DeleteAsync(int id)
		{
			WriteToTraceLog(nameof(GenericControllerBase<TModel>), nameof(DeleteAsync));
			var result = await ((IDeleteService<int>)_service).DeleteAsync(id);
			if (result.IsSuccess)
				return Ok(result.Message);
			return BadRequest(result);
		}

		[HttpGet()]
		[ProducesResponseType<Product>(StatusCodes.Status200OK)]
		[ProducesResponseType(StatusCodes.Status404NotFound)]
		public virtual async Task<IActionResult> FindAllAsync([FromBody] PageingFilter pageingFilter)
		{
			WriteToTraceLog(nameof(GenericControllerBase<TModel>), nameof(FindAllAsync), "pageingFilter");

			PagedList<TModel> result = await ((IFindService<TModel, int>)_service).FindAllAsync(pageingFilter);
			Response.Headers.Append("X-Pagination", JsonSerializer.Serialize((IPagedList)result));
			if (result != null && result!.Any())
				return Ok(result);
			else
				return NotFound(result);
		}

		[HttpGet("id")]
		[ProducesResponseType<Product>(StatusCodes.Status200OK)]
		public virtual async Task<IActionResult?> FindAsync(int id)
		{
			WriteToTraceLog(nameof(GenericControllerBase<TModel>), nameof(FindAllAsync));
			return Ok(await ((IFindService<TModel, int>)_service).FindAsync(id));
		}

		[HttpPut()]
		[ProducesResponseType<Product>(StatusCodes.Status200OK)]
		public virtual async Task<IActionResult> UpdateAsync([FromBody] TModel model)
		{
			WriteToTraceLog(nameof(GenericControllerBase<TModel>), nameof(UpdateAsync), "model");
			IServiceResult<TModel>? result = await ((IUpdateService<TModel>)_service).UpdateAsync(model);
			return Ok(result);
		}

		internal void WriteToTraceLog(string namespaceName, string methodName, string parmeterNames = "")
		{
			string Message = $"{namespaceName}.{methodName}({parmeterNames})";
			_logger.LogTrace("{Message}", Message);
		}
	}
}