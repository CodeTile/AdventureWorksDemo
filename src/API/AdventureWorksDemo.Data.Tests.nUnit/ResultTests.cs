namespace AdventureWorksDemo.Data.Tests.nUnit
{
	public class ResultTests
	{
		private FakeTimeProvider? _fakeTimeProvider;

		[SetUp]
		public void Setup()
		{
			_fakeTimeProvider = new FakeTimeProvider();
			_fakeTimeProvider.SetUtcNow(new DateTimeOffset(new DateTime(2024, 8, 17, 12, 34, 56, DateTimeKind.Local)));
		}

		[Test]
		public void TestResult()
		{
			// Arrange
			dynamic? expectedValue = "Hello";
			string expectedMessage = "World";
			// Act
			IServiceResult<string> actual = ServiceResult<string>.Success(expectedValue, expectedMessage);

			// Assert
			actual.IsSuccess.Should().BeTrue();
			actual.IsFailure.Should().BeFalse();

			actual.Message.Should().Be(expectedMessage);
		}
	}
}