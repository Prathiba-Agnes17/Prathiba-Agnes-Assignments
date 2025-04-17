using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InsuranceManagement.entity
{
    public class Claim
    {
        public int ClaimId { get; set; }
        public string ClaimNumber { get; set; }
        public DateTime DateFiled { get; set; }
        public decimal ClaimAmount { get; set; }
        public string Status { get; set; }
        public int PolicyId { get; set; }
        public int ClientId { get; set; }

        public Claim() { }

        public Claim(int claimId, string claimNumber, DateTime dateFiled, decimal claimAmount, string status, int policyId, int clientId)
        {
            ClaimId = claimId;
            ClaimNumber = claimNumber;
            DateFiled = dateFiled;
            ClaimAmount = claimAmount;
            Status = status;
            PolicyId = policyId;
            ClientId = clientId;
        }

        public override string ToString()
        {
            return $"ClaimId: {ClaimId}, Number: {ClaimNumber}, Date: {DateFiled.ToShortDateString()}, Amount: {ClaimAmount}, Status: {Status}, PolicyId: {PolicyId}, ClientId: {ClientId}";
        }
    }
}
