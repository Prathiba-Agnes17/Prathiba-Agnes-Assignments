using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TechShop.Exceptions
{
    public class InsufficientStockException : System.Exception
    {
        public InsufficientStockException() { }

        public InsufficientStockException(string message) : base(message) { }

        public InsufficientStockException(string message, System.Exception inner) : base(message, inner) { }
    }
}


