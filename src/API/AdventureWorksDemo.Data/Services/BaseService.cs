using System.Linq.Expressions;

using AdventureWorksDemo.Data.Models;
using AdventureWorksDemo.Data.Paging;
using AdventureWorksDemo.Data.Repository;

using AutoMapper;

using FluentValidation;

namespace AdventureWorksDemo.Data.Services
{
	public abstract class BaseService<TEntity, TModel>(
	IMapper mapper,
	IGenericCrudRepository<TEntity> repository,
	IValidator<TEntity>? validator)
	where TEntity : class
	where TModel : class
	{
		/// <summary>
		/// based on:- https://medium.com/@abdulwariis/building-a-generic-service-for-crud-operations-in-c-net-core-3db40c2c8c8a
		/// </summary>

		protected readonly IMapper _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
		protected readonly IGenericCrudRepository<TEntity> _repository = repository ?? throw new ArgumentNullException(nameof(repository));
		protected readonly IValidator<TEntity>? _validator = validator;

		public virtual async Task<IServiceResult<TModel>> AddAsync(TModel model)
		{
			var validationResult = ValidateRecord(model, out TEntity entity);

			if (validationResult.IsFailure)
				return validationResult;

			PreDataMutation(entity);

			IServiceResult<TEntity> result = await _repository.AddAsync(entity);
			return new ServiceResult<TModel>()
			{
				IsSuccess = result.IsSuccess,
				Message = result.Message,
				Value = _mapper.Map<TModel>(result.Value),
			};
		}

		public virtual async Task<IServiceResult<IEnumerable<TModel>>> AddBatchAsync(IEnumerable<TModel> models)
		{
			// Early exit for empty collections
			if (models == null || !models.Any())
			{
				return new ServiceResult<IEnumerable<TModel>>()
				{
					IsSuccess = false,
					Message = "No records provided for addition.",
					Value = models,
				};
			}

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
			var result = await _repository.AddBatchAsync(entities.AsQueryable());

			return new ServiceResult<IEnumerable<TModel>>()
			{
				IsSuccess = result.IsSuccess,
				Message = result.Message,
				Value = _mapper.Map<IEnumerable<TModel>>(result.Value),
			};
		}

		public virtual async Task<PagedList<TModel>> FindAllAsync(PageingFilter pageingFilter) => await FindAllAsync(pageingFilter, null);

		public virtual async Task<PagedList<TModel>> FindAllAsync(PageingFilter paging,
																   Expression<Func<TEntity, bool>>? predicate)
		{
			IQueryable<TEntity>? query = _repository.FindEntities(predicate);
			if (query == null)
				return [];

			PagedList<TEntity> result = await PagedList<TEntity>.CreateAsync(query
														, paging.PageNumber
														, paging.PageSize);
			return EntityPagedListToModelPagedList(result);
		}

		public async Task<IServiceResult<TModel>> UpdateAsync(TModel model,
															  Expression<Func<TEntity, bool>> predicate)
		{
			var recordToUpdate = await FindByIdAsync(predicate);
			if (recordToUpdate == null)
			{
				return ServiceResult<TModel>.Failure(model, "Unable to locate record to update!");
			}
			else if (recordToUpdate.Equals(model))
			{
				return ServiceResult<TModel>.Success(recordToUpdate, "Record is already up to date!");
			}

			TransposeModel(recordToUpdate, model);

			var validationResult = ValidateRecord(recordToUpdate, out TEntity entity);
			if (validationResult.IsFailure)
				return validationResult;

			PreDataMutation(entity);

			var result = await _repository.UpdateAsync(entity);
			return new ServiceResult<TModel>()
			{
				IsSuccess = result.IsSuccess,
				Message = result.Message,
				Value = _mapper.Map<TModel>(result.Value),
			};
		}

		public virtual async Task<IServiceResult<IEnumerable<TModel>>> UpdateAsync(IEnumerable<TModel> models)
		{
			List<TModel> modelsToUpdate = [];
			foreach (var model in models.AsParallel())
			{
				var original = await FindAsync(model);
				if (original == null || !IsModelDirty(original, model))
					continue;
				TransposeModel(original, model);
				modelsToUpdate.Add(original);
			}
			if (modelsToUpdate.Count == 0)
			{
				return new ServiceResult<IEnumerable<TModel>>()
				{
					IsSuccess = false,
					Message = "Please select some records to update!",
					Value = models,
				};
			}
			IServiceResult<IEnumerable<IServiceResult<TModel>>> validationResult = ValidateRecords(modelsToUpdate,
				out IEnumerable<TEntity> entities);

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

			var result = await _repository.UpdateAsync(entities);
			return new ServiceResult<IEnumerable<TModel>>()
			{
				IsSuccess = result.IsSuccess,
				Message = result.Message,
				Value = _mapper.Map<TModel[]>(result.Value),
			};
		}

		internal static string TransposeIfNotNull(string original, string mutated)
		{
			if (mutated != null && !original.Equals(mutated))
				original = mutated;
			return original;
		}

		internal virtual async Task<IServiceResult<bool>> DeleteAsync(Expression<Func<TEntity, bool>> predicate)
		{
			return await _repository.DeleteAsync(predicate);
		}

		internal virtual PagedList<TModel> EntityPagedListToModelPagedList(PagedList<TEntity> source)
		{
			var mappedItems = _mapper.Map<TModel[]>(source.ToArray());
			return new PagedList<TModel>(mappedItems, source.TotalCount, source.CurrentPage, source.PageSize)
			{
				TotalPages = source.TotalPages,
			};
		}

		internal abstract Task<TModel?> FindAsync(TModel model);

		internal virtual async Task<TModel> FindByIdAsync(Expression<Func<TEntity, bool>> predicate)
		{
			TEntity? result = (await _repository.GetByIdAsync(predicate));
			return _mapper.Map<TModel>(result);
		}

		internal abstract bool IsModelDirty(TModel original, TModel mutated);

		internal abstract void PreDataMutation(TEntity entity);

		internal virtual async Task PreDataMutationAsync(IEnumerable<TEntity> entities)
		{
			await Task.Delay(0);
			foreach (TEntity entity in entities.AsParallel())
			{
				PreDataMutation(entity);
			}
		}

		internal abstract void TransposeModel(TModel original, TModel mutated);

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

		internal virtual IServiceResult<IEnumerable<IServiceResult<TModel>>> ValidateRecords(IEnumerable<TModel> models, out IEnumerable<TEntity> entities)
		{
			var result = new ServiceResult<IEnumerable<IServiceResult<TModel>>>() { IsSuccess = true };

			if (models == null || !models.Any())
			{
				entities = [];
				return new ServiceResult<IEnumerable<IServiceResult<TModel>>>()
				{
					IsSuccess = false,
					Value = [],
					Message = "Please select some records to update!"
				};
			}

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
	}
}