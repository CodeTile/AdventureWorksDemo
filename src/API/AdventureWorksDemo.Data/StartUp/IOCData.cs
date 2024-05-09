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
    public class IOCData(IConfiguration configuration)

    {
        private readonly IConfiguration Configuration = configuration;

        public void ConfigureServices(IServiceCollection services)
        {
            services.AddDbContext<dbContext>(options => options.UseSqlServer(Configuration.GetConnectionString("MainDatabase")));
            services.AddAutoMapper(typeof(MappingProfile));
            //Add Transient services to the container.
            services.AddTransient<IAddressService, AddressService>();
            //Add Repositories
            services.AddTransient<IGenericCRUDRepository<Address>, GenericCRUDRepository<Address>>();
        }
    }
}