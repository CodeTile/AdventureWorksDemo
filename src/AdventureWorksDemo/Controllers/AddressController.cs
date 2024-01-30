using AdventureWorksDemo.Data.DTO;
using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Paging;
using AdventureWorksDemo.Data.Services;
using Microsoft.AspNetCore.Mvc;

namespace AdventureWorksDemo.Controllers
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
            _logger.LogTrace($"{nameof(AdventureWorksDemo.Controllers.AddressController)}.{nameof(GetAllAsync)}()");
            var result = await _service.GetAllAsync(pageingFilter);
            return Ok(result);
        }

        [HttpGet("id")]
        [ProducesResponseType<Product>(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<AddressDTO?> GetAsync(int id)
        {
            _logger.LogTrace($"{nameof(AdventureWorksDemo.Controllers.AddressController)}.{nameof(GetAsync)}()");
            return await _service.GetAsync(id);
        }
    }
}