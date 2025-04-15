using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Ticket_Booking_System.DAO;
using Ticket_Booking_System.Entities;

namespace Ticket_Booking_System.Main
{
    public class MainModule
    {
        static void Main(string[] args)
        {
            IVenueDAO venueDAO = new VenueDAO();
            IEventDAO eventDAO = new EventDAO();
            IBookingDAO bookingDAO = new BookingDAO();
            ICustomerDAO customerDAO = new CustomerDAO();

            bool exit = false;

            while (!exit)
            {
                Console.WriteLine("\n===== Ticket Booking System Menu =====");
                Console.WriteLine("1. View All Venues");
                Console.WriteLine("2. View All Events");
                Console.WriteLine("3. View Available Events");
                Console.WriteLine("4. View Event by ID");
                Console.WriteLine("5. View All Bookings");
                Console.WriteLine("6. View All Customers");
                Console.WriteLine("7. Exit");
                Console.Write("Enter your choice: ");
                string input = Console.ReadLine();

                switch (input)
                {
                    case "1":
                        List<Venue> venues = venueDAO.GetAllVenues();
                        Console.WriteLine("\n--- All Venues ---");
                        foreach (var v in venues)
                        {
                            Console.WriteLine($"{v.VenueId}. {v.VenueName} - {v.Address}");
                        }
                        break;

                    case "2":
                        List<Event> events = eventDAO.GetAllEvents();
                        Console.WriteLine("\n--- All Events ---");
                        foreach (var e in events)
                        {
                            Console.WriteLine($"{e.EventId}. {e.EventName} ({e.EventType}) on {e.EventDate.ToShortDateString()} at {e.EventTime}");
                        }
                        break;

                    case "3":
                        List<Event> availableEvents = eventDAO.GetAvailableEvents();
                        Console.WriteLine("\n--- Available Events ---");
                        foreach (var e in availableEvents)
                        {
                            Console.WriteLine($"{e.EventId}. {e.EventName} - {e.AvailableSeats} seats available");
                        }
                        break;

                    case "4":
                        Console.Write("Enter Event ID: ");
                        int eventId;
                        if (int.TryParse(Console.ReadLine(), out eventId))
                        {
                            Event evt = eventDAO.GetEventById(eventId);
                            if (evt != null)
                            {
                                Console.WriteLine($"\nEvent: {evt.EventName}");
                                Console.WriteLine($"Date: {evt.EventDate.ToShortDateString()}");
                                Console.WriteLine($"Time: {evt.EventTime}");
                                Console.WriteLine($"Venue ID: {evt.VenueId}");
                                Console.WriteLine($"Available Seats: {evt.AvailableSeats}");
                                Console.WriteLine($"Ticket Price: ₹{evt.TicketPrice}");
                                Console.WriteLine($"Type: {evt.EventType}");
                            }
                            else
                            {
                                Console.WriteLine("Event not found.");
                            }
                        }
                        else
                        {
                            Console.WriteLine("Invalid input.");
                        }
                        break;

                    case "5":
                        List<Booking> bookings = bookingDAO.GetAllBookings();
                        Console.WriteLine("\n--- All Bookings ---");
                        foreach (var b in bookings)
                        {
                            Console.WriteLine($"Booking ID: {b.BookingId}, Customer ID: {b.CustomerId}, Event ID: {b.EventId}, Tickets: {b.NumTickets}, Total: ₹{b.TotalCost}, Date: {b.BookingDate.ToShortDateString()}");
                        }
                        break;

                    case "6":
                        List<Customer> customers = customerDAO.GetAllCustomers();
                        Console.WriteLine("\n--- All Customers ---");
                        foreach (var c in customers)
                        {
                            Console.WriteLine($"{c.CustomerId}. {c.CustomerName} - {c.Email}, Phone: {c.PhoneNumber}");
                        }
                        break;

                    case "7":
                        exit = true;
                        Console.WriteLine("Exiting...");
                        break;

                    default:
                        Console.WriteLine("Invalid option. Please try again.");
                        break;
                }
            }
        }
    }
}
