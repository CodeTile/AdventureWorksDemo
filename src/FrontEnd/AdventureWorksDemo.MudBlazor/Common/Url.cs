
using System.Runtime.InteropServices.Marshalling;

using AdventureWorksDemo.MudBlazor.Models;

namespace AdventureWorksDemo.MudBlazor.Common
{
	public interface IUrl
	{
		string Administration_ProductDescription { get; }

		Uri GetByModelType(Type T);
	}
	public class Url(IConfiguration configuration) : IUrl
	{
		public string Administration_ProductDescription => $"{configuration["Api:base"]}{configuration["Api:productdescription"]}";
		public Uri GetByModelType(Type T)
		{
			if (T == typeof(ProductDescriptionModel))
				return new Uri(Administration_ProductDescription);
			else
				throw new ArgumentOutOfRangeException(nameof(T), "Unknown type!");

		}
	}
}
