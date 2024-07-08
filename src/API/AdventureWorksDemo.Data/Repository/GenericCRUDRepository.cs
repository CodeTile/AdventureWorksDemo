using System.Linq.Expressions;

using AdventureWorksDemo.Data.DbContexts;

using Microsoft.EntityFrameworkCore;

namespace AdventureWorksDemo.Data.Repository
{
    public interface IGenericCrudRepository<TEntity>
    {
        Task<TEntity> AddAsync(TEntity entity, params Expression<Func<TEntity, object>>[] references);

        Task<IEnumerable<TEntity>> AddBatchAsync(IEnumerable<TEntity> entities, params Expression<Func<TEntity, object>>[] references);

        Task<bool> DeleteAsync(Expression<Func<TEntity, bool>> predictate);

        IQueryable<TEntity>? FindEntities(Expression<Func<TEntity, bool>>? predictate = null, params string[] includes);

        Task<TEntity?> GetByIdAsync(Expression<Func<TEntity, bool>> predicateToGetId, params string[] includes);

        Task<TEntity> UpdateAsync(TEntity entity);
    }

    public class GenericCrudRepository<TEntity>(dbContext context, TimeProvider timeProvider) : IGenericCrudRepository<TEntity> where TEntity : class
    {
        // ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        // Class is based on https://medium.com/@abdulwariis/building-a-generic-service-for-crud-operations-in-c-net-core-3db40c2c8c8a
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        // //

        private readonly DbContext _dbContext = context;

        public async Task<TEntity> AddAsync(TEntity entity, params Expression<Func<TEntity, object>>[] references)
        {
            _dbContext.Set<TEntity>().Add(entity);

            await LoadReferences(entity, references);
            await _dbContext.SaveChangesAsync();
            return entity;
        }

        public async Task<IEnumerable<TEntity>> AddBatchAsync(IEnumerable<TEntity> entities, params Expression<Func<TEntity, object>>[] references)
        {
            await _dbContext.Set<TEntity>().AddRangeAsync(entities);

            await LoadReferences(entities, references);
            await _dbContext.SaveChangesAsync();
            return (IEnumerable<TEntity>)entities;
        }

        public async Task<bool> DeleteAsync(Expression<Func<TEntity, bool>> predictate)
        {
            var entities = FindEntities(predictate);
            if (entities == null || !entities.Any())
            {
                return false;
            }

            _dbContext.RemoveRange(entities);
            await _dbContext.SaveChangesAsync();
            return true;
        }

        public IQueryable<TEntity>? FindEntities(Expression<Func<TEntity, bool>>? predictate = null,
                                                params string[] includes)
        {
            var query = ApplyIncludes(_dbContext.Set<TEntity>(), includes);

            if (predictate != null)
            {
                query = query.Where(predictate);
            }
            return query;
        }

        public async Task<TEntity?> GetByIdAsync(Expression<Func<TEntity, bool>> predicateToGetId,
                                                 params string[] includes)
        {
            var query = ApplyIncludes(_dbContext.Set<TEntity>(), includes);
            return await query.AsNoTracking().FirstOrDefaultAsync(predicateToGetId);
        }

        public async Task<TEntity> UpdateAsync(TEntity entity)
        {
            _dbContext.Update(entity);
            await _dbContext.SaveChangesAsync();
            return entity;
        }

        internal async Task<bool> DeleteAsync(TEntity? entity)
        {
            if (entity == null)
            {
                return false;
            }

            _dbContext.Set<TEntity>().Remove(entity);
            var result = await _dbContext.SaveChangesAsync();
            return result == 1;
        }

        private IQueryable<TEntity> ApplyIncludes(IQueryable<TEntity> query, IEnumerable<string> includes)
        {
            return includes.Aggregate(query, (current, include) => current.Include(include));
        }

        private async Task LoadReferences(TEntity entity, IEnumerable<Expression<Func<TEntity, object>>> references)
        {
            foreach (var reference in references)
            {
                await _dbContext.Entry(entity).Reference(reference!).LoadAsync();
            }
        }

        private async Task LoadReferences(IEnumerable<TEntity> entities, IEnumerable<Expression<Func<TEntity, object>>> references)
        {
            foreach (var entity in entities)
            {
                await LoadReferences(entity, references);
            }
        }
    }
}