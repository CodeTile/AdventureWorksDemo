using AdventureWorksDemo.Data.Models;
using AdventureWorksDemo.Data.Services;

using Microsoft.AspNetCore.Mvc;

namespace AdventureWorksDemo.API.Controllers
{
	[Route("api/[controller]")]
	public class ProductDescriptionController(ILogger<ProductDescriptionController> logger, IProductDescriptionService service) :
							 GenericControllerBase<ProductDescriptionModel>(logger, service)
	{
	}
}