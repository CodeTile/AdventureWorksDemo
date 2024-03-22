using System.Linq.Expressions;
using AdventureWorksDemo.Data.DbContexts;
using AutoMapper;
using Microsoft.EntityFrameworkCore;

namespace AdventureWorksDemo.Data.Repository
{
    public interface IGenericCRUDRepository<TModel, TEntity>
    {
        Task<TEntity> Add(TEntity dto, params Expression<Func<TModel, object>>[] references);

        Task<bool> Delete(int id);

        Task<IEnumerable<TEntity>> GetAll(Expression<Func<TModel, bool>>? where = null, params string[] includes);

        Task<TEntity?> GetById(Expression<Func<TModel, bool>> predicateToGetId, params string[] includes);

        Task<TEntity> Update(TEntity dto, Expression<Func<TModel, bool>>? where = null, params Expression<Func<TModel, object>>[] references);
    }

    public class GenericCRUDRepository<TModel, TEntity>(IMapper mapper, dbContext context) : IGenericCRUDRepository<TModel, TEntity>
    where TModel : class
    where TEntity : class
    {
        private readonly DbContext _dbContext = context;
        private readonly IMapper _mapper = mapper;

        public async Task<TEntity> Add(TEntity dto, params Expression<Func<TModel, object>>[] references)
        {
            var entity = _mapper.Map<TModel>(dto);
            _dbContext.Set<TModel>().Add(entity);

            await LoadReferences(entity, references);
            await _dbContext.SaveChangesAsync();

            return _mapper.Map<TEntity>(entity);
        }

        public async Task<bool> Delete(int id)
        {
            var entity = await _dbContext.Set<TModel>().FindAsync(id);
            if (entity == null)
            {
                return false;
            }

            _dbContext.Set<TModel>().Remove(entity);
            await _dbContext.SaveChangesAsync();

            return true;
        }

        public async Task<IEnumerable<TEntity>> GetAll(Expression<Func<TModel, bool>>? where = null,
                            params string[] includes)
        {
            var query = ApplyIncludes(_dbContext.Set<TModel>(), includes);

            if (where != null)
            {
                query = query.Where(where);
            }

            var entities = await query.ToListAsync();
            return _mapper.Map<IEnumerable<TEntity>>(entities);
        }

        public async Task<TEntity?> GetById(Expression<Func<TModel, bool>> predicateToGetId,
            params string[] includes)
        {
            var query = ApplyIncludes(_dbContext.Set<TModel>(), includes);

            var entity = await query.FirstOrDefaultAsync(predicateToGetId);
            return entity == null ? null : _mapper.Map<TEntity>(entity);
        }

        public async Task<TEntity> Update(TEntity dto, Expression<Func<TModel, bool>>? where = null,
            params Expression<Func<TModel, object>>[] references)
        {
            var query = _dbContext.Set<TModel>().AsQueryable();

            if (where != null)
            {
                query = query.Where(where);
            }

            var entity = await query.FirstOrDefaultAsync() ?? throw new Exception("Entity not found");
            await LoadReferences(entity, references);
            await _dbContext.SaveChangesAsync();
            return _mapper.Map<TEntity>(entity);
        }

        private IQueryable<TModel> ApplyIncludes(IQueryable<TModel> query, IEnumerable<string> includes)
        {
            return includes.Aggregate(query, (current, include) => current.Include(include));
        }

        private async Task LoadReferences(TModel entity, IEnumerable<Expression<Func<TModel, object>>> references)
        {
            foreach (var reference in references)
            {
                await _dbContext.Entry(entity).Reference(reference!).LoadAsync();
            }
        }
    }
}