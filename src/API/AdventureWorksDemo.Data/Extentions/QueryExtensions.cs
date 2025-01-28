using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using AdventureWorksDemo.Data.Paging;

using static Azure.Core.HttpHeader;

namespace AdventureWorksDemo.Data.QueryExtentions
{
	public static class QueryExtensions
	{
		public static IQueryable<T> ApplyQuery<T>(this IQueryable<T> query, PageingFilter? filter) where T : class
		{
			if (filter == null)
				return query;
			if (query == null || !query.Any())
				return default!;

			filter.VerifyValues();

			return query.ApplySlice(filter);
		}

		public static IQueryable<T> ApplySlice<T>(this IQueryable<T> query, PageingFilter? filter) where T : class
		{
			if (filter == null)
				return query;
			if (query == null || !query.Any())
				return default!;
			return ApplySlice<T>(query, filter.Skip, filter.PageSize);
		}

		internal static IQueryable<T> ApplySlice<T>(this IQueryable<T> query, int skip, int pageSize) where T : class
		{
			if (query == null || !query.Any())
				return default!;
			if (skip < 0 || pageSize < 0)
				return query;

			// //
			return query
					.Skip(skip)
					.Take(pageSize);
		}
	}
}