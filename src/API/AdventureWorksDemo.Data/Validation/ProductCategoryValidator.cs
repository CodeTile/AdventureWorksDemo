using AdventureWorksDemo.Data.Entities;

using FluentValidation;

namespace AdventureWorksDemo.Data.Validation
{
	public class ProductCategoryValidator : AbstractValidator<ProductCategory>
	{
		public ProductCategoryValidator()
		{
			RuleFor(m => m.Name).Length(3, 50);
		}
	}
}