using AdventureWorksDemo.Common.Tests.Extensions;
using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Validation;

using FluentValidation.TestHelper;

namespace AdventureWorksDemo.Data.Tests.nUnit.Validation
{
	public class ProductDescriptionValidatorTests
	{
		private FakeTimeProvider? _fakeTimeProvider;

		[TestCase("")]
		[TestCase("1")]
		[TestCase("12")]
		[TestCase("{{PadRight:X:401}}")]
		[Test()]
		public void NameTestError(string value)
		{
			// arrange
			var uot = new ProductDescriptionValidator();
			var entity = new ProductDescription()
			{
				Description = value.InterpretValue(),
			};
			//act
			var result = uot.TestValidate(entity);
			//assert
			result.ShouldHaveValidationErrorFor(m => m.Description);
		}

		[TestCase("123")]
		[TestCase("{{PadRight:X:400}}")]
		[Test]
		public void NameTestGood(string value)
		{
			// arrange
			var uot = new ProductDescriptionValidator();
			var entity = new ProductDescription()
			{
				Description = value,
			};
			//act
			var result = uot.TestValidate(entity);
			//assert
			result.ShouldNotHaveValidationErrorFor(m => m.Description);
		}

		[SetUp]
		public void Setup()
		{
			_fakeTimeProvider = new FakeTimeProvider();
			_fakeTimeProvider.SetUtcNow(new DateTimeOffset(new DateTime(2024, 8, 17, 12, 34, 56, DateTimeKind.Local)));
		}
	}
}