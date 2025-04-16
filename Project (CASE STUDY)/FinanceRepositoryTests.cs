using NUnit.Framework;
using FinanceManagementSystem.Dao;
using FinanceManagementSystem.Entities;
using FinanceManagementSystem.Util;
using System;
using System.Collections.Generic;

namespace FinanceManagementSystem.Tests
{
    [TestFixture]
    public class FinanceRepositoryTests
    {
        private IFinanceRepository _repo;

        [SetUp]
        public void Setup()
        {
            _repo = new FinanceRepositoryImpl();
        }

        [Test]
        public void CreateUser_ValidUser_ReturnsTrue()
        {
            User user = new User
            {
                Username = "melvin",
                Password = "melvin123",
                Email = "melvin@mail.com"
            };

            bool result = _repo.CreateUser(user);
            Assert.That(result, Is.True);
        }

        [Test]
        public void CreateExpense_ValidExpense_ReturnsTrue()
        {
            Expense expense = new Expense
            {
                UserId = 1, // Make sure this user exists in DB
                Amount = 200,
                CategoryId = 1, // Ensure this category exists
                Date = DateTime.Now,
                Description = "Restaurant"
            };

            bool result = _repo.CreateExpense(expense);
            Assert.That(result, Is.True);
        }

        [Test]
        public void GetAllExpenses_ExistingUserId_ReturnsExpenses()
        {
            List<Expense> expenses = _repo.GetAllExpenses(1); // Valid user ID
            Assert.That(expenses, Is.Not.Null);
        }

        [Test]
        public void DeleteUser_InvalidUserId_ReturnsFalse()
        {
            bool result = _repo.DeleteUser(-999); // Assuming this ID doesn't exist
            Assert.That(result, Is.False);
        }

        [Test]
        public void DeleteExpense_InvalidExpenseId_ReturnsFalse()
        {
            bool result = _repo.DeleteExpense(-888); // Assuming this ID doesn't exist
            Assert.That(result, Is.False);
        }
    }
}

