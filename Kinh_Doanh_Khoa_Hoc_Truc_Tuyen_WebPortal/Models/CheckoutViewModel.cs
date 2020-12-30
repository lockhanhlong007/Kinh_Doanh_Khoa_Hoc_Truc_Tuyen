using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Products;
using System;
using System.Collections.Generic;
using System.Linq;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Enums;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Systems;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Extensions;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Models
{
    public class CheckoutViewModel : OrderViewModel
    {
        public List<CartViewModel> Carts { get; set; }

        public List<EnumModel> PaymentMethods
        {
            get
            {
                return ((PaymentMethod[])Enum.GetValues(typeof(PaymentMethod)))
                    .Select(c => new EnumModel
                    {
                        Value = (int)c,
                        Name = c.GetDescription()
                    }).ToList();
            }
        }
    }
}