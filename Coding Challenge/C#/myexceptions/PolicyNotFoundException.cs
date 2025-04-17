using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InsuranceManagement.myexceptions
{
    public class PolicyNotFoundException : ApplicationException
    {
        public PolicyNotFoundException() : base() { }

        public PolicyNotFoundException(string message) : base(message) { }
    }
}
