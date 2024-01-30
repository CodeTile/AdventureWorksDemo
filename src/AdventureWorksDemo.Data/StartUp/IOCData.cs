using AdventureWorksDemo.Data.DbContexts;
using AdventureWorksDemo.Data.Services;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using AutoMapper;

namespace AdventureWorksDemo.Data.StartUp
{
    public class IOCData

    {
        public IOCData(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        private IConfiguration Configuration;

        public void ConfigureServices(IServiceCollection services)
        {
            services.AddDbContext<dbContext>(options => options.UseSqlServer(Configuration.GetConnectionString("AdventureWorks")));
            services.AddAutoMapper(typeof(MappingProfile));
            //Add Transient services to the container.
            services.AddTransient<IAddressService, AddressService>();
        }
    }
}