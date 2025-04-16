using System;
using System.Collections.Generic;
using FinanceManagementSystem.Entities;
using FinanceManagementSystem.Dao;


namespace FinanceManagementSystem
{
    class FinanceApp
    {
        static void Main(string[] args)
        {
            IFinanceRepository repo = new FinanceRepositoryImpl();
            bool running = true;

            while (running)
            {
                Console.WriteLine("\n=== Finance Management System ===");
                Console.WriteLine("1. Create User");
                Console.WriteLine("2. Create Expense");
                Console.WriteLine("3. View All Expenses by User");
                Console.WriteLine("4. Delete User");
                Console.WriteLine("5. Delete Expense");
                Console.WriteLine("6. Update Expense");
                Console.WriteLine("7. Exit");
                Console.Write("Enter your choice: ");
                string choice = Console.ReadLine();

                switch (choice)
                {
                    case "1":
                        Console.Write("Enter username: ");
                        string username = Console.ReadLine();
                        Console.Write("Enter password: ");
                        string password = Console.ReadLine();
                        Console.Write("Enter email: ");
                        string email = Console.ReadLine();

                        User user = new User { Username = username, Password = password, Email = email };
                        Console.WriteLine(repo.CreateUser(user) ? "User created!" : "Failed to create user.");
                        break;

                    case "2":
                        Console.Write("Enter User ID: ");
                        int userId = int.Parse(Console.ReadLine());
                        Console.Write("Enter Amount: ");
                        decimal amount = decimal.Parse(Console.ReadLine());
                        Console.Write("Enter Category ID: ");
                        int categoryId = int.Parse(Console.ReadLine());
                        Console.Write("Enter Description: ");
                        string desc = Console.ReadLine();

                        Expense expense = new Expense
                        {
                            UserId = userId,
                            Amount = amount,
                            CategoryId = categoryId,
                            Date = DateTime.Now,
                            Description = desc
                        };
                        Console.WriteLine(repo.CreateExpense(expense) ? "Expense added!" : "Failed to add expense.");
                        break;

                    case "3":
                        Console.Write("Enter User ID: ");
                        int uid = int.Parse(Console.ReadLine());
                        List<Expense> expenses = repo.GetAllExpenses(uid);
                        if (expenses != null && expenses.Count > 0)
                        {
                            foreach (var e in expenses)
                            {
                                Console.WriteLine($"{e.ExpenseId} | ₹{e.Amount} | {e.Description} | {e.Date}");
                            }
                        }
                        else
                        {
                            Console.WriteLine("No expenses found.");
                        }
                        break;

                    case "4":
                        Console.Write("Enter User ID to delete: ");
                        int delUserId = int.Parse(Console.ReadLine());
                        Console.WriteLine(repo.DeleteUser(delUserId) ? "User deleted." : "User not found.");
                        break;

                    case "5":
                        Console.Write("Enter Expense ID to delete: ");
                        int delExpenseId = int.Parse(Console.ReadLine());
                        Console.WriteLine(repo.DeleteExpense(delExpenseId) ? "Expense deleted." : "Expense not found.");
                        break;

                    case "6":
                        Console.Write("Enter User ID: ");
                        int updUserId = int.Parse(Console.ReadLine());
                        Console.Write("Enter Expense ID to update: ");
                        int updExpenseId = int.Parse(Console.ReadLine());
                        Console.Write("Enter New Amount: ");
                        decimal updAmount = decimal.Parse(Console.ReadLine());
                        Console.Write("Enter New Category ID: ");
                        int updCategory = int.Parse(Console.ReadLine());
                        Console.Write("Enter New Description: ");
                        string updDesc = Console.ReadLine();

                        Expense updatedExpense = new Expense
                        {
                            ExpenseId = updExpenseId,
                            UserId = updUserId,
                            Amount = updAmount,
                            CategoryId = updCategory,
                            Date = DateTime.Now,
                            Description = updDesc
                        };

                        Console.WriteLine(repo.UpdateExpense(updUserId, updatedExpense) ? "Expense updated!" : "Failed to update.");
                        break;

                    case "7":
                        running = false;
                        Console.WriteLine("Exiting program. Goodbye!");
                        break;

                    default:
                        Console.WriteLine("Invalid choice. Try again.");
                        break;
                }
            }
        }
    }
}
