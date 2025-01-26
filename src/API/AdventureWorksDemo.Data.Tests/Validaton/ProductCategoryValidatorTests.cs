using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Validation;

using AdventureWorksDemo.Common.Tests.Extensions;
using Microsoft.Extensions.Time.Testing;
using FluentValidation.TestHelper;

namespace AdventureWorksDemo.Data.Tests.Validaton
{
	[TestClass]
	public class ProductCategoryValidatorTests
	{
		private readonly ProductCategoryValidator _validator = new();
		private FakeTimeProvider _fakeTimeProvider = new();
		private ProductCategory _model = new();

		[DataRow("")]
		[DataRow("{{PadRight:X:1}}")]
		[DataRow("{{PadRight:X:2}}")]
		[DataRow("{{PadRight:X:51}}")]
		[DataRow("{{PadRight:X:93742}}")]
		[TestMethod]
		public void NameOutSideBounds(string value)
		{
			// arrange
			_model.Name = value.InterpretValue();
			// act
			var result = _validator.TestValidate(_model);
			//assert
			result.ShouldHaveValidationErrorFor(m => m.Name);
		}

		[DataRow("{{PadRight:X:10}}")]
		[DataRow("{{PadRight:X:3}}")]
		[DataRow("{{PadRight:X:4}}")]
		[DataRow("{{PadRight:X:40}}")]
		[DataRow("{{PadRight:X:50}}")]
		[TestMethod]
		public void NameWithinBounds(string value)
		{
			// arrange
			_model.Name = value.InterpretValue();
			// act
			var result = _validator.TestValidate(_model);
			//assert
			result.ShouldNotHaveValidationErrorFor(m => m.Name);
		}

		[TestInitialize]
		public void TestInitialize()
		{
			_fakeTimeProvider = new();
			_fakeTimeProvider.SetUtcNow(new DateTimeOffset(new DateTime(2024, 8, 17, 12, 34, 56, DateTimeKind.Local)));
			_model = new ProductCategory()
			{
				Name = "12345",
				ModifiedDate = _fakeTimeProvider.GetUtcNow().UtcDateTime,
				ProductCategoryId = 234,
				Rowguid = 1.ToGuid(),
			};
		}
	}
}