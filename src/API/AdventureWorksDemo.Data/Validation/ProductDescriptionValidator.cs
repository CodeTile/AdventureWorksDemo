
using AdventureWorksDemo.Data.Entities;

using FluentValidation;

namespace AdventureWorksDemo.Data.Validation
{
	public class ProductDescriptionValidator : AbstractValidator<ProductDescription>
	{
		public ProductDescriptionValidator()
		{
			RuleFor(m => m.Description).Length(3, 400);
		}
	}
}