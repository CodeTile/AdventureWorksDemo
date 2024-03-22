using AutoMapper;
using AdventureWorksDemo.Data.Entities;

using AdventureWorksDemo.Data.Paging;
using AdventureWorksDemo.Data.Models;

namespace AdventureWorksDemo.Data.StartUp
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Address, AddressModel>();
            CreateMap<AddressModel, Address>();
            CreateMap<PagedList<Address>, PagedList<AddressModel>>().ForMember("Item", opt => opt.Ignore());
        }
    }
}