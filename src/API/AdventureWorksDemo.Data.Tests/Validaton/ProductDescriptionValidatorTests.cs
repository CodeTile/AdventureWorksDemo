using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Validation;

using AdventureWorksDemo.Common.Tests.Extensions;
using FluentValidation.TestHelper;
using Microsoft.Extensions.Time.Testing;

namespace AdventureWorksDemo.Data.Tests.Validaton
{
	[TestClass]
	public class ProductDescriptionValidatorTests
	{
		private readonly ProductDescriptionValidator _validator = new();
		private FakeTimeProvider _fakeTimeProvider = new();
		private ProductDescription _productDescription = new();

		[DataRow("")]
		[DataRow("{{PadRight:X:1}}")]
		[DataRow("{{PadRight:X:2}}")]
		[DataRow("{{PadRight:X:401}}")]
		[DataRow("{{PadRight:X:402}}")]
		[TestMethod]
		public void DescriptionOutSideBounds(string value)
		{
			// arrange
			_productDescription.Description = value.InterpretValue();
			// act
			var result = _validator.TestValidate(_productDescription);
			//assert
			result.ShouldHaveValidationErrorFor(m => m.Description);
		}

		[DataRow("{{PadRight:X:200}}")]
		[DataRow("{{PadRight:X:3}}")]
		[DataRow("{{PadRight:X:4}}")]
		[DataRow("{{PadRight:X:400}}")]
		[DataRow("{{PadRight:X:51}}")]
		[TestMethod]
		public void DescriptionWithinBounds(string value)
		{
			// arrange
			_productDescription.Description = value.InterpretValue();
			// act
			var result = _validator.TestValidate(_productDescription);
			//assert
			result.ShouldNotHaveValidationErrorFor(m => m.Description);
		}

		[TestInitialize]
		public void TestInitialize()
		{
			_fakeTimeProvider = new();
			_fakeTimeProvider.SetUtcNow(new DateTimeOffset(new DateTime(2024, 8, 17, 12, 34, 56, DateTimeKind.Local)));
			_productDescription = new ProductDescription()
			{
				Description = "12345",
				ModifiedDate = _fakeTimeProvider.GetUtcNow().UtcDateTime,
				ProductDescriptionId = 234,
				Rowguid = 1.ToGuid(),
			};
		}
	}
}