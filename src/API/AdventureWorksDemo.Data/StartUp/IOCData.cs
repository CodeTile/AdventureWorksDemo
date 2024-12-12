using System.Diagnostics.CodeAnalysis;

using AdventureWorksDemo.Data.DbContexts;
using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Repository;
using AdventureWorksDemo.Data.Services;

using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using FluentValidation;
using AdventureWorksDemo.Data.Validation;

namespace AdventureWorksDemo.Data.StartUp
{
	[ExcludeFromCodeCoverage]
	public class IocData(IConfiguration configuration)

	{
		private readonly IConfiguration Configuration = configuration;

		public void ConfigureServices(IServiceCollection services)
		{
			/// <summary>
			/// * For lifetimes see the article
			/// * https://henriquesd.medium.com/dependency-injection-and-service-lifetimes-in-net-core-ab9189349420
			/// </summary>

			services.AddDbContext<AdventureWorksDbContext>(options => options.UseSqlServer(Configuration.GetConnectionString("Target")));
			services.AddAutoMapper(typeof(MappingProfile));
			//Add Transient services to the container.
			services.AddTransient<IAddressService, AddressService>();
			services.AddTransient<IProductCategoryService, ProductCategoryService>();
			services.AddTransient<IProductDescriptionService, ProductDescriptionService>();
			//Add Repositories
			services.AddScoped<IGenericCrudRepository<Address>, GenericCrudRepository<Address>>();
			services.AddScoped<IGenericCrudRepository<ProductCategory>, GenericCrudRepository<ProductCategory>>();
			services.AddScoped<IGenericCrudRepository<ProductDescription>, GenericCrudRepository<ProductDescription>>();
			// Add Singleton's
			services.AddSingleton(TimeProvider.System);
			// Add validators
			services.AddScoped<IValidator<Address>, AddressValidator>();
			services.AddScoped<IValidator<ProductCategory>, ProductCategoryValidator>();
			services.AddScoped<IValidator<ProductDescription>, ProductDescriptionValidator>();
		}
	}
}