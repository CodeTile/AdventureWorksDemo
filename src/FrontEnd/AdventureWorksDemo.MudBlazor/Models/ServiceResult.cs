namespace AdventureWorksDemo.MudBlazor.Models
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
	public class ServiceResult<T>() : IServiceResult<T>
	{
		public T? Value {get;set;}

		public bool IsFailure { get; set; }

		public bool IsSuccess { get; set; }

		public string? Message { get; set; }
	}
}
