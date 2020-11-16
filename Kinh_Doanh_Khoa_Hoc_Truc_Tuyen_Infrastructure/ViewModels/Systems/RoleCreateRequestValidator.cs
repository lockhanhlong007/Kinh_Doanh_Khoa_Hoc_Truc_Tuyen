using FluentValidation;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Systems
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