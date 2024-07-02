using System.Diagnostics.CodeAnalysis;

using AdventureWorksDemo.Data.DbContexts;
using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Repository;
using AdventureWorksDemo.Data.Services;

using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace AdventureWorksDemo.Data.StartUp
{
    [ExcludeFromCodeCoverage]
    public class IocData(IConfiguration configuration)

    {
        private readonly IConfiguration Configuration = configuration;

        public void ConfigureServices(IServiceCollection services)
        {
            services.AddDbContext<dbContext>(options => options.UseSqlServer(Configuration.GetConnectionString("Target")));
            services.AddAutoMapper(typeof(MappingProfile));
            //Add Transient services to the container.
            services.AddTransient<IAddressService, AddressService>();
            services.AddTransient<IProductCategoryService, ProductCategoryService>();
            //Add Repositories
            services.AddTransient<IGenericCrudRepository<Address>, GenericCrudRepository<Address>>();
            services.AddTransient<IGenericCrudRepository<ProductCategory>, GenericCrudRepository<ProductCategory>>();
            // Add Singleton's
            services.AddSingleton(TimeProvider.System);
        }
    }
}