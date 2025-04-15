using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Ticket_Booking_System.Entities;
using Ticket_Booking_System.Util;
using Microsoft.Data.SqlClient;

namespace Ticket_Booking_System.DAO
{
    public class VenueDAO : IVenueDAO
    {
        public List<Venue> GetAllVenues()
        {
            List<Venue> venues = new List<Venue>();

            using (SqlConnection conn = DBConnUtil.GetConnection("DbConnection"))
            {
                string query = "SELECT * FROM Venu";
                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    venues.Add(new Venue
                    {
                        VenueId = Convert.ToInt32(reader["venue_id"]),
                        VenueName = reader["venue_name"].ToString(),
                        Address = reader["address"].ToString()
                    });
                }
            }

            return venues;
        }
    }
}
