using System.Linq.Expressions;
using System.Reflection;

using AdventureWorksDemo.Data.Paging;

namespace AdventureWorksDemo.Data.Extentions
{
	public static class IQueryableExtensionsPaging
	{
		public static IQueryable<T>? ApplyPageing<T>(this IQueryable<T>? query, PageingFilter? filter) //where T : class
		{
			if (filter == null || !query.Any())
				return query;
			if (query == null || !query.Any())
				return default!;

			filter.Sanitise();

			// //
			return query
					.Skip(filter.Skip)
					.Take(filter.PageSize);
		}

		public static IQueryable<T>? ApplySorting<T>(this IQueryable<T>? query, PageingFilter filter)
		{
			if (filter?.Sorting == null || filter.Sorting.Length == 0)
				return query; // No sorting applied if Sorting is null or empty

			IOrderedQueryable<T>? orderedQuery = null;

			foreach (var sortExpression in filter.Sorting)
			{
				var parts = sortExpression.Trim().Split(' '); // e.g., "Description" or "ModifiedDate DESC"
				string propertyName = parts[0];
				bool descending = parts.Length > 1 && parts[1].Equals("DESC", StringComparison.OrdinalIgnoreCase);

				// Get the property info
				var property = typeof(T).GetProperty(propertyName, BindingFlags.Public | BindingFlags.Instance | BindingFlags.IgnoreCase);
				if (property == null)
					throw new ArgumentException($"Property '{propertyName}' not found on type '{typeof(T).Name}'.");

				// Build the sorting expression dynamically
				var parameter = Expression.Parameter(typeof(T), "x");
				var propertyAccess = Expression.Property(parameter, property);
				var lambda = Expression.Lambda(propertyAccess, parameter);

				var methodName = orderedQuery == null
					? (descending ? "OrderByDescending" : "OrderBy")
					: (descending ? "ThenByDescending" : "ThenBy");

				var method = typeof(Queryable).GetMethods()
					.First(m => m.Name == methodName &&
								m.GetParameters().Length == 2)
					.MakeGenericMethod(typeof(T), property.PropertyType);

				orderedQuery = method.Invoke(null, [orderedQuery ?? query, lambda]) as IOrderedQueryable<T>;
			}

			return orderedQuery ?? query;
		}
	}
}