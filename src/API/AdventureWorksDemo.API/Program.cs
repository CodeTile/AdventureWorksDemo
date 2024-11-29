using System.Diagnostics.CodeAnalysis;

using AdventureWorksDemo.API.Exceptions;
using AdventureWorksDemo.Data.StartUp;

using Microsoft.Extensions.DependencyInjection;

using Scalar.AspNetCore;

namespace AdventureWorksDemo.API
{
	[ExcludeFromCodeCoverage]
	public class Program
	{
		public static void Main(string[] args)
		{
			var builder = WebApplication.CreateBuilder(args);

			//Exception handling
			builder.Services.AddExceptionHandler<GlobalExceptionHandler>();
			builder.Services.AddProblemDetails();
			// Add controllers
			builder.Services.AddControllers();
			// Add child projects
			new IocData(builder.Configuration).ConfigureServices(builder.Services);
			builder.Services.AddEndpointsApiExplorer();
			builder.Services.AddOpenApi();

			var app = builder.Build();

			if (app.Environment.IsDevelopment())
			{
				app.MapOpenApi();
				app.MapScalarApiReference();
			}

			app.UseHttpsRedirection();

			app.UseAuthorization();

			app.MapControllers();

			app.UseExceptionHandler();

			app.Run();
		}
	}
}