using Microsoft.Win32;

namespace AdventureWorksDemo.Data.Models
{
	public interface IServiceResult
	{
		bool IsFailure { get; }
		bool IsSuccess { get; }
		string? Message { get; }
	}

	public interface IServiceResult<T> : IServiceResult
	{
		T? Value { get; set; }
	}

	public class ServiceResult : IServiceResult
	{
		public bool IsFailure => !IsSuccess;
		public bool IsSuccess { get; set; }
		public string? Message { get; internal set; }

		public static ServiceResult Simple(IServiceResult existing)
		{
			return new ServiceResult()
			{
				IsSuccess = existing.IsSuccess,
				Message = existing.Message,
			};
		}
	}

	public class ServiceResult<T> : ServiceResult, IServiceResult<T>
	{
		public T? Value { get; set; }

		public static ServiceResult<T> Failure(dynamic? result, string? message = null)
		{
			var retval = new ServiceResult<T>()
			{
				IsSuccess = false,
				Value = result,
				Message = message,
			};

			return retval;
		}

		public static ServiceResult<T> Success(dynamic? result, string? message = null) => new()
		{
			IsSuccess = true,
			Value = result,
			Message = message,
		};
	}
}