﻿using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.Extensions.Logging;
using System.ComponentModel;
using System.Data;
using System.Data.Common;
using System.Reflection;
using ModernWMS.Core;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory.Database;
using Microsoft.Data.SqlClient;
using Mapster;
using Microsoft.AspNetCore.JsonPatch.Internal;
using ModernWMS.Core.Models;

namespace ModernWMS.Core.DBContext
{
    /// <summary>
    /// SqlDBContext
    /// </summary>
    public class SqlDBContext : DbContext
    {
        /// <summary>
        ///  current user's tenant_id
        /// </summary>
        public byte tenant_id { get; set; } = 1;

        /// <summary>
        /// Database
        /// </summary>
        /// <returns></returns>
        public DatabaseFacade GetDatabase() => Database;

        /// <summary>
        /// dbcontext
        /// </summary>
        /// <param name="options">options</param>
        public SqlDBContext(DbContextOptions options) : base(options)
        {
        }

        #region overwrite

        /// <summary>
        /// Auto Mapping Entity
        /// </summary>
        /// <param name="modelBuilder">ModelBuilder</param>
        private void MappingEntityTypes(ModelBuilder modelBuilder)
        {
            var baseType = typeof(Models.BaseModel);
            var path = AppDomain.CurrentDomain.RelativeSearchPath ?? AppDomain.CurrentDomain.BaseDirectory;
            var referencedAssemblies = System.IO.Directory.GetFiles(path, $"ModernWMS*.dll").Select(Assembly.LoadFrom).ToArray();
            var list = referencedAssemblies
                .SelectMany(a => a.DefinedTypes)
                .Select(type => type.AsType())
                .Where(x => x != baseType && baseType.IsAssignableFrom(x)).ToList();
            if (list != null && list.Any())
            {
                list.ForEach(t =>
                {
                    var entityType = modelBuilder.Model.FindEntityType(t);
                    if (entityType == null)
                    {
                        modelBuilder.Model.AddEntityType(t);
                    }
                });
            }
        }

        /// <summary>
        /// overwrite OnModelCreating
        /// </summary>
        /// <param name="modelBuilder"></param>
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<GlobalUniqueSerialEntity>();
            MappingEntityTypes(modelBuilder);
            /*foreach (var entityType in modelBuilder.Model.GetEntityTypes())
               {
                   if (typeof(Models.IHasTenant).IsAssignableFrom(entityType.ClrType))
                   {
                       ConfigureGlobalFiltersMethodInfo
                          .MakeGenericMethod(entityType.ClrType)
                          .Invoke(this, new object[] { modelBuilder });
                   }
               }*/
            base.OnModelCreating(modelBuilder);
        }

        /// <summary>
        /// create DbSet
        /// </summary>
        /// <typeparam name="T">Entity</typeparam>
        /// <returns></returns>
        public virtual DbSet<T> GetDbSet<T>() where T : class
        {
            if (Model.FindEntityType(typeof(T)) != null)
            {
                return Set<T>();
            }
            else
            {
                throw new Exception($"type {typeof(T).Name} is not add into DbContext ");
            }
        }

        /// <summary>
        /// over write  EnsureCreated
        /// </summary>
        /// <returns></returns>
        public virtual bool EnsureCreated()
        {
            return Database.EnsureCreated();
        }

        /// <summary>
        /// over write OnConfiguring
        /// </summary>
        /// <param name="optionsBuilder"></param>
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            base.OnConfiguring(optionsBuilder);
        }

        /// <summary>
        /// exec sql and get the first list
        /// </summary>
        /// <param name="sql">sql</param>
        /// <param name="parameters">parameters</param>
        /// <returns></returns>
        public virtual List<T> SqlQueryDynamic<T>(string sql, Dictionary<string, object> parameters) where T : new()
        {
            DbProviderFactory dbProvider = DbProviderFactories.GetFactory(GetDatabase().GetDbConnection());
            using (DbConnection connection = dbProvider.CreateConnection())
            using (DbDataAdapter adapter = dbProvider.CreateDataAdapter())
            using (DbCommand cmd = dbProvider.CreateCommand())
            {
                connection.ConnectionString = this.Database.GetConnectionString();
                if (connection.State != ConnectionState.Open)
                {
                    connection.Open();
                }
                cmd.CommandTimeout = 600;
                cmd.Connection = connection;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = sql;
                adapter.SelectCommand = cmd;

                if (parameters != null)
                {
                    foreach (var item in parameters)
                    {
                        DbParameter dbParameter = cmd.CreateParameter();
                        dbParameter.ParameterName = item.Key;
                        dbParameter.Value = item.Value;
                        dbParameter.Direction = ParameterDirection.Input;
                        cmd.Parameters.Add(dbParameter);
                    }
                }

                DataTable dataTable = new DataTable("Table");
                adapter.Fill(dataTable);
                if (dataTable.Rows.Count > 0)
                {
                    return DataTableToIList<T>(dataTable);
                }
                else
                {
                    return default(List<T>);
                }
            }
        }

        /// <summary>
        /// convert DataTable type data to List type data
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static List<T> DataTableToIList<T>(DataTable dt)
        {
            if (dt == null)
                return null;

            DataTable property_data = dt;
            List<T> result = new List<T>();
            for (int j = 0; j < property_data.Rows.Count; j++)
            {
                T new_data = (T)Activator.CreateInstance(typeof(T));
                PropertyInfo[] propertys = new_data.GetType().GetProperties();
                foreach (PropertyInfo pi in propertys)
                {
                    for (int i = 0; i < property_data.Columns.Count; i++)
                    {
                        if (pi.Name.Equals(property_data.Columns[i].ColumnName))
                        {
                            if (property_data.Rows[j][i] != DBNull.Value)
                            {
                                //special handling
                                if (pi.PropertyType.FullName == "System.Boolean")
                                {
                                    var val = property_data.Rows[j][i].ToString() == "1" ? true : false;
                                    pi.SetValue(new_data, val, null);
                                }
                                else
                                {
                                    pi.SetValue(new_data, property_data.Rows[j][i], null);
                                }
                            }
                            else
                            {
                                pi.SetValue(new_data, null, null);
                            }

                            break;
                        }
                    }
                }
                result.Add(new_data);
            }
            return result;
        }

        #endregion overwrite

        /// <summary>
        /// 序号表获取单据编号
        /// </summary>
        /// <param name="table_name">表名</param>
        /// <param name="tenant_id">租户id</param>
        /// <param name="prefix_char">前缀</param>
        /// <param name="reset_rule">重置规则</param>
        /// <returns></returns>
        public async Task<string> GetFormNoAsync(string table_name, byte tenant_id = 1, string prefix_char = "", ResetRule reset_rule = ResetRule.Day)
        {
            var nums = await GetFormNoListAsync(table_name, 1, tenant_id, prefix_char,  reset_rule);
            if (nums == null)
            {
                return "";
            }
            else
            {
                return nums[0];
            }
        }

        /// <summary>
        /// 序号表获取单据编号
        /// </summary>
        /// <param name="table_name">表名</param>
        /// <param name="tenant_id">租户id</param>
        /// <param name="prefix_char">前缀</param>
        /// <param name="Qty">编号数量</param>
        /// <param name="reset_rule">重置规则</param>
        /// <returns></returns>
        public async Task<List<string>> GetFormNoListAsync(string table_name, int Qty = 1, byte tenant_id = 1, string prefix_char = "",  ResetRule reset_rule = ResetRule.Day)
        {
            List<string> nums = new List<string>();
            string _reset_rule = "yyyyMMdd";
            if (reset_rule == ResetRule.Year) _reset_rule = "yyyy";
            else if (reset_rule == ResetRule.Month) _reset_rule = "yyyyMM";

            var dbSet = Set<GlobalUniqueSerialEntity>();
            var entity = await dbSet.FirstOrDefaultAsync(t => t.table_name == table_name && t.prefix_char == prefix_char && t.reset_rule == _reset_rule);
            if (entity == null)
            {
                for (int index = 1; index <= Qty; index++)
                {
                    nums.Add($"{prefix_char}{DateTime.Now.ToString(_reset_rule)}-{index.ToString().PadLeft(4, '0')}");
                }
                entity = new GlobalUniqueSerialEntity
                {
                    table_name = table_name,
                    prefix_char = prefix_char,
                    reset_rule = _reset_rule,
                    current_no = Qty + 1,
                    last_update_time = DateTime.Now,
                    tenant_id = tenant_id
                };
                dbSet.Add(entity);
                await SaveChangesAsync();

            }
            else
            {

                int current_no = entity.current_no;
                if (!DateTime.Now.ToString(_reset_rule).Equals(entity.last_update_time.ToString(_reset_rule)))
                {
                    current_no = 1;
                }
                for (int index = 1; index <= Qty; index++)
                {
                    nums.Add($"{prefix_char}{DateTime.Now.ToString(_reset_rule)}-{current_no.ToString().PadLeft(4, '0')}");
                    current_no++;
                }
                entity.current_no = current_no;
                entity.last_update_time = DateTime.Now;
                await SaveChangesAsync();

            }
            return nums;
        }

    }
    /// <summary>
    /// 重置规则
    /// </summary>
    public enum ResetRule
    {
        /// <summary>
        /// 年
        /// </summary>
        Year,
        /// <summary>
        /// 月
        /// </summary>
        Month,
        /// <summary>
        /// 日
        /// </summary>
        Day
    }
}