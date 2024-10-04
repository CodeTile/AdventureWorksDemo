using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Models;
using AdventureWorksDemo.Data.Services;

using Microsoft.AspNetCore.Mvc;

namespace AdventureWorksDemo.API.Controllers
{
	[Route("api/[controller]")]
	public class ProductCategoryController(ILogger<ProductCategoryController> logger, IProductCategoryService service) : GenericControllerBase<ProductCategoryModel>(logger, service)
	{
	}
}