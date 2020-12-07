using FluentValidation;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Products;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.FluentValidation
{
    public class CommentCreateRequestValidator : AbstractValidator<CommentCreateRequest>
    {
        public CommentCreateRequestValidator()
        {
            RuleFor(x => x.EntityId).GreaterThan(0)
                .WithMessage("Id is not valid");

            RuleFor(x => x.Content).NotEmpty().WithMessage("Content is required");

            RuleFor(x => x.EntityType).NotEmpty().WithMessage("Type is required");
        }
    }
}
