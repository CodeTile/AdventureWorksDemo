using System.Diagnostics.CodeAnalysis;

using AdventureWorksDemo.Data.Entities;

using AdventureWorksDemo.Data.Models;

using AdventureWorksDemo.Data.Paging;

using AutoMapper;

namespace AdventureWorksDemo.Data.StartUp
{
	[ExcludeFromCodeCoverage]
	public class MappingProfile : Profile
	{
		public MappingProfile()
		{
			CreateMap<ProductCategory, ProductCategoryModel>();
			CreateMap<ProductCategoryModel, ProductCategory>();
			CreateMap<PagedList<ProductCategory>, PagedList<ProductCategoryModel>>().ForMember("Item", opt => opt.Ignore());

			CreateMap<ProductDescription, ProductDescriptionModel>();
			CreateMap<ProductDescriptionModel, ProductDescription>();
			CreateMap<PagedList<ProductDescription>, PagedList<ProductDescriptionModel>>().ForMember("Item", opt => opt.Ignore());
		}
	}
}