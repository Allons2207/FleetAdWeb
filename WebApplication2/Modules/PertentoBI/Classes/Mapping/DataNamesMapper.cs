using PertentoBI.Classes.Mapping.Attributes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace PertentoBI.Classes.Mapping
{
    public class DataNamesMapper<TEntity> where TEntity : class, new()
    {

  

        public TEntity Map(DataRow row)
        {
            TEntity entity = new TEntity();
            return Map(row, entity);
        }

        public TEntity Map(object entityMappedFrom)
        {
            TEntity entity = new TEntity();
            return Map(entity, entityMappedFrom);
        }

        public TEntity Map(DataRow row, TEntity entity)
        {
            var columnNames = row.Table.Columns.Cast<DataColumn>().Select((x) => x.ColumnName).ToList();
            var properties = (typeof(TEntity)).GetProperties().Where((x) => x.GetCustomAttributes(typeof(DataNamesAttribute), true).Any()).ToList();

            foreach (PropertyInfo prop in properties)
            {
                PropertyMapHelper.Map(typeof(TEntity), row, prop, entity);
            }

            return entity;
        }
        public TEntity Map(TEntity entity, object entityMappedFrom)
        {
            try
            {

                //Dim columnNames = row.Table.Columns.Cast(Of DataColumn)().[Select](Function(x) x.ColumnName).ToList()
                var properties = (typeof(TEntity)).GetProperties().Where((x) => x.GetCustomAttributes(typeof(DataNamesAttribute), true).Any()).ToList();

                foreach (PropertyInfo prop in properties)
                {
                    PropertyMapHelper.Map(typeof(TEntity), (PropertyInfo)entityMappedFrom, prop, entity);
                }


            }
            catch (Exception ex)
            {
         
            }

            return entity;

        }

        public IEnumerable<TEntity> Map(DataTable table)
        {
            List<TEntity> entities = new List<TEntity>();
            var columnNames = table.Columns.Cast<DataColumn>().Select((x) => x.ColumnName).ToList();
            var properties = (typeof(TEntity)).GetProperties().Where((x) => x.GetCustomAttributes(typeof(DataNamesAttribute), true).Any()).ToList();

            foreach (DataRow row in table.Rows)
            {
                TEntity entity = new TEntity();

                foreach (PropertyInfo prop in properties)
                {
                    PropertyMapHelper.Map(typeof(TEntity), row, prop, entity);
                }

                entities.Add(entity);
            }

            return entities;
        }

        public IEnumerable<TEntity> Map(List<object> objList)
        {
            List<TEntity> entities = new List<TEntity>();

            var properties = (typeof(TEntity)).GetProperties().Where((x) => x.GetCustomAttributes(typeof(DataNamesAttribute), true).Any()).ToList();

            foreach (object obj in objList)
            {
                TEntity entity = new TEntity();

                foreach (PropertyInfo prop in properties)
                {
                    //      PropertyMapHelper.Map(typeof(TEntity), prop, obj, entity);
                }

                entities.Add(entity);
            }

            return entities;
        }
    }
}
