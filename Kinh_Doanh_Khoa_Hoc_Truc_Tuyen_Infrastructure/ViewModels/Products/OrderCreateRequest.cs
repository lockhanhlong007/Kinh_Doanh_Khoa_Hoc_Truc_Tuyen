using System;
using System.Collections.Generic;
using System.Text;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Enums;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Interfaces;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Products
{
    public class OrderCreateRequest : IDateTracking
    {
        public int Id { get; set; }

        public PaymentMethod PaymentMethod { set; get; }

        public Guid UserId { set; get; }

        public long? Total { get; set; }

        public string Message { get; set; }

        public OrderStatus Status { get; set; }

        public DateTime CreationTime { get; set; }

        public DateTime? LastModificationTime { get; set; }

        public string CreateUser { get; set; }

        public List<OrderDetailCreateRequest> OrderDetails { set; get; }
    }
}
