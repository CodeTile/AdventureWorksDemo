using AdventureWorksDemo.Data.Models;
using AdventureWorksDemo.Data.Services;
using Microsoft.AspNetCore.Mvc;

namespace AdventureWorksDemo.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AddressController(ILogger<AddressController> logger, IAddressService service) : GenericControllerBase<AddressModel>(logger, service)
    {
    }
}