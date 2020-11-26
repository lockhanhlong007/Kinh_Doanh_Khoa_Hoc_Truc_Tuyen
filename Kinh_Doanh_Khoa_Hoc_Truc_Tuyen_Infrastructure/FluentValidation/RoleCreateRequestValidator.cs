using FluentValidation;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Systems;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.FluentValidation
{
    public class RoleCreateRequestValidator : AbstractValidator<RoleCreateRequest>
    {
        public RoleCreateRequestValidator()
        {
            RuleFor(x => x.Name).NotEmpty().WithMessage("Name value is required").MaximumLength(200)
                .WithMessage("Role Id cannot over limit 200 characters");
        }
    }
}