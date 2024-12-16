using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Models;
using AdventureWorksDemo.Data.Repository;

using AutoMapper;

using FluentValidation;

namespace AdventureWorksDemo.Data.Services
{
	public interface IProductDescriptionService :
												IFindService<ProductDescriptionModel, int>,
												IAddService<ProductDescriptionModel>,
												IAddBatchService<ProductDescriptionModel>,
												IDeleteService<int>,
												IUpdateService<ProductDescriptionModel>,
												IUpdateBatchService<ProductDescriptionModel>

	{
	}

	public class ProductDescriptionService(IMapper mapper, IGenericCrudRepository<ProductDescription> genericRepo, TimeProvider timeProvider, IValidator<ProductDescription>? validator)
			: BaseService<ProductDescription, ProductDescriptionModel>(mapper, genericRepo, validator)

			  , IProductDescriptionService
	{
		public async Task<IServiceResult<bool>> DeleteAsync(int productDescriptionId) => await base.DeleteAsync(m => m.ProductDescriptionId == productDescriptionId);

		public async Task<ProductDescriptionModel?> FindAsync(int productDescriptionId) => await base.FindByIdAsync(m => m.ProductDescriptionId == productDescriptionId);

		public async Task<IServiceResult<ProductDescriptionModel>> UpdateAsync(ProductDescriptionModel model)
		{
			return await base.UpdateAsync(model, m => m.ProductDescriptionId == model.ProductDescriptionId);
		}

		internal override async Task<ProductDescriptionModel?> FindAsync(ProductDescriptionModel model)
		{
			return await FindAsync(model.ProductDescriptionId);
		}

		internal override bool IsModelDirty(ProductDescriptionModel original, ProductDescriptionModel mutated)
		{
			return !original.Description.Trim().Equals(mutated.Description.Trim());
		}

		internal override void PreDataMutation(ProductDescription entity)
		{
			entity.ModifiedDate = timeProvider.GetLocalNow().DateTime;
		}

		internal override void TransposeModel(ProductDescriptionModel original, ProductDescriptionModel mutated)
		{
			original.Description = mutated.Description;
		}
	}
}