using System.Diagnostics.CodeAnalysis;

namespace AdventureWorksDemo.Data.Tests.nUnit
{
	public class Tests
	{
		private FakeTimeProvider? _fakeTimeProvider;

		[Test]
		public void IsFailure()
		{
			// Arrange
			dynamic? expectedValue = "Hello";
			string expectedMessage = "World";
			// Act
			IServiceResult<string> actual = ServiceResult<string>.Failure(expectedValue, expectedMessage);

			Assert.That(actual.IsSuccess, Is.False);
			Assert.That(actual.IsFailure, Is.True);
			Assert.That(actual.Message, Is.EqualTo(expectedMessage));
		}

		[Test]
		public void IsSuccess()
		{
			// Arrange
			dynamic? expectedValue = "Hello";
			string expectedMessage = "World";
			// Act
			IServiceResult<string> actual = ServiceResult<string>.Success(expectedValue, expectedMessage);

			Assert.That(actual.IsSuccess, Is.True);
			Assert.That(actual.IsFailure, Is.False);
			Assert.That(actual.Message, Is.EqualTo(expectedMessage));
		}

		[SetUp]
		public void Setup()
		{
			_fakeTimeProvider = new FakeTimeProvider();
			_fakeTimeProvider.SetUtcNow(new DateTimeOffset(new DateTime(2024, 8, 17, 12, 34, 56, DateTimeKind.Local)));
		}
	}
}