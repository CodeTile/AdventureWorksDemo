using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Paging;
using AdventureWorksDemo.Data.Services;
using Microsoft.AspNetCore.Mvc;

namespace AdventureWorksDemo.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AddressController : ControllerBase
    {
        public AddressController(ILogger<AddressController> logger,
                                 IAddressService service)
        {
            _logger = logger;
            _service = service;
        }

        private readonly ILogger<AddressController> _logger;
        private readonly IAddressService _service;

        [HttpGet()]
        [ProducesResponseType<Product>(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetAllAsync([FromQuery] PageingFilter pageingFilter)
        {
            _logger.LogTrace($"{nameof(AddressController)}.{nameof(GetAllAsync)}()");
            var result = await _service.FindAllAsync(pageingFilter);
            return Ok(result);
        }

        [HttpGet("id")]
        [ProducesResponseType<Product>(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult?> GetAsync(int id)
        {
            _logger.LogTrace($"{nameof(AddressController)}.{nameof(GetAsync)}()");
            return Ok(await _service.FindAsync(id));
        }
    }
}