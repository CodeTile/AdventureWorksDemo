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

		Task<IServiceResult<bool>> DeleteAsync(int productCategoryId);

		Task<PagedList<ProductCategoryModel>?> FindAllAsync(PageingFilter pageingFilter);

		Task<PagedList<ProductCategoryModel>?> FindAllAsync(PageingFilter pageingFilter, Expression<Func<ProductCategory, bool>>? predictate);

		Task<ProductCategoryModel?> FindAsync(int productCategoryId);

		Task<ProductCategoryModel> UpdateAsync(ProductCategoryModel model);

		Task<IEnumerable<ProductCategoryModel>> UpdateBatchAsync(IEnumerable<ProductCategoryModel> models);
	}

	public class ProductCategoryService(IMapper mapper, IGenericCrudRepository<ProductCategory> genericRepo, TimeProvider timeProvider) : BaseService<ProductCategory, ProductCategoryModel>(mapper, genericRepo)
																											  , IProductCategoryService
	{
		public async Task<IServiceResult<bool>> DeleteAsync(int productCategoryId) => await base.DeleteAsync(m => m.ProductCategoryId == productCategoryId);

		public async Task<ProductCategoryModel?> FindAsync(int productCategoryId) => await base.FindByIdAsync(m => m.ProductCategoryId == productCategoryId);

		public override async Task<ProductCategoryModel> UpdateAsync(ProductCategoryModel model)
		{
			var original = await FindAsync(model.ProductCategoryId);
			if (original == null)
			{
				//TODO:  Move to result pattern
				throw new Exception("Record not found to update!");
			}
			else if (original.Equals(model))
			{
				//TODO:  Move to result pattern
				return original;
			}

			original.Name = model.Name;
			original.ParentProductCategoryId = model.ParentProductCategoryId;
			return await base.UpdateAsync(original);
		}

		public async Task<IEnumerable<ProductCategoryModel>> UpdateBatchAsync(IEnumerable<ProductCategoryModel> models)
		{
			if (models == null || !models.Any())
			{
				var retval = models ?? Array.Empty<ProductCategoryModel>();
				return retval.ToArray();
			}
			List<ProductCategoryModel> modelsToUpdate = [];
			foreach (var model in models.AsParallel())
			{
				var original = await FindAsync(model.ProductCategoryId);
				if (original == null || original.Equals(model))
					continue;
				original.Name = model.Name;
				original.ParentProductCategoryId = model.ParentProductCategoryId;
				modelsToUpdate.Add(original);
			}

			return (ProductCategoryModel[])await base.UpdateAsync(modelsToUpdate);
		}

		internal override Task PreDataMutationAsync(ProductCategory entity)
		{
			entity.ModifiedDate = timeProvider.GetLocalNow().DateTime;
			return base.PreDataMutationAsync(entity);
		}
	}
}