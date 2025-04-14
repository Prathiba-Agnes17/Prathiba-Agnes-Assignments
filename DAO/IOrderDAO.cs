using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TechShop.Entities;

namespace TechShop.DAO
{
    public interface IOrderDAO
    {
        void PlaceOrder(Order order, List<OrderDetail> orderDetails);
        List<Order> GetAllOrders();
        Order GetOrderById(int orderId);
        void CancelOrder(int orderId);
        void UpdateOrderStatus(int orderId, string newStatus);
    }
}
