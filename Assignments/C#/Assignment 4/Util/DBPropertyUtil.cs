using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;


namespace CourierManagementSystem.Util
{
    public class DBPropertyUtil
    {
        public static string GetConnectionString(string propFile)
        {
            try
            {
                // Reads connection string from App.config by name
                string connStr = ConfigurationManager.ConnectionStrings[propFile]?.ConnectionString;
                return connStr;
            }
            catch (System.Exception ex)
            {
                Console.WriteLine("Error reading connection string: " + ex.Message);
                return null;
            }
        }
    }
}
