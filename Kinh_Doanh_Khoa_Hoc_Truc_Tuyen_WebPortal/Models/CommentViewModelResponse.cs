using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Products;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Models
{
    public class CommentViewModelResponse
    {
        public List<CommentViewModel> CommentViewModels { get; set; }
        public int TotalRecord { get; set; }
    }
}
