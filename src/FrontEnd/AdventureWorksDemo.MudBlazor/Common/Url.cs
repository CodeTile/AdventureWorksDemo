namespace AdventureWorksDemo.MudBlazor.Common
{
	public interface IUrl
	{
		string Administration_ProductDescription { get; }
	}
	public class Url(IConfiguration configuration) : IUrl
	{
		public string Administration_ProductDescription => $"{configuration["Api:base"]}{configuration["Api:productdescription"]}";
	}
}
