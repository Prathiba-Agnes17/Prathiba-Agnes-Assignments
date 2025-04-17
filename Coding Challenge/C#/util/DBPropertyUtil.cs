using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InsuranceManagement.util
{
    public class DBPropertyUtil
    {
        public static string GetConnectionString(string filePath)
        {
            if (!File.Exists(filePath))
            {
                throw new FileNotFoundException("Connection string file not found.");
            }

            return File.ReadAllText(filePath).Trim();
        }
    }

}
