using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Paging;
using Microsoft.AspNetCore.Mvc;

namespace AdventureWorksDemo.API.Controllers
{
    public abstract class GenericControllerBase<TModel>(ILogger logger,
                                                    dynamic service) : ControllerBase
                                                    where TModel : class
    {
        internal readonly ILogger _logger = logger;
        internal readonly dynamic _service = service;

        [HttpPost()]
        [ProducesResponseType<Product>(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public virtual async Task<IActionResult> AddAsync([FromBody] TModel model)
        {
            _logger.LogTrace($"{nameof(GenericControllerBase<TModel>)}.{nameof(AddAsync)}()");
            var result = await _service.AddAsync(model);
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
            _logger.LogTrace($"{nameof(GenericControllerBase<TModel>)}.{nameof(DeleteAsync)}()");
            if (await _service.DeleteAsync(id))
                return Ok(null);
            else
                return BadRequest();
        }

        [HttpGet()]
        [ProducesResponseType<Product>(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public virtual async Task<IActionResult> GetAllAsync([FromQuery] PageingFilter pageingFilter)
        {
            _logger.LogTrace($"{nameof(GenericControllerBase<TModel>)}.{nameof(GetAllAsync)}(pageingFilter)");
            var result = await _service.FindAllAsync(pageingFilter);
            return Ok(result);
        }

        [HttpGet("id")]
        [ProducesResponseType<Product>(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public virtual async Task<IActionResult?> GetAsync(int id)
        {
            _logger.LogTrace($"{nameof(GenericControllerBase<TModel>)}.{nameof(GetAsync)}()");
            return Ok(await _service.FindAsync(id));
        }

        [HttpPut()]
        [ProducesResponseType<Product>(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public virtual async Task<IActionResult> UpdateAsync([FromBody] TModel model)
        {
            _logger.LogTrace($"{nameof(GenericControllerBase<TModel>)}.{nameof(AddAsync)}(model)");
            var result = await _service.AddAsync(model);
            if (result != null)
                return Ok(result);
            else
                return BadRequest(result);
        }
    }
}