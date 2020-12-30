using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.Common;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Products;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Extensions;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Models;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Services.Implements;
using Microsoft.AspNetCore.Identity.UI.Services;
using Microsoft.Extensions.Configuration;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Controllers
{
    public class CartController : Controller
    {
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly IBaseApiClient _apiClient;
        private readonly IConfiguration _configuration;
        private readonly IEmailSender _emailSender;

        public CartController(IHttpClientFactory httpClientFactory, IConfiguration configuration, IBaseApiClient apiClient, IEmailSender emailSender)
        {
            _httpClientFactory = httpClientFactory;
            _configuration = configuration;
            _apiClient = apiClient;
            _emailSender = emailSender;
        }

        [HttpGet]
        [Route("cart.html")]
        public IActionResult Index()
        {
            return View();
        }

        [HttpGet]
        [Route("checkout.html")]
        public IActionResult Checkout()
        {
            return View();
        }

        ///// <summary>
        ///// Checkouts the specified model.
        ///// </summary>
        ///// <param name="model">The model.</param>
        ///// <returns></returns>
        //[Route("checkout.html")]
        //[ValidateAntiForgeryToken]
        //[HttpPost]
        //public async Task<IActionResult> Checkout(CheckoutViewModel model)
        //{
        //    var session = HttpContext.Session.Get<List<CartViewModel>>(SystemConstants.CartSession);
        //    if (ModelState.IsValid)
        //    {
        //        if (session != null)
        //        {
        //            //var details = session.Select(item => new OrderDetailViewModel()
        //            //{
        //            //    Product = item.Product,
        //            //    Price = item.Price,
        //            //    ActiveCourseId = item.Product.Id
        //            //})
        //            //    .ToList();
        //            //var billViewModel = new BillViewModel()
        //            //{
        //            //    CustomerMobile = model.CustomerMobile,
        //            //    BillStatus = BillStatus.New,
        //            //    CustomerAddress = model.CustomerAddress,
        //            //    CustomerName = model.CustomerName,
        //            //    CustomerMessage = model.CustomerMessage,
        //            //    DateCreated = DateTime.Now,
        //            //    Status = Status.Active,
        //            //    BillDetails = details
        //            //};
        //            //if (User.Identity.IsAuthenticated)
        //            //{
        //            //    billViewModel.CustomerId = new Guid(User.GetSpecificClaim("Id"));
        //            //}
        //            //try
        //            //{
        //            //    _billService.Create(billViewModel);
        //            //    _billService.Save();
        //            //    ViewData["Success"] = true;
        //            //    var content = await _viewRenderService.RenderToStringAsync("ShopCart/BillMail", billViewModel);
        //            //    //Send mail
        //            //    await _emailSender.SendEmailAsync(_configuration["MailSettings:AdminMail"], "Đơn Hàng Mới Đến Từ Website Quản Lý Vật Liệu Xây Dựng", content);

        //            //    HttpContext.Session.Remove(CommonConstants.CartSession);
        //            //}
        //            //catch (Exception ex)
        //            //{
        //            //    ViewData["Success"] = false;
        //            //    ModelState.AddModelError("", ex.Message);
        //            //}
        //        }
        //    }
        //    model.Carts = session;
        //    return View(model);
        //}




        /// <summary>
        /// Lấy Danh Sách Sản Phẩm Trong Giỏ Hàng
        /// </summary>
        /// <returns>Status 200 - List Product</returns>

        public IActionResult GetCart()
        {
            // Nếu session sẽ lấy dữ liệu ra trước nếu dữ liệu ko lấy ra dc (session == null) thì sẽ tạo mới
            var session = HttpContext.Session.Get<List<CartViewModel>>(SystemConstants.CartSession) ?? new List<CartViewModel>();
            return new OkObjectResult(session);
        }

        /// <summary>
        /// Xóa Sản Phẩm Trong Giỏ Hảng
        /// </summary>
        /// <param name="courseId"></param>
        /// <returns></returns>
        [HttpPost]
        public IActionResult RemoveFromCart(int courseId)
        {
            var session = HttpContext.Session.Get<List<CartViewModel>>(SystemConstants.CartSession);
            if (session == null) 
                return new EmptyResult();
            if (session.Any(item => item.CourseViewModel.Id == courseId))
            {
                var cartViewModel = session.FirstOrDefault(item => item.CourseViewModel.Id == courseId);
                session.Remove(cartViewModel);
                HttpContext.Session.Set(SystemConstants.CartSession, session);
            }
            return new OkObjectResult(courseId);
        }

        /// <summary>
        /// Thêm Sản Phẩm Vào Giỏ Hàng
        /// </summary>
        /// <param name="courseId"></param>
        /// <returns></returns>
        [HttpPost]
        public async Task<IActionResult> AddToCart(int courseId)
        {
            var course = await _apiClient.GetAsync<CourseViewModel>($"/api/courses/{courseId}");
            var cartViewModel = new CartViewModel();
            var session = HttpContext.Session.Get<List<CartViewModel>>(SystemConstants.CartSession);
            if (session != null)
            {
                if (session.All(x => x.CourseViewModel.Id != courseId))
                {
                    long? promotion = null;
                    if (course.DiscountAmount > 0)
                    {
                        promotion = course.DiscountAmount;
                    }
                    else if (course.DiscountPercent > 0)
                    {
                        promotion = course.Price - (course.Price * course.DiscountPercent.Value / 100);
                    }
                    cartViewModel.CourseViewModel = course;
                    cartViewModel.Price = course.Price;
                    cartViewModel.PromotionPrice = promotion;
                    session.Add(cartViewModel);
                    //Update back to cart
                    HttpContext.Session.Set(SystemConstants.CartSession, session);
                }
                else
                {
                    return BadRequest();
                }
            }
            else
            {
                // Thêm Mới Sản Phẩm Vào Giỏ Hàng
                var lstCart = new List<CartViewModel>();
                long? promotion = null;
                if (course.DiscountAmount > 0)
                {
                    promotion = course.DiscountAmount;
                }
                else if (course.DiscountPercent > 0)
                {
                    promotion = course.Price - (course.Price * course.DiscountPercent.Value / 100);
                }
                cartViewModel.CourseViewModel = course;
                cartViewModel.Price = course.Price;
                cartViewModel.PromotionPrice = promotion;
                lstCart.Add(cartViewModel);
                HttpContext.Session.Set(SystemConstants.CartSession, lstCart);
            }
            return new OkObjectResult(cartViewModel);
        }

        /// <summary>
        /// Xoa Danh Sach San Pham Trong Gio Hang
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public IActionResult ClearCart()
        {
            HttpContext.Session.Remove(SystemConstants.CartSession);
            return new OkResult();
        }
    }
}
