using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Intrinsics.X86;
using System.Text;
using System.Threading.Tasks;
using AdventureWorksDemo.Data.Models;
using AdventureWorksDemo.Data.Paging;
using AdventureWorksDemo.Data.Services;

namespace AdventureWorksDemo.Data.Tests.reqnroll.Helpers
{
    internal static partial class Helper
    {
        internal static class Types
        {
            internal static IList? CreateListByTypeName(string typeName)
            {
                return CreateListOfType(GetTypeByName(typeName));
            }

            internal static IList? CreateListOfType(Type myType)
            {
                Type genericListType = typeof(List<>).MakeGenericType(myType);
                return (IList)Activator.CreateInstance(genericListType);
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

                    case "pageingfilter":
                        return typeof(PageingFilter);

                    case "addressservice":
                        return typeof(AddressService);

                    case "productcategoryservice":
                        return typeof(ProductCategoryService);

                    case "addressmodel":
                        return typeof(AddressModel);

                    case "productcategorymodel":
                        return typeof(ProductCategoryModel);

                    default:
                        throw new NotImplementedException($"Type [{typeName}] is not implemented!");
                }
            }
        }
    }
}