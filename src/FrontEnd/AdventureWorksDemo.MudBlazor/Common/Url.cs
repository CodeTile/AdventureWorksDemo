using System.Runtime.InteropServices.Marshalling;

using AdventureWorksDemo.MudBlazor.Models;

namespace AdventureWorksDemo.MudBlazor.Common
{
	public interface IUrl
	{
		string Administration_ProductDescription { get; }
		string Report_OnlineVsOffLine { get; }
		string Report_SalesByTerritory { get; }

		Uri GetByModelType(Type T);
	}

	public class Url(IConfiguration configuration) : IUrl
	{
		public string Administration_ProductDescription => $"{configuration["Api:base"]}{configuration["Api:productdescription"]}";
		public string Report_OnlineVsOffLine => $"{configuration["Api:Base"]}{configuration["Api:Reports:Base"]}{configuration["Api:Reports:OnlineVsOffLine"]}";
		public string Report_SalesByTerritory => $"{configuration["Api:Base"]}{configuration["Api:Reports:Base"]}{configuration["Api:Reports:SalesByTerritory"]}";

		public Uri GetByModelType(Type T)
		{
			if (T == typeof(ProductDescriptionModel))
				return new Uri(Administration_ProductDescription);
			else
				throw new ArgumentOutOfRangeException(nameof(T), "Unknown type!");
		}
	}
}