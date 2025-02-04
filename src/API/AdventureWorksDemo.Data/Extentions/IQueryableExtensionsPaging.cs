using System.Linq.Expressions;
using System.Reflection;

using AdventureWorksDemo.Data.Paging;

namespace AdventureWorksDemo.Data.Extentions
{
	public static class IQueryableExtensions
	{
		#region ApplyFilters
		public static IQueryable<T>? ApplyFilters<T>(this IQueryable<T> query, PageingFilter? pagingfilter)
		{
			if (pagingfilter == null || query == null || !query!.Any()
					|| pagingfilter.Filter==null)
				return query;

			pagingfilter.Sanitise();


			foreach (var filter in pagingfilter.Filter!)
			{
				var parts = filter.Split('|');
				if (parts.Length != 3)
					throw new ArgumentException("Invalid filter format. Expected format: 'PropertyName | Expression | Value'");

				string propertyName = parts[0].Trim();
				string expression = parts[1].Trim();
				string value = parts[2].Trim();

				query = ApplyFilter(query, propertyName, expression, value);
			}
			return query;
		}
		private static IQueryable<T> ApplyFilter<T>(IQueryable<T> query, string propertyName, string expression, string value)
		{
			var parameter = Expression.Parameter(typeof(T), "x");
			var property = Expression.Property(parameter, propertyName);
			var propertyType = property.Type;

			object convertedValue = Convert.ChangeType(value, propertyType);
			var constant = Expression.Constant(convertedValue);

			Expression comparison = expression.ToLower() switch
			{
				"equals" => Expression.Equal(property, constant),
				"notequals" => Expression.NotEqual(property, constant),
				"greaterthan" => Expression.GreaterThan(property, constant),
				"lessthan" => Expression.LessThan(property, constant),
				"greaterthanorequal" => Expression.GreaterThanOrEqual(property, constant),
				"lessthanorequal" => Expression.LessThanOrEqual(property, constant),
				"contains" => Expression.Call(property, typeof(string).GetMethod("Contains", [typeof(string)]), constant),
				_ => throw new ArgumentException($"Invalid expression: {expression}")
			};

			var lambda = Expression.Lambda<Func<T, bool>>(comparison, parameter);
			return query.Where(lambda);
		}
		#endregion

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