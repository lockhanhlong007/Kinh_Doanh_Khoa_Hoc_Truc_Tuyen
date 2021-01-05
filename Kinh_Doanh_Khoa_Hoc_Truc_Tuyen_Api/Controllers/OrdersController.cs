
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
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
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
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
        private readonly IStorageService _storageService;
        private readonly UserManager<AppUser> _userManager;
        public OrdersController(IWebHostEnvironment webHostEnvironment,EKhoaHocDbContext khoaHocDbContext, ILogger<OrdersController> logger, IStorageService storageService, UserManager<AppUser> userManager, IWebHostEnvironment hostingEnvironment)
        {
            _khoaHocDbContext = khoaHocDbContext;
            _logger = logger;
            _storageService = storageService;
            _userManager = userManager;
            _hostingEnvironment = hostingEnvironment;
        }

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
                Name = x.Name ?? x.AppUser.Name,
                Email = x.Email ?? x.AppUser.Email,
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

        [HttpGet("account-{userId}-orders")]
        public async Task<IActionResult> GetOrdersForClientPaging(string userId,string sortBy, int pageIndex, int pageSize)
        {
            var lstOrderViewModels = new List<OrderViewModel>();
            var query = _khoaHocDbContext.Orders.Include(x => x.OrderDetails).AsNoTracking().Where(x => x.UserId == Guid.Parse(userId));
            query = sortBy switch
            {
                "15daysAgo" => query.Where(x => x.CreationTime.Date <= (DateTime.Now.Date.AddDays(-15))),
                "30daysAgo" => query.Where(x => x.CreationTime.Date <= (DateTime.Now.Date.AddDays(-30))),
                "6monthsAgo" => query.Where(x => x.CreationTime.Date <= (DateTime.Now.Date.AddMonths(-6))),
                "1yearAgo" => query.Where(x => x.CreationTime.Date <= (DateTime.Now.Date.AddYears(-1))),
                _ => query
            };
            var totalRecords = query.Count();
            query = query.OrderByDescending(x => x.CreationTime).Skip((pageIndex - 1) * pageSize).Take(pageSize);
            foreach (var item in query)
            {
                var user = await _userManager.FindByIdAsync(item.UserId.ToString());
                var lstOrderDetailViewModel = new List<OrderDetailViewModel>();
                foreach (var orderDetail in item.OrderDetails)
                {
                    var orderDetailViewModel = new OrderDetailViewModel();
                    var course = _khoaHocDbContext.ActivateCourses.Include(y => y.Course).FirstOrDefault(y => y.Id == orderDetail.ActiveCourseId)?.Course;
                    orderDetailViewModel.ActiveCourseId = orderDetail.ActiveCourseId;
                    orderDetailViewModel.Price = orderDetail.Price;
                    orderDetailViewModel.PromotionPrice = orderDetail.PromotionPrice;
                    orderDetailViewModel.OrderId = orderDetail.OrderId;
                    orderDetailViewModel.CourseName = course?.Name;
                    orderDetailViewModel.CourseImage = _storageService.GetFileUrl(course?.Image);
                    lstOrderDetailViewModel.Add(orderDetailViewModel);
                }
                var orderViewModel = new OrderViewModel();
                orderViewModel.Id = item.Id;
                orderViewModel.UserId = item.UserId;
                orderViewModel.CreationTime = item.CreationTime;
                orderViewModel.LastModificationTime = item.LastModificationTime;
                orderViewModel.Status = item.Status;
                orderViewModel.Message = item.Message;
                orderViewModel.Address = item.Address;
                orderViewModel.PhoneNumber = item.PhoneNumber ?? user.PhoneNumber;
                orderViewModel.Name = item.Name ?? item.AppUser.Name;
                orderViewModel.Email = item.Email ?? item.AppUser.Email;
                orderViewModel.PaymentMethod = item.PaymentMethod;
                orderViewModel.Total = item.Total;
                orderViewModel.ImageUser = _storageService.GetFileUrl(user.Avatar);
                orderViewModel.OrderDetails = lstOrderDetailViewModel;
                lstOrderViewModels.Add(orderViewModel);
            }

            var items = lstOrderViewModels;
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

        [HttpPut("status-type/client")]
        [ValidationFilter]
        public async Task<IActionResult> PutStatusForClientOrder(OrderStatusRequest request)
        {
            var order = await _khoaHocDbContext.Orders.FindAsync(request.OrderId);
            if (order == null)
            {
                return NotFound(new ApiNotFoundResponse($"Cannot found the order with id: {request.OrderId}"));
            }
            if (request.StatusType == 1)
            {
                order.Status = OrderStatus.InProgress;
            }
            else if (request.StatusType == 2)
            {
                order.Status = OrderStatus.Returned;
            }
            else if (request.StatusType == 3)
            {
                order.Status = OrderStatus.Cancelled;
            }
            else
            {
                order.Status = OrderStatus.Completed;
            }
            _khoaHocDbContext.Orders.Update(order);
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result > 0)
                return Ok();
            return BadRequest(new ApiBadRequestResponse("Update status order failed"));
        }
        [HttpPost("export-excel")]
        public IActionResult PostExportOrder(OrderViewModel order)
        {
            try
            {
                var webRootFolder = _hostingEnvironment.WebRootPath;
                var resultFile = $"Bill_{order.Name.convertToUnSign()}_{DateTime.Now:dd-MM-yyyy}_{order.UserId ?? Guid.NewGuid()}.xlsx";
                var resultFilePdf = $"Bill_{order.Name.convertToUnSign()}_{DateTime.Now:dd-MM-yyyy}_{order.UserId ?? Guid.NewGuid()}.pdf";
                var date = DateTime.UtcNow.Date;
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
                    worksheet.Cells[5, 3].Value = order.Name;
                    worksheet.Cells[6, 3].Value = order.Email;
                    worksheet.Cells[7, 3].Value = order.PhoneNumber;
                    worksheet.Cells[8, 3].Value = order.Address;
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
                            $"Ngày {date.Day} tháng {date.Month} năm {date.Year}";
                    }
                    else
                    {
                        worksheet.Cells[23, 4].Value = $"{order.Total:0,0 VNĐ}";
                        var thanhTien = order.Total.ToString();
                        worksheet.Cells[24, 3].Value = double.Parse(thanhTien ?? "0").ChuyenSoSangChuoi();
                        worksheet.Cells[24, 3].Style.Font.Bold = true;
                        worksheet.Cells[26, 3].Value =
                            $"Ngày {date.Day} tháng {date.Month} năm {date.Year}";
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
                Name = order.Name ?? user?.Name + "(" + user?.Email + ")",
                PaymentMethod = order.PaymentMethod,
                Total = order.Total,
                OrderDetails = orderDetailViewModel
            };
            return Ok(orderViewModel);
        }

        [HttpGet("{id}/user-{userId}")]
        public async Task<IActionResult> GetDetailByUserId(int id,string userId)
        {
            var order = _khoaHocDbContext.Orders.Include(x => x.OrderDetails).FirstOrDefault(x => x.Id == id && x.UserId == Guid.Parse(userId));
            if (order == null)
            {
                return NotFound(new ApiNotFoundResponse($"Cannot found order with id: {id}"));
            }
            var user = await _userManager.FindByIdAsync(order.UserId.ToString());
            var lstOrderDetailViewModel = new List<OrderDetailViewModel>();
            foreach (var orderDetail in order.OrderDetails)
            {
                var orderDetailViewModel = new OrderDetailViewModel();
                var course = _khoaHocDbContext.ActivateCourses.Include(y => y.Course).FirstOrDefault(y => y.Id == orderDetail.ActiveCourseId)?.Course;
                orderDetailViewModel.ActiveCourseId = orderDetail.ActiveCourseId;
                orderDetailViewModel.Price = orderDetail.Price;
                orderDetailViewModel.PromotionPrice = orderDetail.PromotionPrice;
                orderDetailViewModel.OrderId = orderDetail.OrderId;
                orderDetailViewModel.CourseName = course?.Name;
                orderDetailViewModel.CourseImage = _storageService.GetFileUrl(course?.Image);
                lstOrderDetailViewModel.Add(orderDetailViewModel);
            }
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
                Name = order.Name ?? user?.Name + "(" + user?.Email + ")",
                PaymentMethod = order.PaymentMethod,
                Total = order.Total,
                OrderDetails = lstOrderDetailViewModel
            };
            return Ok(orderViewModel);
        }

        [HttpGet("check-{id}/user-{userId}")]
        public IActionResult GetCheckDetailByUserId(int id, string userId)
        {
            var order = _khoaHocDbContext.Orders.FirstOrDefault(x => x.Id == id && x.UserId == Guid.Parse(userId));
            if (order == null)
            {
                return NotFound(new ApiNotFoundResponse($"Cannot found order with id: {id}"));
            }
            return Ok(order);
        }

        [HttpGet("user-{id}")]
        public async Task<IActionResult> GetOrders(string id)
        {
            var data = _khoaHocDbContext.Orders.Where(x => x.UserId == Guid.Parse(id));
            if (!data.Any())
            {
                return Ok(new List<OrderDetailViewModel>());
            }

            var orderViewModel = await data.Select(x => new OrderViewModel
            {
                Status = x.Status,
                Message = x.Message,
                LastModificationTime = x.LastModificationTime,
                CreationTime = x.CreationTime,
                UserId = x.UserId,
                Total = x.Total,
                PaymentMethod = x.PaymentMethod,
                Address = x.Address,
                PhoneNumber = x.PhoneNumber,
                Name = x.Name,
                Email = x.Email,
                Id = x.Id,
            }).ToListAsync();
            return Ok(orderViewModel);
        }

        [HttpPut("{orderId}/order-details/{activeCourseId}")]
        [ValidationFilter]
        public async Task<IActionResult> PutOrderDetail(OrderDetailCreateRequest request)
        {
            var orderDetail = _khoaHocDbContext.OrderDetails.FirstOrDefault(x => x.ActiveCourseId == request.ActiveCourseId && x.OrderId == request.OrderId);
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

        [HttpPost("create")]
        public async Task<IActionResult> PostOrder(OrderCreateRequest request)
        {
            var order = new Order();
            order.Status = request.Status;
            order.Message = request.Message;
            order.Name = request.Name;
            order.Address = request.Address;
            order.Email = request.Email;
            order.PaymentMethod = request.PaymentMethod;
            order.PhoneNumber = request.PhoneNumber;
            order.UserId = request.UserId;
            order.Total = request.OrderDetails.Sum(x => x.PromotionPrice ?? x.Price);
            await _khoaHocDbContext.Orders.AddAsync(order);
            await _khoaHocDbContext.SaveChangesAsync();
            var lstOrderDetails = new List<OrderDetail>();
            foreach (var orderDetailCreateRequest in request.OrderDetails)
            {
                var detail = new OrderDetail();
                detail.Price = orderDetailCreateRequest.Price;
                detail.PromotionPrice = orderDetailCreateRequest.PromotionPrice;
                detail.ActiveCourseId = orderDetailCreateRequest.ActiveCourseId;
                detail.OrderId = order.Id;
                orderDetailCreateRequest.OrderId = order.Id;
                lstOrderDetails.Add(detail);
            }

            await _khoaHocDbContext.OrderDetails.AddRangeAsync(lstOrderDetails);
            var result = await _khoaHocDbContext.SaveChangesAsync();
            var orderViewModel = new OrderViewModel();
            orderViewModel.Id = order.Id;
            orderViewModel.CreationTime = orderViewModel.CreationTime;
            orderViewModel.Status = order.Status;
            orderViewModel.Message = order.Message;
            orderViewModel.Name = order.Name;
            orderViewModel.Address = order.Address;
            orderViewModel.Email = order.Email;
            orderViewModel.PaymentMethod = order.PaymentMethod;
            orderViewModel.PhoneNumber = order.PhoneNumber;
            orderViewModel.UserId = order.UserId;
            orderViewModel.Total = order.OrderDetails.Sum(x => x.PromotionPrice ?? x.Price);
            foreach (var detailViewModel in request.OrderDetails)
            {
                orderViewModel.OrderDetails.Add(new OrderDetailViewModel
                {
                    ActiveCourseId = detailViewModel.ActiveCourseId,
                    Price = detailViewModel.Price,
                    PromotionPrice = detailViewModel.PromotionPrice,
                    OrderId = detailViewModel.OrderId,
                    CourseName = detailViewModel.CourseName
                });
            }
            if (result > 0)
            {
                return Ok(orderViewModel);
            }

            return BadRequest(new ApiBadRequestResponse("Create order failed"));
        }

    }
}
