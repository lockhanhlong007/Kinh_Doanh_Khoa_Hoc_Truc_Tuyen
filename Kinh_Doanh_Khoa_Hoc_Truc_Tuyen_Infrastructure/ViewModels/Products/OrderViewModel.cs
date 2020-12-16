using System;
using System.Collections.Generic;
using System.Text;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Enums;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Interfaces;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Systems;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Products
{
    public class OrderViewModel : IDateTracking
    {
        public int Id { get; set; }

        public PaymentMethod PaymentMethod { set; get; }

        public Guid UserId { set; get; }

        public long? Total { get; set; }

        public string Address { get; set; }

        public string PhoneNumber { get; set; }

        public string Message { get; set; }

        public OrderStatus Status { get; set; }

        public DateTime CreationTime { get; set; }

        public DateTime? LastModificationTime { get; set; }

        public string CreatedUser { get; set; }

        public List<OrderDetailViewModel> OrderDetails { set; get; }
    }
}
