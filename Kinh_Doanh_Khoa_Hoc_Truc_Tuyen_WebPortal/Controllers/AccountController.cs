using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using IdentityModel.Client;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Entities;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.Common;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Systems;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Extensions;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Helpers;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Models;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Services.Implements;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.UI.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Logging;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;
using PaulMiami.AspNetCore.Mvc.Recaptcha;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Controllers
{
    public class AccountController : Controller
    {
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly IBaseApiClient _apiClient;
        private readonly IConfiguration _configuration;


        private readonly IEmailSender _emailSender;

        public AccountController(IBaseApiClient apiClient,
            IConfiguration configuration, IHttpClientFactory httpClientFactory, IEmailSender emailSender)
        {
            _apiClient = apiClient;
            _configuration = configuration;
            _httpClientFactory = httpClientFactory;
            _emailSender = emailSender;
        }

        [HttpGet]
        [AllowAnonymous]
        [Route("login.html")]
        public async Task<IActionResult> Login(string returnUrl = null)
        {
            // Clear the existing external cookie to ensure a clean login process
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);

            ViewData["ReturnUrl"] = returnUrl;
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [Route("login.html")]
        public async Task<IActionResult> Login(LoginRequest request, string returnUrl = null)
        {
            try
            {
                ViewData["ReturnUrl"] = returnUrl;
                if (!ModelState.IsValid)
                    return View(request);
                var loginViewModel = new LoginViewModel()
                {
                    ClientId = _configuration["Authorization:ClientId"],
                    ClientSecret = _configuration["Authorization:ClientSecret"],
                    Scope = _configuration["Authorization:Scope"],
                    Password = request.Password,
                    UserName = request.UserName
                };
                var result = await _apiClient.PostAsync<LoginViewModel, TokenResponseFromServer>($"/api/TokenAuth/Authenticate", loginViewModel,false);
                var principal = ValidateToken(result);
                //if (!principal.IsInRole("Teacher"))
                //{
                //    ModelState.AddModelError("", "Không Thể Đăng Nhập Tài Khoản Này");
                //    return View();
                //}
                var authProperties = new AuthenticationProperties();
                if (request.RememberMe)
                {
                    authProperties.ExpiresUtc = DateTimeOffset.UtcNow.AddDays(1);
                    authProperties.IsPersistent = true;
                }
                else
                {
                    authProperties.ExpiresUtc = DateTimeOffset.UtcNow.AddMinutes(10);
                    authProperties.IsPersistent = false;
                }
                HttpContext.Session.SetString("access_token", result.AccessToken);
                await HttpContext.SignInAsync(
                    CookieAuthenticationDefaults.AuthenticationScheme,
                    principal,
                    authProperties);
                return RedirectToLocal(returnUrl);
            }
            catch (Exception)
            {
                ModelState.AddModelError("", "Tài Khoản Hoặc Mật Khẩu Không Đúng");
                return View();
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync(
                        CookieAuthenticationDefaults.AuthenticationScheme);
            return RedirectToAction(nameof(HomeController.Index), "Home");
        }

        [HttpGet]
        [AllowAnonymous]
        [Route("register.html")]
        public IActionResult Register(string returnUrl = null)
        {
            ViewData["ReturnUrl"] = returnUrl;
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
      //  [ValidateRecaptcha]
        [Route("register.html")]
        public async Task<IActionResult> Register(RegisterRequest registerRequest, string returnUrl = null)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return View(registerRequest);
                }
                var requestContent = new MultipartFormDataContent();
                if (registerRequest.Avatar != null)
                {
                    byte[] data;
                    using (var br = new BinaryReader(registerRequest.Avatar.OpenReadStream()))
                    {
                        data = br.ReadBytes((int)registerRequest.Avatar.OpenReadStream().Length);
                    }
                    ByteArrayContent bytes = new ByteArrayContent(data);
                    requestContent.Add(bytes, "Avatar", registerRequest.Avatar.FileName);
                }
                requestContent.Add(new StringContent(registerRequest.UserName), "UserName");
                requestContent.Add(new StringContent(registerRequest.Password), "Password");
                requestContent.Add(new StringContent(registerRequest.Email), "Email");
                requestContent.Add(new StringContent(registerRequest.PhoneNumber), "PhoneNumber");
                requestContent.Add(new StringContent(registerRequest.Name), "Name");
                requestContent.Add(new StringContent(registerRequest.Dob.ToString("yyyy/MM/dd")), "Dob");
                await _apiClient.PostForFileAsync<bool>("/api/users",requestContent,false);
                //var loginViewModel = new LoginViewModel()
                //{
                //    ClientId = _configuration["Authorization:ClientId"],
                //    ClientSecret = _configuration["Authorization:ClientSecret"],
                //    Scope = _configuration["Authorization:Scope"],
                //    Password = registerRequest.Password,
                //    UserName = registerRequest.UserName
                //};
                //var result = await _apiClient.PostAsync<LoginViewModel, TokenResponseFromServer>($"/api/TokenAuth/Authenticate", loginViewModel, false);
                //var principal = ValidateToken(result);
                //var authProperties = new AuthenticationProperties
                //{
                //    ExpiresUtc = DateTimeOffset.UtcNow.AddMinutes(10),
                //    IsPersistent = false
                //};
                //HttpContext.Session.SetString("access_token", result.AccessToken);
                //await HttpContext.SignInAsync(
                //    CookieAuthenticationDefaults.AuthenticationScheme,
                //    principal,
                //    authProperties);
                var user = await _apiClient.GetAsync<UserViewModel>($"/api/users/user-{registerRequest.UserName}");
                var code = await _apiClient.GetStringAsync($"/api/users/email-token-user-{user.Id.ToString()}");
                var callbackUrl = Url.EmailConfirmationLink(user.Id, code, Request.Scheme);
                await _emailSender.SendEmailConfirmationAsync(registerRequest.Email, callbackUrl);
                return RedirectToAction("Index", "Home");
            }
            catch (Exception e)
            {
                var check = JsonConvert.DeserializeObject<ApiBadRequestResponse>(e.Message);
                if (check.Errors.Any())
                {
                    foreach (var checkError in check.Errors)
                    {
                        ModelState.AddModelError("", checkError);
                    }
                }
                else
                {
                    ModelState.AddModelError("", "Đăng ký thất bại");
                }
            
                return View();
            }
        }
          [HttpGet]
          public IActionResult AccessDenied()
          {
              return View();
          }

        [HttpGet]
        [AllowAnonymous]
        public async Task<IActionResult> ConfirmEmail(string userId, string code)
        {
            if (userId == null || code == null)
            {
                return RedirectToAction(nameof(HomeController.Index), "Home");
            }
            var user = await _apiClient.GetAsync<UserViewModel>($"/api/users/{userId}");
            if (user == null)
            {
                throw new ApplicationException($"Unable to load user with ID '{userId}'.");
            }

            var result = await _apiClient.PostReturnBooleanAsync<ConfirmEmailRequest>($"/api/users/confirm-email",new ConfirmEmailRequest
            {
                Code = code,
                UserId = userId
            },false);
            return View(result ? "ConfirmEmail" : "Error");
        }

        [HttpGet]
        [AllowAnonymous]
        [Route("reset-password.html")]
        public IActionResult ForgotPassword()
        {
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [Route("reset-password.html")]
        public async Task<IActionResult> ForgotPassword(ForgotPasswordViewModel model)
        {
            //if (ModelState.IsValid)
            //{
            //    var user = await _userManager.FindByEmailAsync(model.Email);
            //    if (user == null || !(await _userManager.IsEmailConfirmedAsync(user)))
            //    {
            //        // Don't reveal that the user does not exist or is not confirmed
            //        return RedirectToAction(nameof(ForgotPasswordConfirmation));
            //    }

            //    // For more information on how to enable account confirmation and password reset please
            //    // visit https://go.microsoft.com/fwlink/?LinkID=532713
            //    var token = await _userManager.GeneratePasswordResetTokenAsync(user);
            //    var callbackUrl = Url.ResetPasswordCallbackLink(user.Id, token, Request.Scheme);
            //    await _emailSender.SendEmailAsync(model.Email, "Reset Password",
            //       $"Please reset your password by clicking here: <a href='{callbackUrl}'>link</a>");
            //    return RedirectToAction(nameof(ForgotPasswordConfirmation));
            //}

            ////If we got this far, something failed, redisplay form
            return View(model);
        }

        [HttpGet]
        [AllowAnonymous]
        public IActionResult ForgotPasswordConfirmation()
        {
            return View();
        }

        [ApiExplorerSettings(IgnoreApi = true)]
        [HttpGet]
        [AllowAnonymous]
        public IActionResult ResetPassword(Guid userId, string token)
        {
            if (token == null || userId == null)
            {
                throw new ApplicationException("Token vs ID must be supplied for password reset.");
            }
            var model = new ResetPasswordViewModel { UserId = userId, Token = token };
            return View(model);
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> ResetPassword(ResetPasswordViewModel model)
        {
            //if (!ModelState.IsValid)
            //{
            //    return View(model);
            //}
            //var user = await _userManager.FindByIdAsync(model.UserId.ToString());
            //if (user == null)
            //{
            //    // Don't reveal that the user does not exist
            //    return RedirectToAction(nameof(ResetPasswordConfirmation));
            //}
            //var result = await _userManager.ResetPasswordAsync(user, model.Token, model.Password);
            //if (result.Succeeded)
            //{
            //    return RedirectToAction(nameof(ResetPasswordConfirmation));
            //}
            //AddErrors(result);
            return View();
        }

        [HttpGet]
        [AllowAnonymous]
        public IActionResult ResetPasswordConfirmation()
        {
            return View();
        }

        #region Helpers
        private void AddErrors(IdentityResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError(string.Empty, error.Description);
            }
        }

        private IActionResult RedirectToLocal(string returnUrl)
        {
            if (Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }

            return RedirectToAction(nameof(HomeController.Index), "Home");
        }
        private ClaimsPrincipal ValidateToken(TokenResponseFromServer result)
        {
            var stream = result.AccessToken;
            var handler = new JwtSecurityTokenHandler();
            var jsonToken = handler.ReadToken(stream);
            var tokenS = handler.ReadToken(stream) as JwtSecurityToken;
            var claims = new List<Claim>
            {
                new Claim("access_token", result.AccessToken),
                new Claim("refresh_token", result.RefreshToken),
                new Claim("token_type", result.TokenType),
                new Claim("expires_in", result.ExpiresIn.ToString())
            };
            claims.AddRange(tokenS!.Claims);
            var claimsIdentity = new ClaimsIdentity(
                claims, CookieAuthenticationDefaults.AuthenticationScheme);
            ClaimsPrincipal principal = new ClaimsPrincipal(claimsIdentity);

            return principal;
        }
        #endregion Helpers
    }
}