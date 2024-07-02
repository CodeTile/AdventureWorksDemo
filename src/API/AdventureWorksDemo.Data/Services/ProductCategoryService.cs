using System.Linq.Expressions;

using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Models;
using AdventureWorksDemo.Data.Paging;
using AdventureWorksDemo.Data.Repository;

using AutoMapper;

namespace AdventureWorksDemo.Data.Services
{
    public interface IProductCategoryService
    {
        Task<ProductCategoryModel> AddAsync(ProductCategoryModel model);

        Task<bool> DeleteAsync(int productCategoryId);

        Task<PagedList<ProductCategoryModel>?> FindAllAsync(PageingFilter pageingFilter);

        Task<PagedList<ProductCategoryModel>?> FindAllAsync(PageingFilter paging, Expression<Func<ProductCategory, bool>>? predictate);

        Task<ProductCategoryModel?> FindAsync(int productCategoryId);
    }

    public class ProductCategoryService(IMapper mapper, IGenericCrudRepository<ProductCategory> genericRepo, TimeProvider timeProvider) : BaseService<ProductCategory, ProductCategoryModel>(mapper, genericRepo)
                                                                                                              , IProductCategoryService
    {
        public async Task<bool> DeleteAsync(int productCategoryId) => await base.DeleteAsync(m => m.ProductCategoryId == productCategoryId);

        public async Task<ProductCategoryModel?> FindAsync(int productCategoryId) => await base.FindByIdAsync(m => m.ProductCategoryId == productCategoryId);

        internal override void PreDataMutation(ProductCategory entity)
        {
            entity.ModifiedDate = timeProvider.GetLocalNow().DateTime;
        }
    }
}