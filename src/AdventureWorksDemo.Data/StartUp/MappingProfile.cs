using AutoMapper;
using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.DTO;

using AdventureWorksDemo.Data.Paging;

namespace AdventureWorksDemo.Data.StartUp
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Address, AddressDTO>();
            CreateMap<PagedList<Address>, PagedList<AddressDTO>>().ForMember("Item", opt => opt.Ignore());
        }
    }
}