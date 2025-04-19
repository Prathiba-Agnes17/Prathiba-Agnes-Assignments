using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FinanceManagementSystem.Entities
{
    public class User
    {
        // Private variables
        private int userId;
        private string username;
        private string password;
        private string email;

        // Public properties
        public int UserId
        {
            get { return userId; }
            set { userId = value; }
        }

        public string Username
        {
            get { return username; }
            set { username = value; }
        }

        public string Password
        {
            get { return password; }
            set { password = value; }
        }

        public string Email
        {
            get { return email; }
            set { email = value; }
        }

        // Default constructor
        public User() { }

        // Parameterized constructor
        public User(int userId, string username, string password, string email)
        {
            this.userId = userId;
            this.username = username;
            this.password = password;
            this.email = email;
        }
    }
}
    

