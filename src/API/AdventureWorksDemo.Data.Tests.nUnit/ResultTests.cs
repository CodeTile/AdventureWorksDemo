using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Models;
using AdventureWorksDemo.Data.Repository;
using AdventureWorksDemo.Data.Tests.nUnit.Helpers;

using FluentAssertions;

using Microsoft.Extensions.Time.Testing;

namespace AdventureWorksDemo.Data.Tests.nUnit
{
	public class ResultTests
	{
		private FakeTimeProvider _fakeTimeProvider;

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

			//Assert.(actual.Value, expectedValue);
		}
	}
}