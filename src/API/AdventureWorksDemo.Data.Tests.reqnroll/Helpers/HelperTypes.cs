using System.Collections;
using System.Text;

using AdventureWorksDemo.Data.Models;
using AdventureWorksDemo.Data.Paging;
using AdventureWorksDemo.Data.Services;
using AdventureWorksDemo.Data.Tests.reqnroll.Extensions;

namespace AdventureWorksDemo.Data.Tests.reqnroll.Helpers
{
    internal static partial class Helper
    {
        internal static class Types
        {
            #region CreateInstance

            internal static object? CreateInstance(string fullName)
            {
                return CreateInstance(GetTypeByName(fullName));
            }

            internal static object? CreateInstance(string entityName, params object[] args)
            {
                return CreateInstance(GetTypeByName(entityName), args);
            }

            internal static object? CreateInstance(Type t, params object[] methodParameters)
            {
                return Activator.CreateInstance(t, methodParameters);
            }

            internal static object? CreateInstance(Type t)
            {
                if (t.IsInterface)
                    return CreateInstance(t.FullName
                                                .Replace(".Models.I", ".Models.")
                                                .Replace(".Helpers.I", ".Helpers."));
                return Activator.CreateInstance(t);
            }

            #endregion CreateInstance

            internal static IList? CreateListByTypeName(string typeName)
            {
                return CreateListOfType(GetTypeByName(typeName));
            }

            internal static IList? CreateListOfType(Type myType)
            {
                Type genericListType = typeof(List<>).MakeGenericType(myType);
                return (IList?)Activator.CreateInstance(genericListType);
            }

            internal static Type GetTypeByName(string typeName)
            {
                if (typeName.Contains("System.Collections.Generic.IEnumerable<"))
                {
                    var subObject = typeName.Replace("System.Collections.Generic.IEnumerable<", "");
                    subObject = subObject.Substring(0, subObject.LastIndexOf('>'));
                    return CreateListByTypeName(subObject).GetType();
                }

                switch (typeName.ToLower())
                {
                    case "system.string":
                    case "string":
                        return typeof(System.String);

                    case "int":
                    case "int32":
                    case "system.int32":
                        return typeof(System.Int32);

                    case "bool":
                    case "boolean":
                        return typeof(System.Boolean);

                    case "system.datetime":
                    case "datetime":
                        return typeof(System.DateTime);

                    case "adventureworksdemo.data.paging.pagingfilter":
                    case "pageingfilter":
                        return typeof(PageingFilter);

                    case "addressservice":
                        return typeof(AddressService);

                    case "productcategoryservice":
                        return typeof(ProductCategoryService);

                    case "addressmodel":
                        return typeof(AddressModel);

                    case "adventureworksdemo.data.models.productcategorymodel":
                    case "productcategorymodel":
                        return typeof(ProductCategoryModel);

                    default:
                        throw new NotImplementedException($"Type [{typeName.ToLower()}] is not implemented!");
                }
            }

            #region Populate From Table or Row

            internal static IList PopulateListFromTable(string typeName, DataTable table, string? excludeFieldNames = null)
            {
                return PopulateListFromTable(GetTypeByName(typeName), table, excludeFieldNames);
            }

            internal static IList PopulateListFromTable(Type t, DataTable table, string? excludeFieldNames = null)
            {
                var retval = CreateListOfType(t);
                foreach (var row in table.Rows)
                {
                    retval.Add(PopulateModelFromRow(t, row, excludeFieldNames));
                }

                return retval;
            }

            internal static dynamic PopulateModelFromRow(string entityName, DataTableRow row, string? excludeFieldNames = null)
            {
                return PopulateModelFromRow(CreateInstance(entityName), row, excludeFieldNames);
            }

            internal static dynamic PopulateModelFromRow(Type t, DataTableRow row, string? excludeFieldNames = null)
            {
                return PopulateModelFromRow(CreateInstance(t), row, excludeFieldNames);
            }

            internal static dynamic PopulateModelFromRow(dynamic entity, DataTableRow row, string? excludeFieldNames = null)
            {
                Type type = entity.GetType();
                if (type.Name.Equals("string", StringComparison.OrdinalIgnoreCase))
                {
                    throw new ArgumentException($"{nameof(entity)} must be a model, it cannot be a string.");
                }

                // If a property needs instanciating then instanciate it.
                foreach (var pi in type.GetProperties()
                            .Where(w => w.PropertyType.FullName != null && (w.PropertyType.FullName.Contains("AdventureWorksDemo.")
                                                                            && !w.PropertyType.FullName.Contains("ICollection")
                                                                            && !w.PropertyType.FullName.Contains("IEnumerable"))
                            ).ToList())
                {
                    var subEntity = CreateInstance(pi.PropertyType);
                    pi.SetValue(entity, subEntity, null);
                }
                var exclusionFields = excludeFieldNames?.Split(',');
                foreach (var fieldname in row.Keys)
                {
                    var cellValue = row[fieldname].Trim();
                    if (string.IsNullOrEmpty(cellValue) ||
                        (!string.IsNullOrEmpty(excludeFieldNames) && exclusionFields!.Contains(fieldname))
                       )
                    {
                        continue;
                    }

                    var pi = type.GetProperty(fieldname) ?? throw new ArgumentOutOfRangeException($"Field {fieldname} not found in the model.");
                    if (!pi.CanWrite)
                    {
                        continue;
                    }
                    if (pi.PropertyType == typeof(TimeSpan)
                        || pi.PropertyType == typeof(TimeSpan?))
                    {
                        var ts = TimeSpan.Parse(cellValue);
                        pi.SetValue(entity, ts, null);
                        continue;
                    }
                    if (pi.PropertyType == typeof(byte[]))
                    {
                        if (!string.IsNullOrEmpty(cellValue))
                        {
                            byte[] convertedToBytes;
                            try
                            {
                                convertedToBytes = Convert.FromBase64String(cellValue);
                            }
                            catch (FormatException)
                            {
                                convertedToBytes = Encoding.ASCII.GetBytes(cellValue);
                            }
                            catch (Exception)
                            {
                                throw;
                            }

                            pi.SetValue(entity, convertedToBytes, null);
                        }
                        continue;
                    }

                    if (pi.PropertyType == typeof(Guid))
                    {
                        if (!string.IsNullOrEmpty(cellValue))
                        {
                            pi.SetValue(entity, new Guid(cellValue), null);
                        }
                        continue;
                    }

                    if (pi.PropertyType == typeof(List<string>))
                    {
                        var ls = row[fieldname].Split(',').Select(item => item.InterpretValue().Trim()).ToList();
                        pi.SetValue(entity, ls, null);
                        continue;
                    }
                    var t = Nullable.GetUnderlyingType(pi.PropertyType) ?? pi.PropertyType;
                    var safeValue = (row[fieldname] == null) ? null : Convert.ChangeType(row[fieldname].InterpretValue(), t);
                    pi.SetValue(entity, safeValue, null);
                }
                return entity;
            }

            #endregion Populate From Table or Row
        }
    }
}