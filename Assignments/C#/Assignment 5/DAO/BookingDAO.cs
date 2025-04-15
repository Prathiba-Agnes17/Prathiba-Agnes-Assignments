using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Ticket_Booking_System.Entities;
using Ticket_Booking_System.Util;
using Microsoft.Data.SqlClient;

namespace Ticket_Booking_System.DAO
{
    public class BookingDAO : IBookingDAO
    {
        public List<Booking> GetAllBookings()
        {
            List<Booking> bookings = new List<Booking>();
            using (SqlConnection conn = DBConnUtil.GetConnection("DbConnection"))
            {
                string query = "SELECT * FROM Booking";
                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    bookings.Add(new Booking
                    {
                        BookingId = Convert.ToInt32(reader["booking_id"]),
                        CustomerId = Convert.ToInt32(reader["customer_id"]),
                        EventId = Convert.ToInt32(reader["event_id"]),
                        NumTickets = Convert.ToInt32(reader["num_tickets"]),
                        TotalCost = Convert.ToDecimal(reader["total_cost"]),
                        BookingDate = Convert.ToDateTime(reader["booking_date"])
                    });
                }
            }
            return bookings;
        }

        public Booking GetBookingById(int bookingId)
        {
            Booking booking = null;
            using (SqlConnection conn = DBConnUtil.GetConnection("DbConnection"))
            {
                string query = "SELECT * FROM Booking WHERE booking_id = @id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", bookingId);
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    booking = new Booking
                    {
                        BookingId = Convert.ToInt32(reader["booking_id"]),
                        CustomerId = Convert.ToInt32(reader["customer_id"]),
                        EventId = Convert.ToInt32(reader["event_id"]),
                        NumTickets = Convert.ToInt32(reader["num_tickets"]),
                        TotalCost = Convert.ToDecimal(reader["total_cost"]),
                        BookingDate = Convert.ToDateTime(reader["booking_date"])
                    };
                }
            }
            return booking;
        }
    }
}

