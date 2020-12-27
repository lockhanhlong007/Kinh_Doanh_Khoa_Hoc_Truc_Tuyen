using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Products;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Models
{
    public class TrackOrderDetailViewModel
    {
        public OrderViewModel OrderViewModel { get; set; }
        public string NameDash { get; set; }
    }
}
