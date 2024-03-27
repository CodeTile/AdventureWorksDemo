using AdventureWorksDemo.Data.Entities;

using AdventureWorksDemo.Data.Models;

using AdventureWorksDemo.Data.Paging;

using AutoMapper;

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