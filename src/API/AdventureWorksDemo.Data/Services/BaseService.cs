using AdventureWorksDemo.Data.DbContexts;
using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Models;
using AdventureWorksDemo.Data.Paging;
using AdventureWorksDemo.Data.Repository;
using AutoMapper;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace AdventureWorksDemo.Data.Services
{
    public abstract class BaseService<TEntity, TModel>(dbContext context,
                                                       IMapper mapper,
                                                       IGenericCRUDRepository<TModel, TEntity> genericRepo
                                                       ) where TEntity : class
    {
        /// <summary>
        /// based on:- https://medium.com/@abdulwariis/building-a-generic-service-for-crud-operations-in-c-net-core-3db40c2c8c8a
        /// </summary>
        internal readonly dbContext _dbContext = context;

        internal readonly IMapper _mapper = mapper;
        internal readonly IGenericCRUDRepository<TModel, TEntity> genericRepo = genericRepo;

        public async Task<PagedList<TModel>> FindAllAsync(PageingFilter paging)
        {
            var debug = await FindEntitiesAsync();
            PagedList<TEntity> result = await PagedList<TEntity>.CreateAsync(await FindEntitiesAsync()
                                                        , paging.PageNumber
                                                        , paging.PageSize);
            return EntityPagedListToDtoPagedList(result);
        }

        internal PagedList<TModel> EntityPagedListToDtoPagedList(PagedList<TEntity> source)
        {
            var mappedItems = _mapper.Map<TModel[]>(source.ToArray());
            return new PagedList<TModel>(mappedItems, source.TotalCount, source.CurrentPage, source.PageSize)
            {
                TotalPages = source.TotalPages,
            };
        }

        internal async Task<TModel?> FindDTOAsync(Expression<Func<TEntity, bool>> predictate, params string[] includes)
        {
            var result = await FindEntityAsync(predictate, includes);
            return result == null ? default : _mapper.Map<TModel>(result);
        }

        internal async Task<IQueryable<TEntity>> FindEntitiesAsync(Expression<Func<TEntity, bool>>? predictate = null, params string[] includes)
        {
            await Task.Delay(0);
            IQueryable<TEntity> query;
            if (predictate is null)
                query = _dbContext.Set<TEntity>();
            else
                query = _dbContext.Set<TEntity>().Where(predictate);
            return ApplyIncludes(query, includes);
        }

        internal async Task<TEntity?> FindEntityAsync(Expression<Func<TEntity, bool>> predictate, params string[] includes)
        {
            IQueryable<TEntity> query = await FindEntitiesAsync(predictate, includes);
            return await query.SingleOrDefaultAsync();
        }

        private IQueryable<TEntity> ApplyIncludes(IQueryable<TEntity> query, params string[] includes)
        {
            if (!includes.Any()) return query;
            return includes.Aggregate(query, (current, include) => current.Include(include));
        }
    }
}