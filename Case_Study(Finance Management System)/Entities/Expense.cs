using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FinanceManagementSystem.Entities
{
    public class Expense
    {
        private int expenseId;
        private int userId;
        private decimal amount;
        private int categoryId;
        private DateTime date;
        private string description;

        public int ExpenseId
        {
            get { return expenseId; }
            set { expenseId = value; }
        }

        public int UserId
        {
            get { return userId; }
            set { userId = value; }
        }

        public decimal Amount
        {
            get { return amount; }
            set { amount = value; }
        }

        public int CategoryId
        {
            get { return categoryId; }
            set { categoryId = value; }
        }

        public DateTime Date
        {
            get { return date; }
            set { date = value; }
        }

        public string Description
        {
            get { return description; }
            set { description = value; }
        }

        // Default constructor
        public Expense() { }

        // Parameterized constructor
        public Expense(int expenseId, int userId, decimal amount, int categoryId, DateTime date, string description)
        {
            this.expenseId = expenseId;
            this.userId = userId;
            this.amount = amount;
            this.categoryId = categoryId;
            this.date = date;
            this.description = description;
        }
    }
}
