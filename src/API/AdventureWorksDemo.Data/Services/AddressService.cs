using AdventureWorksDemo.Data.DbContexts;
using AdventureWorksDemo.Data.DTO;
using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Paging;
using AutoMapper;

namespace AdventureWorksDemo.Data.Services
{
    public interface IAddressService
    {
        Task<PagedList<AddressDTO>> FindAllAsync(PageingFilter pageingFilter);

        Task<AddressDTO?> FindAsync(int addressId);
    }

    public class AddressService : BaseService<Address, AddressDTO>
                             , IAddressService
    {
        public AddressService(dbContext context, IMapper mapper) :
                        base(context, mapper)
        {
        }

        public async Task<AddressDTO?> FindAsync(int addressId)
        {
            return await FindDTOAsync(m => m.AddressId == addressId);
        }
    }
}