using System.ComponentModel;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Enums
{
    public enum PaymentMethod
    {
        // Trả tiền qua ngân hàng nội địa
        [Description("Online Banking")]
        OnlineBanking,

        // Trả tiền qua Ví điện tử
        [Description("Payment Gateway")]
        PaymentGateway,

        [Description("Visa")]
        Visa,

        [Description("Master Card")]
        MasterCard,

        [Description("PayPal")]
        PayPal,

        [Description("Transfer")]
        Transfer

    }
}