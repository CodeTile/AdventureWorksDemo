using System.Linq.Expressions;

using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Models;
using AdventureWorksDemo.Data.Paging;
using AdventureWorksDemo.Data.Repository;

using AutoMapper;

namespace AdventureWorksDemo.Data.Services
{
	public interface IProductCategoryService
	{
		Task<ProductCategoryModel> AddAsync(ProductCategoryModel model);

		Task<IEnumerable<ProductCategoryModel>> AddBatchAsync(IEnumerable<ProductCategoryModel> models);

		Task<bool> DeleteAsync(int productCategoryId);

		Task<PagedList<ProductCategoryModel>?> FindAllAsync(PageingFilter pageingFilter);

		Task<PagedList<ProductCategoryModel>?> FindAllAsync(PageingFilter pageingFilter, Expression<Func<ProductCategory, bool>>? predictate);

		Task<ProductCategoryModel?> FindAsync(int productCategoryId);

		Task<ProductCategoryModel> UpdateAsync(ProductCategoryModel model);
	}

	public class ProductCategoryService(IMapper mapper, IGenericCrudRepository<ProductCategory> genericRepo, TimeProvider timeProvider) : BaseService<ProductCategory, ProductCategoryModel>(mapper, genericRepo)
																											  , IProductCategoryService
	{
		public async Task<bool> DeleteAsync(int productCategoryId) => await base.DeleteAsync(m => m.ProductCategoryId == productCategoryId);

		public async Task<ProductCategoryModel?> FindAsync(int productCategoryId) => await base.FindByIdAsync(m => m.ProductCategoryId == productCategoryId);

		public override async Task<ProductCategoryModel> UpdateAsync(ProductCategoryModel model)
		{
			var original = await FindAsync(model.ProductCategoryId);
			if (original == null || original.Equals(model))
			{
				//TODO:  Move to result pattern
				throw new Exception("Record not found to update!");
			}

			original.Name = model.Name;
			original.ParentProductCategoryId = model.ParentProductCategoryId;
			return await base.UpdateAsync(original);
		}

		internal override Task PreDataMutationAsync(ProductCategory entity)
		{
			entity.ModifiedDate = timeProvider.GetLocalNow().DateTime;
			return base.PreDataMutationAsync(entity);
		}
	}
}