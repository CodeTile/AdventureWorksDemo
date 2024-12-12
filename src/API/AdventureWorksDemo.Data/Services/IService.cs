using System.Linq.Expressions;

using AdventureWorksDemo.Data.Models;
using AdventureWorksDemo.Data.Paging;

namespace AdventureWorksDemo.Data.Services
{
	public interface IAddBatchService<T> : IService
	{
		Task<IServiceResult<IEnumerable<T>>> AddBatchAsync(IEnumerable<T> models);
	}

	public interface IAddService<T> : IService
	{
		Task<IServiceResult<T>> AddAsync(T model);
	}

	public interface IDeleteService<T> : IService
	{
		Task<IServiceResult<bool>> DeleteAsync(T id);
	}

	public interface IFindService<TModel, TId> : IService
	{
		Task<PagedList<TModel>> FindAllAsync(PageingFilter pageingFilter);

		Task<TModel?> FindAsync(TId id);
	}

	public interface IService
	{
	}

	public interface IUpdateBatchService<T> : IService
	{
		Task<IServiceResult<IEnumerable<T>>> UpdateBatchAsync(IEnumerable<T> models);
	}

	public interface IUpdateService<T> : IService
	{
		Task<IServiceResult<T>> UpdateAsync(T model);
	}
}