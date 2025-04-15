using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Ticket_Booking_System.Entities;

namespace Ticket_Booking_System.DAO
{
    public interface IVenueDAO
    {
        List<Venue> GetAllVenues();
    }
}
