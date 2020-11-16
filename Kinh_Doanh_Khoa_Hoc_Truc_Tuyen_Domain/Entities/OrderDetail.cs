using System.ComponentModel.DataAnnotations.Schema;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Entities
{
    [Table("OrderDetails")]
    public class OrderDetail
    {
        public OrderDetail()
        {
        }

        public int OrderId { set; get; }

        public int CourseId { set; get; }

        public decimal Price { set; get; }

        public decimal PromotionPrice { set; get; }

        public Order Order { set; get; }

        public Course Course { set; get; }
    }
}