using System.Linq.Expressions;

using AdventureWorksDemo.Data.Models;
using AdventureWorksDemo.Data.Paging;
using AdventureWorksDemo.Data.Repository;

using AutoMapper;

using FluentValidation;

namespace AdventureWorksDemo.Data.Services
{
	public abstract class BaseService<TEntity, TModel>(IMapper mapper,
													   IGenericCrudRepository<TEntity> genericRepo,
													   IValidator<TEntity>? validator)
		where TEntity : class
		where TModel : class
	{
		/// <summary>
		/// based on:- https://medium.com/@abdulwariis/building-a-generic-service-for-crud-operations-in-c-net-core-3db40c2c8c8a
		/// </summary>

		internal readonly IGenericCrudRepository<TEntity> _genericRepo = genericRepo;
		internal readonly IMapper _mapper = mapper;
		internal readonly IValidator<TEntity>? _validator = validator;

		public virtual async Task<IServiceResult<TModel>> AddAsync(TModel model)
		{
			var validationResult = ValidateRecord(model, out TEntity entity);

			if (validationResult.IsFailure)
				return validationResult;
			await PreDataMutationAsync(entity);

			IServiceResult<TEntity> result = await _genericRepo.AddAsync(entity);
			var mapped = _mapper.Map<TModel>(result.Value);
			return new ServiceResult<TModel>()
			{
				IsSuccess = result.IsSuccess,
				Message = result.Message,
				Value = mapped,
			};
		}

		public virtual async Task<IServiceResult<IEnumerable<TModel>>> AddBatchAsync(IEnumerable<TModel> models)
		{
			IServiceResult<IEnumerable<IServiceResult<TModel>>> validationResult = ValidateRecords(models, out IEnumerable<TEntity> entities);
			if (validationResult.IsFailure)
			{
				return new ServiceResult<IEnumerable<TModel>>()
				{
					IsSuccess = validationResult.IsSuccess,
					Message = validationResult.Message,
					Value = models,
				};
			}
			await PreDataMutationAsync(entities);
			var result = await _genericRepo.AddBatchAsync(entities);
			return new ServiceResult<IEnumerable<TModel>>()
			{
				IsSuccess = result.IsSuccess,
				Message = result.Message,
				Value = _mapper.Map<IEnumerable<TModel>>(result.Value),
			};
		}

		public virtual async Task<PagedList<TModel>> FindAllAsync(PageingFilter pageingFilter)
		{
			return await FindAllAsync(pageingFilter, null);
		}

		public virtual async Task<PagedList<TModel>> FindAllAsync(PageingFilter paging,
																   Expression<Func<TEntity, bool>>? predictate)
		{
			IQueryable<TEntity>? query = _genericRepo.FindEntities(predictate);
			if (query == null)
				return default;
			PagedList<TEntity> result = await PagedList<TEntity>.CreateAsync(query
														, paging.PageNumber
														, paging.PageSize);
			return EntityPagedListToModelPagedList(result);
		}

		public virtual async Task<IServiceResult<TModel>> UpdateAsync(TModel model)
		{
			var validationResult = ValidateRecord(model, out TEntity entity);
			if (validationResult.IsFailure)
				return validationResult;

			await PreDataMutationAsync(entity);

			var result = await _genericRepo.UpdateAsync(entity);
			return new ServiceResult<TModel>()
			{
				IsSuccess = result.IsSuccess,
				Message = result.Message,
				Value = _mapper.Map<TModel>(result.Value),
			};
		}

		public virtual async Task<IServiceResult<IEnumerable<TModel>>> UpdateAsync(IEnumerable<TModel> models)
		{
			IServiceResult<IEnumerable<IServiceResult<TModel>>> validationResult = ValidateRecords(models, out IEnumerable<TEntity> entities);
			if (validationResult.IsFailure)
			{
				return new ServiceResult<IEnumerable<TModel>>()
				{
					IsSuccess = validationResult.IsSuccess,
					Message = validationResult.Message,
					Value = models,
				};
			};
			await PreDataMutationAsync(entities);

			var result = await _genericRepo.UpdateAsync(entities);
			return new ServiceResult<IEnumerable<TModel>>()
			{
				IsSuccess = result.IsSuccess,
				Message = result.Message,
				Value = _mapper.Map<TModel[]>(result.Value),
			};
		}

		public virtual IServiceResult<IEnumerable<IServiceResult<TModel>>> ValidateRecords(IEnumerable<TModel> models, out IEnumerable<TEntity> entities)
		{
			var result = new ServiceResult<IEnumerable<IServiceResult<TModel>>>() { IsSuccess = true };

			if (_validator != null)
			{
				var localEntities = new List<TEntity>();
				var localList = new List<IServiceResult<TModel>>();
				foreach (var model in models.AsParallel())
				{
					localList.Add(ValidateRecord(model, out TEntity entity));
					localEntities.Add(entity);
				}
				entities = localEntities;
				result.Value = localList;
				result.IsSuccess = !localList.Exists(m => m.IsFailure);
				if (result.IsFailure)
				{
					var local = localList.Where(m => m.IsFailure).ToList();
					result.Message = string.Join("\r\n", local.Select(m => m.Message));
				}
			}
			else
				entities = _mapper.Map<IEnumerable<TEntity>>(models);

			return result;
		}

		internal virtual async Task<IServiceResult<bool>> DeleteAsync(Expression<Func<TEntity, bool>> predictate)
		{
			//TODO: Add validation on delete.
			return await _genericRepo.DeleteAsync(predictate);
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
			var result = (await _genericRepo.GetByIdAsync(predictate));
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

		internal virtual IServiceResult<TModel> ValidateRecord(TModel model, out TEntity entity)
		{
			var result = new ServiceResult<TModel>() { IsSuccess = true };

			entity = _mapper.Map<TEntity>(model);

			if (_validator != null)
			{
				var validationResult = _validator.Validate(entity);
				if (!validationResult.IsValid)
				{
					result.IsSuccess = false;
					result.Message = validationResult.ToString();
					result.Value = model;
				}
			}
			return result;
		}
	}
}