using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Extensions;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Filter;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Helpers;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Services;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.EF;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Entities;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Enums;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Products;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration.EnvironmentVariables;
using Microsoft.Extensions.Logging;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using Spire.Xls;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrdersController : ControllerBase
    {
        private readonly IWebHostEnvironment _hostingEnvironment;
        private readonly EKhoaHocDbContext _khoaHocDbContext;
        private ILogger<OrdersController> _logger;
        private readonly UserManager<AppUser> _userManager;
        public OrdersController(IWebHostEnvironment webHostEnvironment,EKhoaHocDbContext khoaHocDbContext, ILogger<OrdersController> logger, IStorageService storageService, UserManager<AppUser> userManager, IWebHostEnvironment hostingEnvironment)
        {
            _khoaHocDbContext = khoaHocDbContext;
            _logger = logger;
            _userManager = userManager;
            _hostingEnvironment = hostingEnvironment;
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
            var totalRecords = await query.CountAsync();
            var items = await query.Skip((pageIndex - 1) * pageSize).Take(pageSize).Select(x => new OrderViewModel
            {
                Id = x.Id,
                UserId = x.UserId,
                CreationTime = x.CreationTime,
                LastModificationTime = x.LastModificationTime,
                Status = x.Status,
                Message = x.Message,
                Address = x.Address,
                PhoneNumber = x.PhoneNumber ?? x.AppUser.PhoneNumber,
                CreatedUser = x.AppUser.Name + "(" + x.AppUser.Email + ")",
                PaymentMethod = x.PaymentMethod,
                Total = x.Total
            }).ToListAsync();

            var pagination = new Pagination<OrderViewModel>
            {
                Items = items,
                TotalRecords = totalRecords,
                PageSize = pageSize,
                PageIndex = pageIndex
            };
            return Ok(pagination);
        }

        [HttpPut("status-type-{statusType}/multi-items")]
        [ValidationFilter]
        public async Task<IActionResult> PutStatusOrder(int statusType, List<int> request)
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




        [HttpPost("export-excel")]
        public async Task<IActionResult> PostExportOrder(OrderViewModel order)
        {
            try
            {
                var webRootFolder = _hostingEnvironment.WebRootPath;
                var user = await _userManager.FindByIdAsync(order.UserId.ToString());
                var resultFile = $"Bill_{user.Name}_{DateTime.Now:dd-MM-yyyy}_{order.UserId}.xlsx";
                var resultFilePdf = $"Bill_{user.Name}_{DateTime.Now:dd-MM-yyyy}_{order.UserId}.pdf";
                var templateDocument = Path.Combine(webRootFolder, "attachments\\form", "Hoa_Don_Ban_Hang_Le.xlsx");
                var templateResultDocument = Path.Combine(webRootFolder, "attachments\\export-files", resultFile);
                var templatePdfResultDocument = Path.Combine(webRootFolder, "attachments\\export-files", resultFilePdf);
                FileInfo file = new FileInfo(templateResultDocument);

                if (file.Exists)
                {
                    file.Delete();
                    file = new FileInfo(templateResultDocument);
                }
                FileInfo filePdf = new FileInfo(templatePdfResultDocument);
                if (filePdf.Exists)
                {
                    filePdf.Delete();
                }
                ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
                FileStream templateDocumentStream = new FileStream(templateDocument, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
                using (ExcelPackage package = new ExcelPackage(templateDocumentStream))
                {
                    var worksheet = package.Workbook.Worksheets.FirstOrDefault();
                    if (worksheet == null)
                    {
                        throw new Exception("Không kết nối được với file");
                    }
                    worksheet.Cells[4, 3].Value = User.GetFullName();
                    worksheet.Cells[5, 3].Value = user.Name;
                    worksheet.Cells[6, 3].Value = order.Address;
                    worksheet.Cells[7, 3].Value = user.Email;
                    worksheet.Cells[8, 3].Value = order.PhoneNumber ?? user.PhoneNumber;
                    var stt = 1;
                    var index = 11;
                    foreach (var detail in order.OrderDetails)
                    {
                        if (index == 21)
                        {
                            worksheet.InsertRow(index, order.OrderDetails.Count - stt);
                        }

                        // Fill Data
                        worksheet.Cells[index, 1].Value = stt;
                        worksheet.Cells[index, 2].Value = detail.CourseName;
                        worksheet.Cells[index, 3].Value = detail.ActiveCourseId;
                        worksheet.Cells[index, 4].Value = $"{detail.PromotionPrice ?? detail.Price:0,0 VNĐ}";

                        // Bottom
                        worksheet.Cells[index, 1].Style.Border.Bottom.Style = ExcelBorderStyle.Medium;
                        worksheet.Cells[index, 2].Style.Border.Bottom.Style = ExcelBorderStyle.Medium;
                        worksheet.Cells[index, 3].Style.Border.Bottom.Style = ExcelBorderStyle.Medium;
                        worksheet.Cells[index, 4].Style.Border.Bottom.Style = ExcelBorderStyle.Medium;

                        // Top
                        worksheet.Cells[index, 1].Style.Border.Top.Style = ExcelBorderStyle.Medium;
                        worksheet.Cells[index, 2].Style.Border.Top.Style = ExcelBorderStyle.Medium;
                        worksheet.Cells[index, 3].Style.Border.Top.Style = ExcelBorderStyle.Medium;
                        worksheet.Cells[index, 4].Style.Border.Top.Style = ExcelBorderStyle.Medium;

                        //Right
                        worksheet.Cells[index, 1].Style.Border.Right.Style = ExcelBorderStyle.Medium;
                        worksheet.Cells[index, 2].Style.Border.Right.Style = ExcelBorderStyle.Medium;
                        worksheet.Cells[index, 3].Style.Border.Right.Style = ExcelBorderStyle.Medium;
                        worksheet.Cells[index, 4].Style.Border.Right.Style = ExcelBorderStyle.Medium;

                        // Left
                        worksheet.Cells[index, 1].Style.Border.Left.Style = ExcelBorderStyle.Medium;
                        worksheet.Cells[index, 2].Style.Border.Left.Style = ExcelBorderStyle.Medium;
                        worksheet.Cells[index, 3].Style.Border.Left.Style = ExcelBorderStyle.Medium;
                        worksheet.Cells[index, 4].Style.Border.Left.Style = ExcelBorderStyle.Medium;

                        // Horizontal Alignment
                        worksheet.Cells[index, 1].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                        worksheet.Cells[index, 2].Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                        worksheet.Cells[index, 3].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                        worksheet.Cells[index, 4].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;


                        // Vertical Alignment
                        worksheet.Cells[index, 1].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                        worksheet.Cells[index, 2].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                        worksheet.Cells[index, 3].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                        worksheet.Cells[index, 4].Style.VerticalAlignment = ExcelVerticalAlignment.Center;

                        // Font Bold
                        worksheet.Cells[index, 1].Style.Font.Bold = true;
                        worksheet.Cells[index, 2].Style.Font.Bold = true;
                        worksheet.Cells[index, 3].Style.Font.Bold = true;
                        worksheet.Cells[index, 4].Style.Font.Bold = true;

                        // Update Index
                        index++;
                        stt++;
                    }

                    if (index > 21)
                    {
                        worksheet.Cells[index + 1, 4].Value = $"{order.Total:0,0 VNĐ}";
                        var thanhTien = order.Total.ToString();
                        worksheet.Cells[index + 2, 3].Value = double.Parse(thanhTien ?? "0").ChuyenSoSangChuoi();
                        worksheet.Cells[index + 2, 3].Style.Font.Bold = true;
                        worksheet.Cells[index + 4, 3].Value =
                            $"Ngày {order.CreationTime.Day} tháng {order.CreationTime.Month} năm {order.CreationTime.Year}";
                    }
                    else
                    {
                        worksheet.Cells[23, 4].Value = $"{order.Total:0,0 VNĐ}";
                        var thanhTien = order.Total.ToString();
                        worksheet.Cells[24, 3].Value = double.Parse(thanhTien ?? "0").ChuyenSoSangChuoi();
                        worksheet.Cells[24, 3].Style.Font.Bold = true;
                        worksheet.Cells[26, 3].Value =
                            $"Ngày {order.CreationTime.Day} tháng {order.CreationTime.Month} năm {order.CreationTime.Year}";
                    }

                    package.SaveAs(file);
                    Workbook workbook = new Workbook();
                    //Load excel file  
                    workbook.LoadFromFile(templateResultDocument);
                    //Save excel file to pdf file.  
                    workbook.SaveToFile(templatePdfResultDocument, FileFormat.PDF);
                }
                return Ok(new ApiResponse(200, resultFile));
            }
            catch (Exception e)
            {
                
                return BadRequest(e.Message);
            }
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetDetail(int id)
        {
            var order = _khoaHocDbContext.Orders.Include(x => x.OrderDetails).FirstOrDefault(x => x.Id == id);
            if (order == null)
            {
                return NotFound(new ApiNotFoundResponse($"Cannot found order with id: {id}"));
            }
            var user = await _userManager.FindByIdAsync(order.UserId.ToString());
            var orderDetailViewModel = order.OrderDetails?.Select(x => new OrderDetailViewModel()
            {
                ActiveCourseId = x.ActiveCourseId,
                Price = x.Price,
                PromotionPrice = x.PromotionPrice,
                OrderId = x.OrderId,
                CourseName = _khoaHocDbContext.ActivateCourses.Include(y => y.Course).FirstOrDefault(y => y.Id == x.ActiveCourseId)?.Course.Name
            }).ToList();

            var orderViewModel = new OrderViewModel
            {
                Id = order.Id,
                Address = order.Address,
                PhoneNumber = order.PhoneNumber ?? user.PhoneNumber,
                UserId = order.UserId,
                CreationTime = order.CreationTime,
                LastModificationTime = order.LastModificationTime,
                Status = order.Status,
                Message = order.Message,
                CreatedUser = user?.Name + "(" + user?.Email + ")",
                PaymentMethod = order.PaymentMethod,
                Total = order.Total,
                OrderDetails = orderDetailViewModel
            };
            return Ok(orderViewModel);
        }

        //[HttpPost]
        //[ValidationFilter]
        //public async Task<IActionResult> PostOrder(OrderCreateRequest request)
        //{
        //var order = new Order()
        //{
        //    Status = request.Status,
        //    UserId = request.UserId,
        //    Message = request.Message,
        //    PaymentMethod = request.PaymentMethod,
        //    Total = request.Total
        //};
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

        //[HttpGet("{orderId}/order-details/filter")]
        //public async Task<IActionResult> GetOrderDetailsPaging(int orderId, string filter, int pageIndex, int pageSize)
        //{
        //    var query = _khoaHocDbContext.OrderDetails.Include(x => x.ActivateCourse).Where(x => x.OrderId == orderId).AsNoTracking();
        //    if (!string.IsNullOrEmpty(filter))
        //    {
        //        query = query.Where(x => x.ActivateCourse.Course.Name.Contains(filter));
        //    }
        //    var totalRecords = await query.CountAsync();
        //    var items = await query.Skip((pageIndex - 1) * pageSize).Take(pageSize).Select(x => new OrderDetailViewModel
        //    {
        //        OrderId = x.OrderId,
        //        Price = x.Price,
        //        CourseName = x.ActivateCourse.Course.Name,
        //        ActiveCourseId = x.ActiveCourseId,
        //        PromotionPrice = x.PromotionPrice
        //    }).ToListAsync();

        //    var pagination = new Pagination<OrderDetailViewModel>
        //    {
        //        Items = items,
        //        TotalRecords = totalRecords,
        //        PageSize = pageSize,
        //        PageIndex = pageIndex
        //    };
        //    return Ok(pagination);
        //}

        //[HttpGet("{orderId}/order-details/{activeCourseId}")]
        //public IActionResult GetOrderDetails(int orderId, string activeCourseId)
        //{
        //    var orderDetail = _khoaHocDbContext.OrderDetails.Include(x => x.ActivateCourse)
        //        .FirstOrDefault(x => x.ActiveCourseId == Guid.Parse(activeCourseId) && x.OrderId == orderId);
        //    if (orderDetail == null)
        //    {
        //        return NotFound(new ApiNotFoundResponse($"Cannot found order detail with active courseId {activeCourseId} and orderId {orderId}"));
        //    }
        //    return Ok(new OrderDetailViewModel()
        //    {
        //        Price = orderDetail.Price,
        //        ActiveCourseId = orderDetail.ActiveCourseId,
        //        PromotionPrice = orderDetail.PromotionPrice,
        //        CourseName = orderDetail.ActivateCourse.Course.Name,
        //        OrderId = orderDetail.OrderId
        //    });
        //}

        //[HttpPost("{orderId}/order-details/delete-multi-items")]
        //[ValidationFilter]
        //public async Task<IActionResult> DeleteOrderDetail(int orderId, List<string> request)
        //{
        //    foreach (var activeCourseId in request)
        //    {
        //        var orderDetail = _khoaHocDbContext.OrderDetails.Include(x => x.ActivateCourse)
        //            .FirstOrDefault(x => x.ActiveCourseId == Guid.Parse(activeCourseId) && x.OrderId == orderId);
        //        if (orderDetail == null)
        //        {
        //            return NotFound(new ApiNotFoundResponse($"Cannot found order detail with activeCourseId {activeCourseId} and orderId {orderId}"));
        //        }

        //        var order = await _khoaHocDbContext.Orders.FindAsync(orderDetail);
        //        order.Total = order.Total - orderDetail.PromotionPrice ?? orderDetail.Price;
        //        _khoaHocDbContext.Orders.Update(order);
        //        _khoaHocDbContext.OrderDetails.Remove(orderDetail);

        //    }
        //    var result = await _khoaHocDbContext.SaveChangesAsync();
        //    if (result > 0)
        //        return Ok();
        //    return BadRequest(new ApiBadRequestResponse($"Delete order detail failed"));
        //}

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
            await _khoaHocDbContext.SaveChangesAsync();
            var order = _khoaHocDbContext.Orders.Include(x => x.OrderDetails).FirstOrDefault(x => x.Id == request.OrderId);
            if (order == null)
            {
                return BadRequest(new ApiBadRequestResponse("Update order failed"));
            }
            order!.Total = 0;
            var lstOrderDetail = order!.OrderDetails;
            lstOrderDetail.ForEach(x => order.Total += x.PromotionPrice ?? x.Price);
            _khoaHocDbContext.Orders.Update(order);
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
