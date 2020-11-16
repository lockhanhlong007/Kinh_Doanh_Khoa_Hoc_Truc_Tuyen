﻿using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Helpers;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Filter
{
    public class ValidationFilterAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext context)
        {
            if (!context.ModelState.IsValid)
            {
                context.Result = new BadRequestObjectResult(new ApiBadRequestResponse(context.ModelState));
            }
            base.OnActionExecuting(context);
        }
    }
}
