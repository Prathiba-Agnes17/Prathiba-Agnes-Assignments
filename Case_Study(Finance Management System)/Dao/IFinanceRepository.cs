using FinanceManagementSystem.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FinanceManagementSystem.Dao
{
    public interface IFinanceRepository
    {
        bool CreateUser(User user);
        bool CreateExpense(Expense expense);
        bool DeleteUser(int userId);
        bool DeleteExpense(int expenseId);
        List<Expense> GetAllExpenses(int userId);
        bool UpdateExpense(int userId, Expense updatedExpense);
    }
}
