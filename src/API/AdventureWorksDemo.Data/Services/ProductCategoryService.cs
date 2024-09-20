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
		Task<IServiceResult<ProductCategoryModel>> AddAsync(ProductCategoryModel model);

		Task<IServiceResult<IEnumerable<ProductCategoryModel>>> AddBatchAsync(IEnumerable<ProductCategoryModel> models);

		Task<IServiceResult<bool>> DeleteAsync(int productCategoryId);

		Task<PagedList<ProductCategoryModel>?> FindAllAsync(PageingFilter pageingFilter);

		Task<PagedList<ProductCategoryModel>?> FindAllAsync(PageingFilter pageingFilter, Expression<Func<ProductCategory, bool>>? predictate);

		Task<ProductCategoryModel?> FindAsync(int productCategoryId);

		Task<IServiceResult<ProductCategoryModel>> UpdateAsync(ProductCategoryModel model);

		Task<IServiceResult<IEnumerable<ProductCategoryModel>>> UpdateBatchAsync(IEnumerable<ProductCategoryModel> models);
	}

	public class ProductCategoryService(IMapper mapper, IGenericCrudRepository<ProductCategory> genericRepo, TimeProvider timeProvider) : BaseService<ProductCategory, ProductCategoryModel>(mapper, genericRepo)
																											  , IProductCategoryService
	{
		public async Task<IServiceResult<bool>> DeleteAsync(int productCategoryId) => await base.DeleteAsync(m => m.ProductCategoryId == productCategoryId);

		public async Task<ProductCategoryModel?> FindAsync(int productCategoryId) => await base.FindByIdAsync(m => m.ProductCategoryId == productCategoryId);

		public override async Task<IServiceResult<ProductCategoryModel>> UpdateAsync(ProductCategoryModel model)
		{
			var original = await FindAsync(model.ProductCategoryId);
			if (original == null)
			{
				return ServiceResult<ProductCategoryModel>.Failure(model, "Unable to locate record to update!");
			}
			else if (original.Equals(model))
			{
				return ServiceResult<ProductCategoryModel>.Success(original, "Record is already uptodate!");
			}

			original.Name = model.Name;
			original.ParentProductCategoryId = model.ParentProductCategoryId;
			return await base.UpdateAsync(original);
		}

		public async Task<IServiceResult<IEnumerable<ProductCategoryModel>>> UpdateBatchAsync(IEnumerable<ProductCategoryModel> models)
		{
			if (models == null || !models.Any())
			{
				var retval = models ?? Array.Empty<ProductCategoryModel>();
				return ServiceResult<IEnumerable<ProductCategoryModel>>.Failure(retval, "Please select some records to update!");
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

			return await base.UpdateAsync(modelsToUpdate);
		}

		internal override Task PreDataMutationAsync(ProductCategory entity)
		{
			entity.ModifiedDate = timeProvider.GetLocalNow().DateTime;
			return base.PreDataMutationAsync(entity);
		}
	}
}