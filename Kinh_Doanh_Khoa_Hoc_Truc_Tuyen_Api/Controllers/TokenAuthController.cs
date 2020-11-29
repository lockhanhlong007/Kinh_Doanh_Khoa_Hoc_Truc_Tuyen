using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using IdentityModel.Client;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Helpers;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Entities;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TokenAuthController : ControllerBase
    {
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly UserManager<AppUser> _userManager;
        private readonly SignInManager<AppUser> _signInManager;

        public TokenAuthController(UserManager<AppUser> userManager, SignInManager<AppUser> signInManager, IHttpClientFactory httpClientFactory)
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _httpClientFactory = httpClientFactory;
        }
        [HttpPost("logout")]
        public async Task<IActionResult> Logout()
        {
            await _signInManager.SignOutAsync();
            return Ok();
        }

        [HttpPost("authenticate")]
        [AllowAnonymous]
        public async Task<IActionResult> Authenticate(LoginViewModel model)
        {
            var user = await _userManager.FindByNameAsync(model.UserName);
            if (user == null) 
                return NotFound(new ApiNotFoundResponse("Username không tồn tại"));
            var serverClient = _httpClientFactory.CreateClient();

            var discoveryDocument = await serverClient.GetDiscoveryDocumentAsync("https://localhost:44342/");

            var tokenResponse = await serverClient.RequestPasswordTokenAsync(
                new PasswordTokenRequest()
                {
                    Address = discoveryDocument.TokenEndpoint,
                    ClientId = "swagger",
                    ClientSecret = "secret",
                    Scope = "email openid api.khoahoc offline_access",
                    UserName = model.UserName,
                    Password = model.Password
                });
            return Ok(new
            {
                access_token = tokenResponse.AccessToken,
                refreshtoken = tokenResponse.RefreshToken,
                scope = tokenResponse.Scope,
                expire = tokenResponse.ExpiresIn,
                tokenType = tokenResponse.TokenType

            });
            //var result = await _signInManager.PasswordSignInAsync(user, model.Password, false, lockoutOnFailure: true);
            //if (result.Succeeded)
            //{
            //    var check = User.Claims.ToList();
            //    return Ok();
            //}
            //return BadRequest(result.IsLockedOut ? new ApiBadRequestResponse("Tài khoản đã bị khoá") : new ApiBadRequestResponse("Mật khẩu không đúng"));
        }


    }
}
