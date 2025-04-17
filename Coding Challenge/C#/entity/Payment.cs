using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InsuranceManagement.entity
{
    public class Payment
    {
        public int PaymentId { get; set; }
        public DateTime PaymentDate { get; set; }
        public decimal PaymentAmount { get; set; }
        public int ClientId { get; set; }

        public Payment() { }

        public Payment(int paymentId, DateTime paymentDate, decimal paymentAmount, int clientId)
        {
            PaymentId = paymentId;
            PaymentDate = paymentDate;
            PaymentAmount = paymentAmount;
            ClientId = clientId;
        }

        public override string ToString()
        {
            return $"PaymentId: {PaymentId}, Date: {PaymentDate.ToShortDateString()}, Amount: {PaymentAmount}, ClientId: {ClientId}";
        }
    }
}
