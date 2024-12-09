using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Models;
using AdventureWorksDemo.Data.Repository;

using AutoMapper;

using FluentValidation;

namespace AdventureWorksDemo.Data.Services
{
	public interface IAddressService :
												IFindService<AddressModel, int>,
												IAddService<AddressModel>,
												IAddBatchService<AddressModel>,
												IDeleteService<int>,
												IUpdateService<AddressModel>,
												IUpdateBatchService<AddressModel>

	{
	}

	public class AddressService(IMapper mapper, IGenericCrudRepository<Address> genericRepo, TimeProvider timeProvider, IValidator<Address>? validator)
			: BaseService<Address, AddressModel>(mapper, genericRepo, validator)
			  , IAddressService
	{
		public async Task<IServiceResult<bool>> DeleteAsync(int id) => await base.DeleteAsync(m => m.AddressId == id);

		public async Task<AddressModel?> FindAsync(int id) => await base.FindByIdAsync(m => m.AddressId == id);

		public override async Task<IServiceResult<AddressModel>> UpdateAsync(AddressModel model)
		{
			var original = await FindAsync(model.AddressId);
			if (original == null)
			{
				return ServiceResult<AddressModel>.Failure(model, "Unable to locate record to update!");
			}
			else if (original.Equals(model))
			{
				return ServiceResult<AddressModel>.Success(original, "Record is already up to date!");
			}

			TransposeModel(original, model);
			return await base.UpdateAsync(original);
		}

		public async Task<IServiceResult<IEnumerable<AddressModel>>> UpdateBatchAsync(IEnumerable<AddressModel> models)
		{
			if (models == null || !models.Any())
			{
				var retval = models ?? Array.Empty<AddressModel>();
				return ServiceResult<IEnumerable<AddressModel>>.Failure(retval, "Please select some records to update!");
			}
			List<AddressModel> modelsToUpdate = [];
			foreach (var model in models.AsParallel())
			{
				var original = await FindAsync(model.AddressId);
				if (original == null || original.Equals(model))
					continue;
				TransposeModel(original, model);
				modelsToUpdate.Add(original);
			}

			return await base.UpdateAsync(modelsToUpdate);
		}

		internal override Task PreDataMutationAsync(Address entity)
		{
			entity.ModifiedDate = timeProvider.GetLocalNow().DateTime;
			return base.PreDataMutationAsync(entity);
		}

		private void TransposeModel(AddressModel original, AddressModel mutated)
		{
			original.AddressLine1 = mutated.AddressLine1;
			original.AddressLine2 = mutated.AddressLine2;
			original.City = mutated.City;
			original.StateProvince = mutated.StateProvince;
			original.CountryRegion = mutated.CountryRegion;
			original.PostalCode = mutated.PostalCode;
		}
	}
}