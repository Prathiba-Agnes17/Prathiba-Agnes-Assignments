using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using InsuranceManagement.entity;
using InsuranceManagement.dao;
using InsuranceManagement.util;
using InsuranceManagement.myexceptions;

namespace InsuranceManagement.main
{
    class MainModule
    {
        static void Main(string[] args)
        {
            IPolicyService policyService = new PolicyServiceImpl();
            bool exit = false;

            while (!exit)
            {
                Console.WriteLine("\n=== Insurance Management System ===");
                Console.WriteLine("1. Create Policy");
                Console.WriteLine("2. Get Policy by ID");
                Console.WriteLine("3. Get All Policies");
                Console.WriteLine("4. Update Policy");
                Console.WriteLine("5. Delete Policy");
                Console.WriteLine("6. Exit");
                Console.Write("Choose an option: ");

                string input = Console.ReadLine();

                switch (input)
                {
                    case "1":
                        Console.Write("Enter Policy ID: ");
                        int createId = int.Parse(Console.ReadLine());
                        Console.Write("Enter Policy Name: ");
                        string name = Console.ReadLine();
                        Console.Write("Enter Policy Type: ");
                        string type = Console.ReadLine();
                        Console.Write("Enter Premium Amount: ");
                        decimal amount = decimal.Parse(Console.ReadLine());
                        Console.Write("Enter Coverage Details: ");
                        string details = Console.ReadLine();

                        Policy newPolicy = new Policy(createId, name, type, amount, details);
                        if (policyService.CreatePolicy(newPolicy))
                            Console.WriteLine("Policy created successfully.");
                        else
                            Console.WriteLine("Failed to create policy.");
                        break;

                    case "2":
                        try
                        {
                            Console.Write("Enter Policy ID to fetch: ");
                            int fetchId = int.Parse(Console.ReadLine());
                            Policy fetchedPolicy = policyService.GetPolicy(fetchId);
                            Console.WriteLine("Policy Details:");
                            Console.WriteLine(fetchedPolicy);
                        }
                        catch (PolicyNotFoundException ex)
                        {
                            Console.WriteLine("Error: " + ex.Message);
                        }
                        break;

                    case "3":
                        List<Policy> policies = policyService.GetAllPolicies();
                        Console.WriteLine("All Policies:");
                        foreach (Policy p in policies)
                        {
                            Console.WriteLine(p);
                        }
                        break;

                    case "4":
                        Console.Write("Enter Policy ID to update: ");
                        int updateId = int.Parse(Console.ReadLine());
                        Console.Write("Enter New Policy Name: ");
                        string newName = Console.ReadLine();
                        Console.Write("Enter New Policy Type: ");
                        string newType = Console.ReadLine();
                        Console.Write("Enter New Premium Amount: ");
                        decimal newAmount = decimal.Parse(Console.ReadLine());
                        Console.Write("Enter New Coverage Details: ");
                        string newDetails = Console.ReadLine();

                        Policy updatedPolicy = new Policy(updateId, newName, newType, newAmount, newDetails);
                        if (policyService.UpdatePolicy(updatedPolicy))
                            Console.WriteLine("Policy updated successfully.");
                        else
                            Console.WriteLine("Update failed.");
                        break;

                    case "5":
                        Console.Write("Enter Policy ID to delete: ");
                        int deleteId = int.Parse(Console.ReadLine());
                        if (policyService.DeletePolicy(deleteId))
                            Console.WriteLine("Policy deleted successfully.");
                        else
                            Console.WriteLine("Policy deletion failed.");
                        break;

                    case "6":
                        exit = true;
                        Console.WriteLine("Exiting application.");
                        break;

                    default:
                        Console.WriteLine("Invalid option. Try again.");
                        break;
                }
            }
        }
    }
}
