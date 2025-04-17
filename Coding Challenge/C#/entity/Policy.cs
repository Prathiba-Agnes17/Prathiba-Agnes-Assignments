using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InsuranceManagement.entity
{
    public class Policy
    {
        public int PolicyId { get; set; }
        public string PolicyName { get; set; }
        public string PolicyType { get; set; }
        public decimal PremiumAmount { get; set; }
        public string CoverageDetails { get; set; }

        public Policy() { }

        public Policy(int policyId, string policyName, string policyType, decimal premiumAmount, string coverageDetails)
        {
            PolicyId = policyId;
            PolicyName = policyName;
            PolicyType = policyType;
            PremiumAmount = premiumAmount;
            CoverageDetails = coverageDetails;
        }

        public override string ToString()
        {
            return $"PolicyId: {PolicyId}, Name: {PolicyName}, Type: {PolicyType}, Premium: {PremiumAmount}, Coverage: {CoverageDetails}";
        }
    }
}
