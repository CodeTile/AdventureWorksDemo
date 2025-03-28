using System.Linq.Expressions;

using AdventureWorksDemo.Data.DbContexts;
using AdventureWorksDemo.Data.Models;

using Microsoft.EntityFrameworkCore;

namespace AdventureWorksDemo.Data.Repository
{
	public interface IGenericCrudRepository<TEntity> where TEntity : class
	{
		/// <summary>
		/// Adds a new entity to the repository.
		/// </summary>
		Task<IServiceResult<TEntity>> AddAsync(TEntity entity, params Expression<Func<TEntity, object>>[] references);

		/// <summary>
		/// Adds multiple entities to the repository.
		/// </summary>
		Task<IServiceResult<IEnumerable<TEntity>>> AddBatchAsync(IEnumerable<TEntity> entities, params Expression<Func<TEntity, object>>[] references);

		/// <summary>
		/// Deletes entities matching the specified predicate.
		/// </summary>
		Task<IServiceResult<bool>> DeleteAsync(Expression<Func<TEntity, bool>> predicate);

		/// <summary>
		/// Finds entities matching the specified predicate, with optional includes.
		/// </summary>
		IQueryable<TEntity>? FindEntities(Expression<Func<TEntity, bool>>? predicate = null, params string[] includes);

		/// <summary>
		/// Gets an entity by its unique identifier.
		/// </summary>
		Task<TEntity?> GetByIdAsync(Expression<Func<TEntity, bool>> predicate, params string[] includes);

		/// <summary>
		/// Updates a single entity.
		/// </summary>
		Task<IServiceResult<TEntity>> UpdateAsync(TEntity entity);

		/// <summary>
		/// Updates multiple entities.
		/// </summary>
		Task<IServiceResult<IEnumerable<TEntity>>> UpdateAsync(IEnumerable<TEntity> entities);
	}

	public class GenericCrudRepository<TEntity>(AdventureWorksContext context) : IGenericCrudRepository<TEntity> where TEntity : class
	{
		// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Class is based on https://medium.com/@abdulwariis/building-a-generic-service-for-crud-operations-in-c-net-core-3db40c2c8c8a
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// //

		private readonly DbContext _dbContext = context ?? throw new ArgumentNullException(nameof(context));

		public async Task<IServiceResult<TEntity>> AddAsync(TEntity entity, params Expression<Func<TEntity, object>>[] references)
		{
			ArgumentNullException.ThrowIfNull(entity);

			_dbContext.Set<TEntity>().Add(entity);

			await LoadReferences(entity, references);
			var result = await _dbContext.SaveChangesAsync();
			return new ServiceResult<TEntity>()
			{
				IsSuccess = result > 0,
				Value = entity,
			};
		}

		public async Task<IServiceResult<IEnumerable<TEntity>>> AddBatchAsync(IEnumerable<TEntity> entities, params Expression<Func<TEntity, object>>[] references)
		{
			ArgumentNullException.ThrowIfNull(entities);

			await _dbContext.Set<TEntity>().AddRangeAsync(entities);

			await LoadReferences(entities, references);
			var result = await _dbContext.SaveChangesAsync();
			return new ServiceResult<IEnumerable<TEntity>>()
			{
				IsSuccess = (entities.Count()) == result,
				Value = entities,
			};
		}

		public async Task<IServiceResult<bool>> DeleteAsync(Expression<Func<TEntity, bool>> predicate)
		{
			ArgumentNullException.ThrowIfNull(predicate);

			var entities = FindEntities(predicate);
			if (entities == null || !await entities.AnyAsync())
			{
				return ServiceResult<bool>.Failure(false, "Unable to find record to delete!");
			}

			_dbContext.RemoveRange(entities);
			try
			{
				int result = await _dbContext.SaveChangesAsync();
				if (result == 1)
					return ServiceResult<bool>.Success(true);
				else
					return ServiceResult<bool>.Failure(false);
			}
			catch (Exception ex)
			{
				return ServiceResult<bool>.Failure(false, GenericCrudRepository<TEntity>.ConvertExceptionToUserMessage(ex));
			}
		}

		public IQueryable<TEntity>? FindEntities(Expression<Func<TEntity, bool>>? predicate = null,
												params string[] includes)
		{
			var query = GenericCrudRepository<TEntity>.ApplyIncludes(_dbContext.Set<TEntity>(), includes);

			return predicate != null ? query.Where(predicate) : query;
		}

		public async Task<TEntity?> GetByIdAsync(Expression<Func<TEntity, bool>> predicate,
												 params string[] includes)
		{
			ArgumentNullException.ThrowIfNull(predicate);

			var query = GenericCrudRepository<TEntity>.ApplyIncludes(_dbContext.Set<TEntity>(), includes);
			return await query.AsNoTracking().FirstOrDefaultAsync(predicate);
		}

		public async Task<IServiceResult<TEntity>> UpdateAsync(TEntity entity)
		{
			ArgumentNullException.ThrowIfNull(entity);

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

		private static IQueryable<TEntity> ApplyIncludes(IQueryable<TEntity> query, IEnumerable<string> includes)
		{
			return includes.Aggregate(query, (current, include) => current.Include(include));
		}

		private static string ConvertExceptionToUserMessage(Exception ex)
		{
			ArgumentNullException.ThrowIfNull(ex);

			string message = ex.Message;
			if (ex.InnerException != null)
			{
				message = ConvertExceptionToUserMessage(ex.InnerException);
			}

			if (message.Contains("REFERENCE constraint", StringComparison.OrdinalIgnoreCase))
			{
				return "Unable to delete, record is referenced elsewhere!";
			}

			return message;
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