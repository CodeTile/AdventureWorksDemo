using System.Linq.Expressions;

using AdventureWorksDemo.Data.DbContexts;
using AdventureWorksDemo.Data.Models;

using Microsoft.EntityFrameworkCore;

namespace AdventureWorksDemo.Data.Repository
{
	public interface IGenericCrudRepository<TEntity>
	{
		Task<IServiceResult<TEntity>> AddAsync(TEntity entity, params Expression<Func<TEntity, object>>[] references);

		Task<IServiceResult<IEnumerable<TEntity>>> AddBatchAsync(IEnumerable<TEntity> entities, params Expression<Func<TEntity, object>>[] references);

		Task<IServiceResult<bool>> DeleteAsync(Expression<Func<TEntity, bool>> predictate);

		IQueryable<TEntity>? FindEntities(Expression<Func<TEntity, bool>>? predictate = null, params string[] includes);

		Task<TEntity?> GetByIdAsync(Expression<Func<TEntity, bool>> predicateToGetId, params string[] includes);

		Task<IServiceResult<IEnumerable<TEntity>>> UpdateAsync(IEnumerable<TEntity> entities);

		Task<IServiceResult<TEntity>> UpdateAsync(TEntity entity);
	}

	public class GenericCrudRepository<TEntity>(dbContext context, TimeProvider timeProvider) : IGenericCrudRepository<TEntity> where TEntity : class
	{
		// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Class is based on https://medium.com/@abdulwariis/building-a-generic-service-for-crud-operations-in-c-net-core-3db40c2c8c8a
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// //

		private readonly DbContext _dbContext = context;

		public async Task<IServiceResult<TEntity>> AddAsync(TEntity entity, params Expression<Func<TEntity, object>>[] references)
		{
			_dbContext.Set<TEntity>().Add(entity);

			await LoadReferences(entity, references);
			var result = await _dbContext.SaveChangesAsync();
			return new ServiceResult<TEntity>()
			{
				IsSuccess = (1 == result),
				Value = entity,
			};
		}

		public async Task<IServiceResult<IEnumerable<TEntity>>> AddBatchAsync(IEnumerable<TEntity> entities, params Expression<Func<TEntity, object>>[] references)
		{
			await _dbContext.Set<TEntity>().AddRangeAsync(entities);

			await LoadReferences(entities, references);
			var result = await _dbContext.SaveChangesAsync();
			return new ServiceResult<IEnumerable<TEntity>>()
			{
				IsSuccess = (entities.Count() == result),
				Value = entities,
			};
		}

		public async Task<IServiceResult<bool>> DeleteAsync(Expression<Func<TEntity, bool>> predictate)
		{
			var entities = FindEntities(predictate);
			if (entities == null || !(await entities.AnyAsync()))
			{
				return ServiceResult<bool>.Failure(false);
			}

			_dbContext.RemoveRange(entities);
			int result = await _dbContext.SaveChangesAsync();
			if (result == 1)
				return ServiceResult<bool>.Success(true);
			else
				return ServiceResult<bool>.Failure(false);
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

		public async Task<IServiceResult<TEntity>> UpdateAsync(TEntity entity)
		{
			_dbContext.Update(entity);
			return new ServiceResult<TEntity>()
			{
				IsSuccess = (1 == await _dbContext.SaveChangesAsync()),
				Value = entity,
			};
		}

		public async Task<IServiceResult<IEnumerable<TEntity>>> UpdateAsync(IEnumerable<TEntity> entities)
		{
			_dbContext.UpdateRange(entities);
			var result = await _dbContext.SaveChangesAsync();
			return new ServiceResult<IEnumerable<TEntity>>()
			{
				IsSuccess = entities.Count() == result,
				Value = entities,
			};
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