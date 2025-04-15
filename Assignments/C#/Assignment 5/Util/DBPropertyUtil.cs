using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ticket_Booking_System.Util
{
    public static class DBPropertyUtil
    {
        public static string GetConnectionString(string propertyName)
        {
            return ConfigurationManager.ConnectionStrings[propertyName].ConnectionString;
        }
    }
}
