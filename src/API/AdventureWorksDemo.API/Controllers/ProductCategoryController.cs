using AdventureWorksDemo.Data.Models;
using AdventureWorksDemo.Data.Services;
using Microsoft.AspNetCore.Mvc;

namespace AdventureWorksDemo.API.Controllers
{
    [ApiController]
    public class ProductCategoryController(ILogger<ProductCategoryController> logger, IProductCategoryService service) : GenericControllerBase<ProductCategoryModel>(logger, service)
    {
    }
}