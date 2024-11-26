using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using AdventureWorksDemo.Common.Tests.Extensions;
using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Validation;

using FluentValidation.TestHelper;

namespace AdventureWorksDemo.Data.Tests.nUnit.Validation
{
	public class ProductCategoryValidatorTests
	{
		private FakeTimeProvider? _fakeTimeProvider;
		private ProductCategoryValidator? _validator;

		[TestCase("")]
		[TestCase("1")]
		[TestCase("12")]
		[TestCase("{{PadRight:X:50}}")]
		[Test()]
		public void NameTestError(string nameValue)
		{
			// arrange
			var entity = new ProductCategory()
			{
				Name = nameValue.InterpretValue(),
			};
			//act
			var result = _validator.TestValidate(entity);
			//assert
			result.ShouldHaveValidationErrorFor(m => m.Name);
		}

		[TestCase("123")]
		[TestCase("{{PadRight:X:49}}")]
		[Test]
		public void NameTestGood(string nameValue)
		{
			// arrange
			var entity = new ProductCategory()
			{
				Name = nameValue,
			};
			//act
			var result = _validator.TestValidate(entity);
			//assert
			result.ShouldNotHaveValidationErrorFor(m => m.Name);
		}

		[SetUp]
		public void Setup()
		{
			_fakeTimeProvider = new FakeTimeProvider();
			_fakeTimeProvider.SetUtcNow(new DateTimeOffset(new DateTime(2024, 8, 17, 12, 34, 56, DateTimeKind.Local)));
			_validator = new ProductCategoryValidator();
		}
	}
}