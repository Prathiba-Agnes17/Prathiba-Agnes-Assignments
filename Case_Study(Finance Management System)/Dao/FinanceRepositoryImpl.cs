using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using FinanceManagementSystem.Entities;
using FinanceManagementSystem.Util;
using FinanceManagementSystem.MyExceptions;



namespace FinanceManagementSystem.Dao
{
    public class FinanceRepositoryImpl : IFinanceRepository
    {
        private string connectionFilePath = "connection.txt";

        // Create User
        public bool CreateUser(User user)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(user.Email) || !user.Email.Contains("@") || !user.Email.Contains("."))
                {
                    throw new ArgumentException("Invalid email format. Email must contain '@' and '.'");
                }

                using (SqlConnection conn = DBConnUtil.GetConnection(connectionFilePath))
                {
                    conn.Open();
                    string query = "INSERT INTO Users (username, password, email) VALUES (@username, @password, @email)";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@username", user.Username);
                    cmd.Parameters.AddWithValue("@password", user.Password);
                    cmd.Parameters.AddWithValue("@email", user.Email);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
            catch (ArgumentException ex)
            {
                Console.WriteLine("Validation Error: " + ex.Message);
                return false;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error in CreateUser: " + ex.Message);
                return false;
            }
        }


        // Create Expense
        public bool CreateExpense(Expense expense)
        {
            try
            {
                using (SqlConnection conn = DBConnUtil.GetConnection(connectionFilePath))
                {
                    conn.Open();
                    string query = "INSERT INTO Expenses (user_id, amount, category_id, date, description) VALUES (@user_id, @amount, @category_id, @date, @description)";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@user_id", expense.UserId);
                    cmd.Parameters.AddWithValue("@amount", expense.Amount);
                    cmd.Parameters.AddWithValue("@category_id", expense.CategoryId);
                    cmd.Parameters.AddWithValue("@date", expense.Date);
                    cmd.Parameters.AddWithValue("@description", expense.Description);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error in CreateExpense: " + ex.Message);
                return false;
            }
        }

        // Delete User
        public bool DeleteUser(int userId)
        {
            try
            {
                using (SqlConnection conn = DBConnUtil.GetConnection(connectionFilePath))
                {
                    conn.Open();
                    string query = "DELETE FROM Users WHERE user_id = @user_id";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@user_id", userId);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected == 0)
                    {
                        throw new UserNotFoundException($"User with ID {userId} not found.");
                    }

                    return true;
                }
            }
            catch (UserNotFoundException ex)
            {
                Console.WriteLine("Custom Exception: " + ex.Message);
                return false;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error in DeleteUser: " + ex.Message);
                return false;
            }
        }

        // Delete Expense
        public bool DeleteExpense(int expenseId)
        {
            try
            {
                using (SqlConnection conn = DBConnUtil.GetConnection(connectionFilePath))
                {
                    conn.Open();
                    string query = "DELETE FROM Expenses WHERE expense_id = @expense_id";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@expense_id", expenseId);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected == 0)
                    {
                        throw new ExpenseNotFoundException($"Expense with ID {expenseId} not found.");
                    }

                    return true;
                }
            }
            catch (ExpenseNotFoundException ex)
            {
                Console.WriteLine("Custom Exception: " + ex.Message);
                return false;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error in DeleteExpense: " + ex.Message);
                return false;
            }
        }

        // Get All Expenses for a User
        public List<Expense> GetAllExpenses(int userId)
        {
            try
            {
                using (SqlConnection conn = DBConnUtil.GetConnection(connectionFilePath))
                {
                    conn.Open();

                    // Step 1: Check if user exists
                    string userCheckQuery = "SELECT COUNT(*) FROM Users WHERE user_id = @user_id";
                    SqlCommand userCheckCmd = new SqlCommand(userCheckQuery, conn);
                    userCheckCmd.Parameters.AddWithValue("@user_id", userId);

                    int userCount = (int)userCheckCmd.ExecuteScalar();

                    if (userCount == 0)
                    {
                        Console.WriteLine($"User with ID {userId} not found.");
                        return null;  // or return new List<Expense>(); if you want to return empty list
                    }

                    // Step 2: If user exists, fetch expenses
                    string expenseQuery = "SELECT * FROM Expenses WHERE user_id = @user_id";
                    SqlCommand cmd = new SqlCommand(expenseQuery, conn);
                    cmd.Parameters.AddWithValue("@user_id", userId);

                    SqlDataReader reader = cmd.ExecuteReader();
                    List<Expense> expenses = new List<Expense>();

                    while (reader.Read())
                    {
                        Expense expense = new Expense
                        {
                            ExpenseId = Convert.ToInt32(reader["expense_id"]),
                            UserId = Convert.ToInt32(reader["user_id"]),
                            Amount = Convert.ToDecimal(reader["amount"]),
                            CategoryId = Convert.ToInt32(reader["category_id"]),
                            Date = Convert.ToDateTime(reader["date"]),
                            Description = reader["description"].ToString()
                        };
                        expenses.Add(expense);
                    }

                    return expenses;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error in GetAllExpenses: " + ex.Message);
                return null;
            }
        }


        // Update Expense
        public bool UpdateExpense(int userId, Expense updatedExpense)
        {
            try
            {
                using (SqlConnection conn = DBConnUtil.GetConnection(connectionFilePath))
                {
                    conn.Open();
                    string query = "UPDATE Expenses SET amount = @amount, category_id = @category_id, date = @date, description = @description WHERE expense_id = @expense_id AND user_id = @user_id";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@expense_id", updatedExpense.ExpenseId);
                    cmd.Parameters.AddWithValue("@user_id", userId);
                    cmd.Parameters.AddWithValue("@amount", updatedExpense.Amount);
                    cmd.Parameters.AddWithValue("@category_id", updatedExpense.CategoryId);
                    cmd.Parameters.AddWithValue("@date", updatedExpense.Date);
                    cmd.Parameters.AddWithValue("@description", updatedExpense.Description);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected == 0)
                    {
                        throw new ExpenseNotFoundException($"Expense with ID {updatedExpense.ExpenseId} not found or does not belong to user {userId}.");
                    }

                    return true;
                }
            }
            catch (ExpenseNotFoundException ex)
            {
                Console.WriteLine("Custom Exception: " + ex.Message);
                return false;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error in UpdateExpense: " + ex.Message);
                return false;
            }
        }


    }
}
