using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Ticket_Booking_System.Entities;
using Ticket_Booking_System.Util;
using Microsoft.Data.SqlClient;

namespace Ticket_Booking_System.DAO
{
    public class EventDAO : IEventDAO
    {
        public List<Event> GetAllEvents()
        {
            List<Event> events = new List<Event>();
            using (SqlConnection conn = DBConnUtil.GetConnection("DbConnection"))
            {
                string query = "SELECT * FROM Event";
                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    events.Add(new Event
                    {
                        EventId = Convert.ToInt32(reader["event_id"]),
                        EventName = reader["event_name"].ToString(),
                        EventDate = Convert.ToDateTime(reader["event_date"]),
                        EventTime = (TimeSpan)reader["event_time"],
                        VenueId = Convert.ToInt32(reader["venue_id"]),
                        TotalSeats = Convert.ToInt32(reader["total_seats"]),
                        AvailableSeats = Convert.ToInt32(reader["available_seats"]),
                        TicketPrice = Convert.ToDecimal(reader["ticket_price"]),
                        EventType = reader["event_type"].ToString(),
                        BookingId = Convert.ToInt32(reader["booking_id"])
                    });
                }
            }
            return events;
        }

        public List<Event> GetAvailableEvents()
        {
            List<Event> events = new List<Event>();
            using (SqlConnection conn = DBConnUtil.GetConnection("DbConnection"))
            {
                string query = "SELECT * FROM Event WHERE available_seats > 0";
                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    events.Add(new Event
                    {
                        EventId = Convert.ToInt32(reader["event_id"]),
                        EventName = reader["event_name"].ToString(),
                        EventDate = Convert.ToDateTime(reader["event_date"]),
                        EventTime = (TimeSpan)reader["event_time"],
                        VenueId = Convert.ToInt32(reader["venue_id"]),
                        TotalSeats = Convert.ToInt32(reader["total_seats"]),
                        AvailableSeats = Convert.ToInt32(reader["available_seats"]),
                        TicketPrice = Convert.ToDecimal(reader["ticket_price"]),
                        EventType = reader["event_type"].ToString(),
                        BookingId = Convert.ToInt32(reader["booking_id"])
                    });
                }
            }
            return events;
        }

        public Event GetEventById(int eventId)
        {
            Event ev = null;
            using (SqlConnection conn = DBConnUtil.GetConnection("DbConnection"))
            {
                string query = "SELECT * FROM Event WHERE event_id = @id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", eventId);
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    ev = new Event
                    {
                        EventId = Convert.ToInt32(reader["event_id"]),
                        EventName = reader["event_name"].ToString(),
                        EventDate = Convert.ToDateTime(reader["event_date"]),
                        EventTime = (TimeSpan)reader["event_time"],
                        VenueId = Convert.ToInt32(reader["venue_id"]),
                        TotalSeats = Convert.ToInt32(reader["total_seats"]),
                        AvailableSeats = Convert.ToInt32(reader["available_seats"]),
                        TicketPrice = Convert.ToDecimal(reader["ticket_price"]),
                        EventType = reader["event_type"].ToString(),
                        BookingId = Convert.ToInt32(reader["booking_id"])
                    };
                }
            }
            return ev;
        }
    }
}

