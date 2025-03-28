using System.Diagnostics.CodeAnalysis;

using AdventureWorksDemo.API.Exceptions;
using AdventureWorksDemo.Data.StartUp;

using Scalar.AspNetCore;

namespace AdventureWorksDemo.API
{
	[ExcludeFromCodeCoverage]
	public class Program
	{
		public static void Main(string[] args)
		{
			var builder = WebApplication.CreateBuilder(args);

			////Exception handling
			builder.Services.AddExceptionHandler<GlobalExceptionHandler>();
			builder.Services.AddProblemDetails();
			// Add child DI objects
			new IocData(builder.Configuration).ConfigureServices(builder.Services);
			// Add controllers
			builder.Services.AddControllers();
			// Add Cache Timeout
			builder.Services.AddOutputCache(options =>
			{
				options.AddBasePolicy(policy => policy.Expire(TimeSpan.FromMinutes(10)));
			});
			builder.Services.AddEndpointsApiExplorer();
			builder.Services.AddOpenApi();

			var app = builder.Build();

			app.UseOutputCache();

			app.UseExceptionHandler();
			if (app.Environment.IsDevelopment())
			{
				app.MapOpenApi()
					.CacheOutput();
				app.MapScalarApiReference();
			}

			app.UseHttpsRedirection();

			app.UseAuthorization();

			app.MapControllers();

			app.Run();
		}
	}
}