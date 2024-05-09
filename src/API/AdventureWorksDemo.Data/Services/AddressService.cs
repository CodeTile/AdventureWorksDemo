using System.Linq.Expressions;
using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Models;
using AdventureWorksDemo.Data.Paging;
using AdventureWorksDemo.Data.Repository;
using AutoMapper;

namespace AdventureWorksDemo.Data.Services
{
    public interface IAddressService
    {
        Task<AddressModel> AddAsync(AddressModel model);

        Task<bool> DeleteAsync(int addressId);

        Task<PagedList<AddressModel>?> FindAllAsync(PageingFilter pageingFilter);

        Task<PagedList<AddressModel>?> FindAllAsync(PageingFilter paging, Expression<Func<Address, bool>>? predictate);

        Task<AddressModel?> FindAsync(int addressId);
    }

    public class AddressService(IMapper mapper, IGenericCrudRepository<Address> genericRepo) : BaseService<Address, AddressModel>(mapper, genericRepo)
                                  , IAddressService
    {
        public async Task<bool> DeleteAsync(int addressId) => await base.DeleteAsync(m => m.AddressId == addressId);

        public async Task<AddressModel?> FindAsync(int addressId) => await base.FindByIdAsync(m => m.AddressId == addressId);
    }
}