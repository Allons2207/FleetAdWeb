using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace PertentoBI.Classes.Mapping
{
    internal static class PropertyMapHelper
    {
        public static void Map(Type type, DataRow row, PropertyInfo prop, object entity)
        {
            List<string> columnNames = AttributeHelper.GetDataNames(type, prop.Name);

            foreach (string columnName in columnNames)
            {

                if (!string.IsNullOrWhiteSpace(columnName) && row.Table.Columns.Contains(columnName))
                {
                    var propertyValue = row[columnName];

                    if (!Convert.IsDBNull(propertyValue))
                    {
                        ParsePrimitive(prop, entity, row[columnName]);
                        break;
                    }
                }
            }
        }

        public static void Map(Type type, PropertyInfo prop, PropertyInfo entityToMapfrom, object entityToMapto)
        {

            //List<string> columnNames = AttributeHelper.GetDataNames(type, prop.Name);
            
            //List<PropertyInfo> propertiesFrom = entityToMapfrom.GetProperties().Select((x) => x.Name).ToList();

            //foreach (string columnName in columnNames)
            //{
            //    if (!string.IsNullOrWhiteSpace(columnName))
            //    {

            //        foreach (PropertyInfo propInfo in propertiesFrom)
            //        {
            //            if (propInfo.Name == columnName)
            //            {
            //                var propertyValue = propInfo.GetValue(entityToMapfrom);
            //                if (!Convert.IsDBNull(propertyValue))
            //                {
            //                    ParsePrimitive(prop, entityToMapto, propertyValue);
            //                    break;
            //                }
            //            }
            //        }

            //    }

            //}
        }

        private static void ParsePrimitive(PropertyInfo prop, object entity, object value)
        {
            if (prop.PropertyType == typeof(string))
            {
                prop.SetValue(entity, value.ToString().Trim(), null);
            }
            else if (prop.PropertyType == typeof(bool) || prop.PropertyType == typeof(bool?))
            {

                if (value == null)
                {
                    prop.SetValue(entity, null, null);
                }
                else
                {
                    prop.SetValue(entity, ParseBoolean(value.ToString()), null);
                }
            }
            else if (prop.PropertyType == typeof(long))
            {
                prop.SetValue(entity, long.Parse(value.ToString()), null);
            }
            else if (prop.PropertyType == typeof(int) || prop.PropertyType == typeof(int?))
            {

                if (value == null)
                {
                    prop.SetValue(entity, null, null);
                }
                else
                {
                    prop.SetValue(entity, int.Parse(value.ToString()), null);
                }
            }
            else if (prop.PropertyType == typeof(decimal))
            {
                prop.SetValue(entity, decimal.Parse(value.ToString()), null);
            }
            else if (prop.PropertyType == typeof(double) || prop.PropertyType == typeof(double?))
            {
                double number = 0;
                bool isValid = double.TryParse(value.ToString(), out number);

                if (isValid)
                {
                    prop.SetValue(entity, double.Parse(value.ToString()), null);
                }
            }
            else if (prop.PropertyType == typeof(DateTime) || prop.PropertyType == typeof(DateTime?))
            {
                DateTime fdate = default(DateTime);
                bool isValid = DateTime.TryParse(value.ToString(), out fdate);

                if (isValid)
                {
                    prop.SetValue(entity, fdate, null);
                }
                else
                {
                    isValid = DateTime.TryParseExact(value.ToString(), "MMddyyyy", new CultureInfo("en-US"), DateTimeStyles.AssumeLocal,out fdate);

                    if (isValid)
                    {
                        prop.SetValue(entity, fdate, null);
                    }
                }
            }
            else if (prop.PropertyType == typeof(Guid))
            {
                Guid guid = new Guid();
                bool isValid = Guid.TryParse(value.ToString(), out guid);

                if (isValid)
                {
                    prop.SetValue(entity, guid, null);
                }
                else
                {
                    isValid = Guid.TryParseExact(value.ToString(), "B", out guid);

                    if (isValid)
                    {
                        prop.SetValue(entity, guid, null);
                    }
                }

            }
            else if (prop.PropertyType == typeof(byte[]))
            {

                byte[] fbyte = System.Text.Encoding.ASCII.GetBytes(value.ToString());

                prop.SetValue(entity, fbyte, null);

            }
        }

        public static bool ParseBoolean(object value)
        {
            if (value == null || Convert.IsDBNull(value))
            {
                return false;
            }

            switch (value.ToString().ToLowerInvariant())
            {
                case "1":
                case "y":
                case "yes":
                case "true":
                    return true;
                default:
                    return false;
            }
        }
    }
}
