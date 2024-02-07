using AdventureWorksDemo.Data.DbContexts;
using AdventureWorksDemo.Data.Paging;
using AutoMapper;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace AdventureWorksDemo.Data.Services
{
    public abstract class BaseService<TEntity, TDto>(dbContext context,
                                                       IMapper mapper
                                                       ) where TEntity : class
    {
        /// <summary>
        /// based on:- https://medium.com/@abdulwariis/building-a-generic-service-for-crud-operations-in-c-net-core-3db40c2c8c8a
        /// </summary>
        internal dbContext _dbContext = context;

        internal IMapper _mapper = mapper;

        public async Task<PagedList<TDto>> GetAllAsync(PageingFilter paging)
        {
            PagedList<TEntity> result = await PagedList<TEntity>.CreateAsync(await FindEntitiesAsync()
                                                        , paging.PageNumber
                                                        , paging.PageSize);
            return EntityPagedListToDtoPagedList(result);
        }

        internal PagedList<TDto> EntityPagedListToDtoPagedList(PagedList<TEntity> source)
        {
            var mappedItems = _mapper.Map<TDto[]>(source.ToArray());
            return new PagedList<TDto>(mappedItems, source.TotalCount, source.CurrentPage, source.PageSize)
            {
                TotalPages = source.TotalPages,
            };
        }

        internal async Task<TDto?> FindDTOAsync(Expression<Func<TEntity, bool>> predictate, params string[] includes)
        {
            var result = await FindEntityAsync(predictate, includes);
            return result == null ? default : _mapper.Map<TDto>(result);
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
            return includes.Aggregate(query, (current, include) => current.Include(include));
        }
    }
}