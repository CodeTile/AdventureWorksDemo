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

		public override async Task<IServiceResult<ProductDescriptionModel>> UpdateAsync(ProductDescriptionModel model)
		{
			var original = await FindAsync(model.ProductDescriptionId);
			if (original == null)
			{
				return ServiceResult<ProductDescriptionModel>.Failure(model, "Unable to locate record to update!");
			}
			else if (original.Equals(model))
			{
				return ServiceResult<ProductDescriptionModel>.Success(original, "Record is already up to date!");
			}

			original.Description = model.Description;
			return await base.UpdateAsync(original);
		}

		public async Task<IServiceResult<IEnumerable<ProductDescriptionModel>>> UpdateBatchAsync(IEnumerable<ProductDescriptionModel> models)
		{
			if (models == null || !models.Any())
			{
				var retval = models ?? Array.Empty<ProductDescriptionModel>();
				return ServiceResult<IEnumerable<ProductDescriptionModel>>.Failure(retval, "Please select some records to update!");
			}
			List<ProductDescriptionModel> modelsToUpdate = [];
			foreach (var model in models.AsParallel())
			{
				var original = await FindAsync(model.ProductDescriptionId);
				if (original == null || original.Equals(model))
					continue;
				original.Description = model.Description;
				modelsToUpdate.Add(original);
			}

			return await base.UpdateAsync(modelsToUpdate);
		}

		internal override Task PreDataMutationAsync(ProductDescription entity)
		{
			entity.ModifiedDate = timeProvider.GetLocalNow().DateTime;
			return base.PreDataMutationAsync(entity);
		}
	}
}