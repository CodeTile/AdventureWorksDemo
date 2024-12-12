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

		public async Task<IServiceResult<ProductCategoryModel>> UpdateAsync(ProductCategoryModel model)
					=> await base.UpdateAsync(model, m => m.ProductCategoryId == model.ProductCategoryId);

		internal override async Task<ProductCategoryModel?> FindAsync(ProductCategoryModel model)
		{
			return await FindByIdAsync(m => m.ProductCategoryId == model.ProductCategoryId);
		}

		internal override bool IsModelDirty(ProductCategoryModel original, ProductCategoryModel mutated)
		{
			return !original.Name.Equals(mutated.Name)
				|| !original.ParentProductCategoryId.Equals(mutated.ParentProductCategoryId);
		}

		internal override Task PreDataMutationAsync(ProductCategory entity)
		{
			entity.ModifiedDate = timeProvider.GetLocalNow().DateTime;
			return base.PreDataMutationAsync(entity);
		}

		internal override void TransposeModel(ProductCategoryModel original,
											  ProductCategoryModel mutated)
		{
			original.Name = mutated.Name;
			original.ParentProductCategoryId = mutated.ParentProductCategoryId;
		}
	}
}