using Microsoft.Win32;

namespace AdventureWorksDemo.Data.Models
{
	public interface IServiceResult<T>
	{
		bool IsException { get; }
		bool IsFailure { get; }
		bool IsSuccess { get; }
		string? Message { get; }
		T? Value { get; }
	}

	public class ServiceResult<T> : IServiceResult<T>
	{
		public bool IsException => Value is System.Exception;
		public bool IsFailure => !IsSuccess;
		public bool IsSuccess { get; set; }
		public string? Message { get; internal set; }
		public T? Value { get; internal set; }

		public static ServiceResult<T> Failure(dynamic? result, string? message = null)
		{
			var retval = new ServiceResult<T>()
			{
				IsSuccess = false,
				Value = result,
				Message = message,
			};
			if (retval.IsException)
			{
				retval.Message = result?.Message;
			}
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