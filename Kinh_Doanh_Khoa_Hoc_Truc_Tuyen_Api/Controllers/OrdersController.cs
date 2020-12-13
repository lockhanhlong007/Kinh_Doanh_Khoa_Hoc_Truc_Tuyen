using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Filter;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Helpers;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Services;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.EF;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Entities;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Enums;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Products;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrdersController : ControllerBase
    {
        private readonly EKhoaHocDbContext _khoaHocDbContext;
        private ILogger<OrdersController> _logger;
        private readonly UserManager<AppUser> _userManager;
        public OrdersController(EKhoaHocDbContext khoaHocDbContext, ILogger<OrdersController> logger, IStorageService storageService, UserManager<AppUser> userManager)
        {
            _khoaHocDbContext = khoaHocDbContext;
            _logger = logger;
            _userManager = userManager;
        }

        #region Orders

        [HttpGet("filter")]
        public async Task<IActionResult> GetOrdersPaging(string filter, int pageIndex, int pageSize)
        {
            var query = _khoaHocDbContext.Orders.Include(x => x.AppUser).AsNoTracking();
            if (!string.IsNullOrEmpty(filter))
            {
                query = query.Where(x => x.AppUser.UserName.Contains(filter) || x.AppUser.Name.ToString().Contains(filter));
            }
            var items = new List<OrderViewModel>();
            var totalRecords = await query.CountAsync();
            await query.Skip((pageIndex - 1) * pageSize).Take(pageSize).ForEachAsync(x =>
            {
                items.Add(new OrderViewModel
                {
                    Id = x.Id,
                    UserId = x.UserId,
                    CreationTime = x.CreationTime,
                    LastModificationTime = x.LastModificationTime,
                    Status = x.Status,
                    Message = x.Message,
                    CreateUser = x.AppUser.Name + "(" + x.AppUser.Email + ")",
                    PaymentMethod = x.PaymentMethod,
                    Total = x.Total
                });
            });

            var pagination = new Pagination<OrderViewModel>
            {
                Items = items,
                TotalRecords = totalRecords
            };
            return Ok(pagination);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetDetail(int commentId)
        {
            var order = await _khoaHocDbContext.Orders.FindAsync(commentId);
            if (order == null)
            {
                return NotFound(new ApiNotFoundResponse($"Cannot found order with id: {commentId}"));
            }
            var user = await _userManager.FindByIdAsync(order.UserId.ToString());
            var orderViewModel = new OrderViewModel
            {
                Id = order.Id,
                UserId = order.UserId,
                CreationTime = order.CreationTime,
                LastModificationTime = order.LastModificationTime,
                Status = order.Status,
                Message = order.Message,
                CreateUser = user?.Name + "(" + user?.Email + ")",
                PaymentMethod = order.PaymentMethod,
                Total = order.Total
            };
            return Ok(orderViewModel);
        }


        [HttpPut("status-type-{statusType}/multi-items")]
        [ValidationFilter]
        public async Task<IActionResult> StatusOrder(int statusType, List<int> request)
        {
            foreach (var orderId in request)
            {
                var order = await _khoaHocDbContext.Orders.FindAsync(orderId);
                if (order == null)
                {
                    return NotFound(new ApiNotFoundResponse($"Cannot found the order with id: {orderId}"));
                }
                if(statusType == 1)
                {
                    order.Status = OrderStatus.InProgress;
                }
                else if (statusType == 2)
                {
                    order.Status = OrderStatus.Returned;
                }
                else if (statusType == 3)
                {
                    order.Status = OrderStatus.Cancelled;
                }
                else
                {
                    order.Status = OrderStatus.Completed;
                }
                _khoaHocDbContext.Orders.Update(order);

            }
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result > 0)
                return Ok();
            return BadRequest(new ApiBadRequestResponse("Update status order failed"));
        }

        //[HttpPost]
        //[ValidationFilter]
        //public async Task<IActionResult> PostOrder(OrderCreateRequest request)
        //{
        //    var order = new Order()
        //    {
        //        Status = request.Status,
        //        UserId = request.UserId,
        //        Message = request.Message,
        //        PaymentMethod = request.PaymentMethod,
        //        Total = request.Total
        //    };
        //    await _khoaHocDbContext.Orders.AddAsync(order);
        //    var result = await _khoaHocDbContext.SaveChangesAsync();
        //    if (result > 0)
        //    {
        //        return Ok();
        //    }

        //    return BadRequest(new ApiBadRequestResponse("Create order failed"));
        //}

        //[HttpPut("{id}")]
        //[ValidationFilter]
        //public async Task<IActionResult> PutOrder(OrderCreateRequest request)
        //{
        //    var order = await _khoaHocDbContext.Orders.FindAsync(request.Id);
        //    if (order == null)
        //    {
        //        return BadRequest(new ApiBadRequestResponse($"Cannot found order with id: {request.Id}"));
        //    }

        //    order.Status = request.Status;
        //    order.Message = request.Message;
        //    order.PaymentMethod = request.PaymentMethod;
        //    order.UserId = request.UserId;
        //    _khoaHocDbContext.Orders.Update(order);
        //    var result = await _khoaHocDbContext.SaveChangesAsync();
        //    if (result > 0)
        //    {
        //        return NoContent();
        //    }

        //    return BadRequest(new ApiBadRequestResponse("Update order failed"));
        //}


        #endregion

        #region Order Detail

        [HttpGet("{orderId}/order-details/filter")]
        public async Task<IActionResult> GetOrderDetailsPaging(int orderId, string filter, int pageIndex, int pageSize)
        {
            var query = _khoaHocDbContext.OrderDetails.Include(x => x.ActivateCourse).Where(x => x.OrderId == orderId).AsNoTracking();
            if (!string.IsNullOrEmpty(filter))
            {
                query = query.Where(x => x.ActivateCourse.Course.Name.Contains(filter));
            }
            var items = new List<OrderDetailViewModel>();
            var totalRecords = await query.CountAsync();
            await query.Skip((pageIndex - 1) * pageSize).Take(pageSize).ForEachAsync(x =>
            {
                items.Add(new OrderDetailViewModel
                {
                   OrderId = x.OrderId,
                   Price = x.Price,
                   CourseName = x.ActivateCourse.Course.Name,
                   ActiveCourseId = x.ActiveCourseId,
                   PromotionPrice = x.PromotionPrice
                });
            });

            var pagination = new Pagination<OrderDetailViewModel>
            {
                Items = items,
                TotalRecords = totalRecords
            };
            return Ok(pagination);
        }

        [HttpGet("{orderId}/order-details/{activeCourseId}")]
        public IActionResult GetOrderDetails(int orderId, Guid activeCourseId)
        {
            var orderDetail = _khoaHocDbContext.OrderDetails.Include(x => x.ActivateCourse)
                .FirstOrDefault(x => x.ActiveCourseId == activeCourseId && x.OrderId == orderId);
            if (orderDetail == null)
            {
                return NotFound(new ApiNotFoundResponse($"Cannot found order detail with active courseId {activeCourseId} and orderId {orderId}"));
            }
            return Ok(new OrderDetailViewModel()
            {
                Price = orderDetail.Price,
                ActiveCourseId = orderDetail.ActiveCourseId,
                PromotionPrice = orderDetail.PromotionPrice,
                CourseName = orderDetail.ActivateCourse.Course.Name,
                OrderId = orderDetail.OrderId
            });
        }

        [HttpPost("{orderId}/order-details/delete-multi-items")]
        [ValidationFilter]
        public async Task<IActionResult> DeleteOrderDetail(int orderId, List<int> request)
        {
            foreach (var courseId in request)
            {
                var orderDetail = _khoaHocDbContext.OrderDetails.Include(x => x.ActivateCourse)
                    .FirstOrDefault(x => x.ActivateCourse.Course.Id == courseId && x.OrderId == orderId);
                if (orderDetail == null)
                {
                    return NotFound(new ApiNotFoundResponse($"Cannot found order detail with courseId {courseId} and orderId {orderId}"));
                }
                _khoaHocDbContext.OrderDetails.Remove(orderDetail);

            }
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result > 0)
                return Ok();
            return BadRequest(new ApiBadRequestResponse($"Delete order detail failed"));
        }

        [HttpPut("{orderId}/order-details/{activeCourseId}")]
        [ValidationFilter]
        public async Task<IActionResult> PutOrderDetail(OrderDetailCreateRequest request)
        {
            var orderDetail =  _khoaHocDbContext.OrderDetails.FirstOrDefault(x => x.ActiveCourseId == request.ActiveCourseId && x.OrderId == request.OrderId);
            if (orderDetail == null)
            {
                return BadRequest(new ApiBadRequestResponse($"Cannot found order detail with active courseId {request.ActiveCourseId} and orderId {request.OrderId}"));
            }
            orderDetail.ActiveCourseId = request.ActiveCourseId;
            orderDetail.OrderId = request.OrderId;
            orderDetail.Price = request.Price;
            orderDetail.PromotionPrice = request.PromotionPrice;
            _khoaHocDbContext.OrderDetails.Update(orderDetail);
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result > 0)
            {
                return NoContent();
            }

            return BadRequest(new ApiBadRequestResponse("Update order failed"));
        }






        //[HttpPost("{orderId}/order-details")]
        //[ValidationFilter]
        //public async Task<IActionResult> PostOrderDetail(OrderDetailCreateRequest request)
        //{
        //    var orderDetail = new OrderDetail()
        //    {
        //        ActiveCourseId = request.ActiveCourseId,
        //        Price = request.Price,
        //        OrderId = request.OrderId,
        //        PromotionPrice = request.PromotionPrice
        //    };
        //    await _khoaHocDbContext.OrderDetails.AddAsync(orderDetail);
        //    var result = await _khoaHocDbContext.SaveChangesAsync();
        //    if (result > 0)
        //    {
        //        return Ok();
        //    }

        //    return BadRequest(new ApiBadRequestResponse("Create order detail failed"));
        //}

        #endregion
    }
}
