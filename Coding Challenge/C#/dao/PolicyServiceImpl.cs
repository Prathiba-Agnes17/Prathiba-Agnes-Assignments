using System;
using System.Collections.Generic;
using InsuranceManagement.entity;
using InsuranceManagement.util;
using InsuranceManagement.myexceptions;
using Microsoft.Data.SqlClient;

namespace InsuranceManagement.dao
{
    public class PolicyServiceImpl : IPolicyService
    {
        private string connectionFilePath = "connection.txt";

        public bool CreatePolicy(Policy policy)
        {
            try
            {
                using (SqlConnection connection = DBConnUtil.GetConnection(connectionFilePath))
                {
                    connection.Open();

                    string query = "INSERT INTO Policy VALUES (@PolicyId, @PolicyName, @PolicyType, @PremiumAmount, @CoverageDetails)";
                    SqlCommand cmd = new SqlCommand(query, connection);
                    cmd.Parameters.AddWithValue("@PolicyId", policy.PolicyId);
                    cmd.Parameters.AddWithValue("@PolicyName", policy.PolicyName);
                    cmd.Parameters.AddWithValue("@PolicyType", policy.PolicyType);
                    cmd.Parameters.AddWithValue("@PremiumAmount", policy.PremiumAmount);
                    cmd.Parameters.AddWithValue("@CoverageDetails", policy.CoverageDetails);

                    return cmd.ExecuteNonQuery() > 0;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error in CreatePolicy: " + ex.Message);
                return false;
            }
        }

        public Policy GetPolicy(int policyId)
        {
            try
            {
                using (SqlConnection connection = DBConnUtil.GetConnection(connectionFilePath))
                {
                    connection.Open();

                    string query = "SELECT * FROM Policy WHERE PolicyId = @PolicyId";
                    SqlCommand cmd = new SqlCommand(query, connection);
                    cmd.Parameters.AddWithValue("@PolicyId", policyId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        return new Policy
                        {
                            PolicyId = (int)reader["PolicyId"],
                            PolicyName = reader["PolicyName"].ToString(),
                            PolicyType = reader["PolicyType"].ToString(),
                            PremiumAmount = (decimal)reader["PremiumAmount"],
                            CoverageDetails = reader["CoverageDetails"].ToString()
                        };
                    }
                    else
                    {
                        throw new PolicyNotFoundException($"Policy with ID {policyId} not found.");
                    }
                }
            }
            catch (PolicyNotFoundException ex)
            {
                Console.WriteLine("Custom Exception: " + ex.Message);
                return null;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error in GetPolicy: " + ex.Message);
                return null;
            }
        }

        public List<Policy> GetAllPolicies()
        {
            List<Policy> policies = new List<Policy>();

            try
            {
                using (SqlConnection connection = DBConnUtil.GetConnection(connectionFilePath))
                {
                    connection.Open();

                    string query = "SELECT * FROM Policy";
                    SqlCommand cmd = new SqlCommand(query, connection);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        policies.Add(new Policy(
                            (int)reader["PolicyId"],
                            reader["PolicyName"].ToString(),
                            reader["PolicyType"].ToString(),
                            (decimal)reader["PremiumAmount"],
                            reader["CoverageDetails"].ToString()
                        ));
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error in GetAllPolicies: " + ex.Message);
            }

            return policies;
        }

        public bool UpdatePolicy(Policy policy)
        {
            try
            {
                using (SqlConnection connection = DBConnUtil.GetConnection(connectionFilePath))
                {
                    connection.Open();

                    string query = "UPDATE Policy SET PolicyName=@PolicyName, PolicyType=@PolicyType, PremiumAmount=@PremiumAmount, CoverageDetails=@CoverageDetails WHERE PolicyId=@PolicyId";
                    SqlCommand cmd = new SqlCommand(query, connection);
                    cmd.Parameters.AddWithValue("@PolicyName", policy.PolicyName);
                    cmd.Parameters.AddWithValue("@PolicyType", policy.PolicyType);
                    cmd.Parameters.AddWithValue("@PremiumAmount", policy.PremiumAmount);
                    cmd.Parameters.AddWithValue("@CoverageDetails", policy.CoverageDetails);
                    cmd.Parameters.AddWithValue("@PolicyId", policy.PolicyId);

                    return cmd.ExecuteNonQuery() > 0;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error in UpdatePolicy: " + ex.Message);
                return false;
            }
        }

        public bool DeletePolicy(int policyId)
        {
            try
            {
                using (SqlConnection connection = DBConnUtil.GetConnection(connectionFilePath))
                {
                    connection.Open();

                    string query = "DELETE FROM Policy WHERE PolicyId = @PolicyId";
                    SqlCommand cmd = new SqlCommand(query, connection);
                    cmd.Parameters.AddWithValue("@PolicyId", policyId);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected == 0)
                    {
                        throw new PolicyNotFoundException($"Policy with ID {policyId} not found.");
                    }

                    return true;
                }
            }
            catch (PolicyNotFoundException ex)
            {
                Console.WriteLine("Custom Exception: " + ex.Message);
                return false;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error in DeletePolicy: " + ex.Message);
                return false;
            }
        }
    }
}

