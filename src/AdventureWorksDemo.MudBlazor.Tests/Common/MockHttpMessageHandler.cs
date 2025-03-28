namespace AdventureWorksDemo.MudBlazor.Tests.Common
{
	public class MockHttpMessageHandler : HttpMessageHandler
	{
		public MockHttpMessageHandler(Func<HttpRequestMessage, Task<HttpResponseMessage>> sendAsyncFunc)
		{
			_sendAsyncFunc = sendAsyncFunc;
		}

		private readonly Func<HttpRequestMessage, Task<HttpResponseMessage>> _sendAsyncFunc;

		protected override Task<HttpResponseMessage> SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
		{
			return _sendAsyncFunc(request);
		}
	}
}