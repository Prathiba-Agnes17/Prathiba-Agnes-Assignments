using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ticket_Booking_System.Util
{
    public static class DBConnUtil
    {
        public static SqlConnection GetConnection(string propertyName)
        {
            string connString = DBPropertyUtil.GetConnectionString(propertyName);
            SqlConnection conn = new SqlConnection(connString);
            conn.Open();
            return conn;
        }

    }
}
