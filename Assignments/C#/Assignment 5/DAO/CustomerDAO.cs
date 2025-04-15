using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Ticket_Booking_System.Entities;
using Ticket_Booking_System.Util;
using Microsoft.Data.SqlClient;
namespace Ticket_Booking_System.DAO
{
    public class CustomerDAO : ICustomerDAO
    {
        public List<Customer> GetAllCustomers()
        {
            List<Customer> customers = new List<Customer>();
            using (SqlConnection conn = DBConnUtil.GetConnection("DbConnection"))
            {
                string query = "SELECT * FROM Customer";
                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    customers.Add(new Customer
                    {
                        CustomerId = Convert.ToInt32(reader["customer_id"]),
                        CustomerName = reader["customer_name"].ToString(),
                        Email = reader["email"].ToString(),
                        PhoneNumber = reader["phone_number"].ToString(),
                        BookingId = Convert.ToInt32(reader["booking_id"])
                    });
                }
            }
            return customers;
        }
    }
}
