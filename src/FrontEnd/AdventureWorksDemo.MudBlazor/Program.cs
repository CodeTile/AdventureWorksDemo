using AdventureWorksDemo.MudBlazor.Common;
using AdventureWorksDemo.MudBlazor.Components;

using Microsoft.Extensions.Caching.Memory;

using MudBlazor.Services;

namespace AdventureWorksDemo.MudBlazor
{
	public class Program
	{
		public static void Main(string[] args)
		{
			var builder = WebApplication.CreateBuilder(args);

			// Add MudBlazor services
			builder.Services.AddMudServices();

			// Add services to the container.
			builder.Services.AddRazorComponents()
				.AddInteractiveServerComponents()
				.Services.AddHttpClient();
			// Add services
			builder.Services.AddScoped(sp => new HttpClient
			{
				BaseAddress = new Uri(builder.Configuration["Api:Base"] ?? "")
			});
			builder.Services.AddSingleton(typeof(IUrl), typeof(Url));
			builder.Services.AddScoped(typeof(IMemoryCache), typeof(MemoryCache));
			builder.Services.AddScoped(typeof(IJsonDataService), typeof(JsonDataService));
			builder.Services.AddScoped(typeof(ICommonResponseGet), typeof(CommonResponse));

			var app = builder.Build();

			// Configure the HTTP request pipeline.
			if (!app.Environment.IsDevelopment())
			{
				app.UseExceptionHandler("/Error");
				// The default HSTS value is 30 days. You may want to change this for production
				// scenarios, see https://aka.ms/aspnetcore-hsts.
				app.UseHsts();
			}

			app.UseHttpsRedirection();

			app.UseStaticFiles();
			app.UseAntiforgery();

			app.MapRazorComponents<App>()
				.AddInteractiveServerRenderMode();

			app.Run();
		}
	}
}