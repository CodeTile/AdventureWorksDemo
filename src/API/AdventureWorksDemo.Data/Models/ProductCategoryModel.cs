#nullable disable

namespace AdventureWorksDemo.Data.Models;

/// <summary>
/// High-level product categorization.
/// </summary>
public partial class ProductCategoryModel
{
	/// <summary>
	/// Date and time the record was last updated.
	/// </summary>
	public DateTime ModifiedDate { get; set; }

	/// <summary>
	/// Category description.
	/// </summary>
	public string Name { get; set; }

	/// <summary>
	/// Product category identification number of immediate ancestor category. Foreign key to ProductCategory.ProductCategoryID.
	/// </summary>
	public int? ParentProductCategoryId { get; set; }

	/// <summary>
	/// Primary key for ProductCategory records.
	/// </summary>
	public int ProductCategoryId { get; set; }

	/// <summary>
	/// ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.
	/// </summary>
	public Guid Rowguid { get; set; }

	public virtual bool Equals(ProductCategoryModel obj)
	{
		return Name.Equals(obj.Name)
			   && ParentProductCategoryId.Equals(obj.ParentProductCategoryId);
	}
}