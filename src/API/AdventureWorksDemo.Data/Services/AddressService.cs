using AdventureWorksDemo.Data.DbContexts;
using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Models;
using AdventureWorksDemo.Data.Paging;
using AdventureWorksDemo.Data.Repository;
using AutoMapper;

namespace AdventureWorksDemo.Data.Services
{
    public interface IAddressService
    {
        Task<PagedList<AddressModel>> FindAllAsync(PageingFilter pageingFilter);

        Task<AddressModel?> FindAsync(int addressId);
    }

    public class AddressService : BaseService<Address, AddressModel>
                                  , IAddressService
    {
        public AddressService(dbContext context, IMapper mapper, IGenericCRUDRepository<AddressModel, Address> genericRepo) :
                        base(context, mapper, genericRepo)
        {
        }

        public async Task<AddressModel?> FindAsync(int addressId)
        {
            return await FindDTOAsync(m => m.AddressId == addressId);
        }
    }
}