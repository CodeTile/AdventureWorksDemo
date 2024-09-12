using System.Linq.Expressions;

using AdventureWorksDemo.Data.Models;
using AdventureWorksDemo.Data.Paging;
using AdventureWorksDemo.Data.Repository;

using AutoMapper;

namespace AdventureWorksDemo.Data.Services
{
	public abstract class BaseService<TEntity, TModel>(IMapper mapper,
													   IGenericCrudRepository<TEntity> genericRepo)
		where TEntity : class
		where TModel : class
	{
		/// <summary>
		/// based on:- https://medium.com/@abdulwariis/building-a-generic-service-for-crud-operations-in-c-net-core-3db40c2c8c8a
		/// </summary>

		internal readonly IMapper _mapper = mapper;
		internal readonly IGenericCrudRepository<TEntity> genericRepo = genericRepo;

		public virtual async Task<TModel> AddAsync(TModel model)
		{
			//TODO: Add new record validation
			var entity = _mapper.Map<TEntity>(model);
			await PreDataMutationAsync(entity);
			var result = await genericRepo.AddAsync(entity);
			return _mapper.Map<TModel>(result);
		}

		public virtual async Task<IEnumerable<TModel>> AddBatchAsync(IEnumerable<TModel> models)
		{
			//TODO: Add new record validation
			var entities = _mapper.Map<IEnumerable<TEntity>>(models);
			await PreDataMutationAsync(entities);
			var result = await genericRepo.AddBatchAsync(entities);
			return _mapper.Map<IEnumerable<TModel>>(result);
		}

		public virtual async Task<PagedList<TModel>?> FindAllAsync(PageingFilter pageingFilter)
		{
			return await FindAllAsync(pageingFilter, null);
		}

		public virtual async Task<PagedList<TModel>?> FindAllAsync(PageingFilter paging,
																   Expression<Func<TEntity, bool>>? predictate)
		{
			IQueryable<TEntity>? query = genericRepo.FindEntities(predictate);
			if (query == null)
				return default;
			PagedList<TEntity> result = await PagedList<TEntity>.CreateAsync(query
														, paging.PageNumber
														, paging.PageSize);
			return EntityPagedListToModelPagedList(result);
		}

		public virtual async Task<TModel> UpdateAsync(TModel model)
		{
			//TODO: Add modify record validation
			var entity = _mapper.Map<TEntity>(model);
			await PreDataMutationAsync(entity);
			var result = await genericRepo.UpdateAsync(entity);
			return _mapper.Map<TModel>(result);
		}

		public virtual async Task<IEnumerable<TModel>> UpdateAsync(IEnumerable<TModel> models)
		{
			TEntity[] entities = _mapper.Map<TEntity[]>(models);
			await PreDataMutationAsync(entities);

			TEntity[] result = await genericRepo.UpdateAsync(entities);

			return _mapper.Map<TModel[]>(result);
		}

		internal virtual async Task<IServiceResult<bool>> DeleteAsync(Expression<Func<TEntity, bool>> predictate)
		{
			//TODO: Add validation on delete.
			return await genericRepo.DeleteAsync(predictate);
		}

		internal virtual PagedList<TModel> EntityPagedListToModelPagedList(PagedList<TEntity> source)
		{
			var mappedItems = _mapper.Map<TModel[]>(source.ToArray());
			return new PagedList<TModel>(mappedItems, source.TotalCount, source.CurrentPage, source.PageSize)
			{
				TotalPages = source.TotalPages,
			};
		}

		internal virtual async Task<TModel?> FindByIdAsync(Expression<Func<TEntity, bool>> predictate)
		{
			var result = (await genericRepo.GetByIdAsync(predictate));
			return _mapper.Map<TModel>(result);
		}

		internal virtual async Task PreDataMutationAsync(IEnumerable<TEntity> entities)
		{
			foreach (TEntity entity in entities.AsParallel())
			{
				await PreDataMutationAsync(entity);
			}
		}

		internal virtual async Task PreDataMutationAsync(TEntity entity)
		{
			await Task.Delay(0);
		}
	}
}