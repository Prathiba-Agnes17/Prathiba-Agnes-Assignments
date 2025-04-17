using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;


namespace InsuranceManagement.util
{
    public class DBConnUtil
    {
        public static SqlConnection GetConnection(string filePath)
        {
            try
            {
                string connectionString = DBPropertyUtil.GetConnectionString(filePath);
                SqlConnection conn = new SqlConnection(connectionString);
                return conn;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error getting connection: " + ex.Message);
                return null;
            }
        }

    }
}
