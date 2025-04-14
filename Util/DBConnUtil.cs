using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;


namespace TechShop.Util
{
    public static class DBConnUtil
    {
        public static SqlConnection GetConnection(string connString)
        {
            SqlConnection conn = new SqlConnection(connString);
            conn.Open();
            return conn;
        }
    }
}
