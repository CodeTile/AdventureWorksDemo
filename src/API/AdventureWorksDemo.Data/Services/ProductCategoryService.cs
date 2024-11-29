using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Models;
using AdventureWorksDemo.Data.Repository;

using AutoMapper;

using FluentValidation;

namespace AdventureWorksDemo.Data.Services
{
	public interface IProductCategoryService :
												IFindService<ProductCategoryModel, int>,
												IAddService<ProductCategoryModel>,
												IAddBatchService<ProductCategoryModel>,
												IDeleteService<int>,
												IUpdateService<ProductCategoryModel>,
												IUpdateBatchService<ProductCategoryModel>

	{
	}

	public class ProductCategoryService(IMapper mapper, IGenericCrudRepository<ProductCategory> genericRepo, TimeProvider timeProvider, IValidator<ProductCategory>? validator)
			: BaseService<ProductCategory, ProductCategoryModel>(mapper, genericRepo, validator)
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
				return ServiceResult<ProductCategoryModel>.Success(original, "Record is already up to date!");
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