using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Models;
using AdventureWorksDemo.Data.Repository;

using AutoMapper;

using FluentValidation;

using Microsoft.IdentityModel.Tokens;

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

		public async Task<IServiceResult<AddressModel>> UpdateAsync(AddressModel model)
		{
			return await base.UpdateAsync(model, m => m.AddressId == model.AddressId);
		}

		internal override async Task<AddressModel?> FindAsync(AddressModel model)
		{
			return await FindAsync(model.AddressId);
		}

		internal override bool IsModelDirty(AddressModel original, AddressModel mutated)
		{
			return !original.AddressLine1.Equals(mutated.AddressLine1)
				|| !original.AddressLine2.Equals(mutated.AddressLine2)
				|| !original.StateProvince.Equals(mutated.StateProvince)
				|| !original.CountryRegion.Equals(mutated.CountryRegion)
				|| !original.City.Equals(mutated.City)
				|| !original.PostalCode.Equals(mutated.PostalCode);
		}

		internal override Task PreDataMutationAsync(Address entity)
		{
			entity.ModifiedDate = timeProvider.GetLocalNow().DateTime;
			return base.PreDataMutationAsync(entity);
		}

		internal override void TransposeModel(AddressModel original, AddressModel mutated)
		{
			original.AddressLine1 = TransposeIfNotNull(original.AddressLine1, mutated.AddressLine1);

			original.AddressLine2 = TransposeIfNotNull(original.AddressLine2, mutated.AddressLine2);
			original.StateProvince = TransposeIfNotNull(original.StateProvince, mutated.StateProvince);
			original.CountryRegion = TransposeIfNotNull(original.CountryRegion, mutated.CountryRegion);
			original.PostalCode = TransposeIfNotNull(original.PostalCode, mutated.PostalCode);
			original.City = TransposeIfNotNull(original.City, mutated.City);
		}
	}
}