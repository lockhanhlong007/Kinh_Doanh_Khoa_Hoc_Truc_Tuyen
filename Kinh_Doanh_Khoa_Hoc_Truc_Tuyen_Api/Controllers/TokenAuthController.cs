using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Net.Http;
using System.Security.Claims;
using System.Threading.Tasks;
using IdentityModel.Client;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Claims;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Extensions;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Helpers;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Entities;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.Common;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Systems;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
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
        [HttpPost("Logout")]
        public async Task<IActionResult> Logout()
        {
            await _signInManager.SignOutAsync();
            return Ok();
        }

        [HttpPost("Authenticate")]
        [AllowAnonymous]
        public async Task<IActionResult> Authenticate(LoginViewModel model)
        {
            var user = await _userManager.FindByNameAsync(model.UserName);
            if (user == null) 
                return NotFound(new ApiNotFoundResponse("Username không tồn tại"));
            var serverClient = _httpClientFactory.CreateClient();

            var discoveryDocument = await serverClient.GetDiscoveryDocumentAsync("https://localhost:44342/");

            var tokenResponse = await serverClient.RequestPasswordTokenAsync(
                new PasswordTokenRequest
                {
                    Address = discoveryDocument.TokenEndpoint,
                    ClientId = model.ClientId,
                    ClientSecret = model.ClientSecret,
                    Scope = model.Scope,
                    UserName = model.UserName,
                    Password = model.Password
                });
            if (tokenResponse.IsError)
            {
                return BadRequest(new ApiBadRequestResponse("Tài khoản hoặc mật khẩu không đúng"));
            }

            //var principal = ValidateToken(tokenResponse);
            //var authProperties = new AuthenticationProperties();
            //if (!model.ClientId.Equals("client_angular"))
            //{
            //    if (model.RememberMe)
            //    {
            //        authProperties.ExpiresUtc = DateTimeOffset.UtcNow.AddDays(1);
            //        authProperties.IsPersistent = true;
            //    }
            //    else
            //    {
            //        authProperties.ExpiresUtc = DateTimeOffset.UtcNow.AddMinutes(10);
            //        authProperties.IsPersistent = false;
            //    }
            //}
            //else
            //{
            //    authProperties.ExpiresUtc = DateTimeOffset.UtcNow.AddDays(1);
            //    authProperties.IsPersistent = true;
            //}
            //await HttpContext.SignInAsync(
            //    CookieAuthenticationDefaults.AuthenticationScheme,
            //    principal,
            //    authProperties);

            //var abc = serverClient.GetUserInfoAsync(new UserInfoRequest
            //{
            //    Address = "https://localhost:44342/connect/userinfo",
            //    Token = tokenResponse.AccessToken
            //});



            return Ok(new TokenResponseFromServer()
            {
                AccessToken = tokenResponse.AccessToken,
                RefreshToken = tokenResponse.RefreshToken,
                ExpiresIn = tokenResponse.ExpiresIn,
                TokenType = tokenResponse.TokenType
            });
        }

        [HttpGet("test-authen")]
        [AllowAnonymous]
        public IActionResult TexstAuthenticate()
        {
            return Ok(HttpContext.User.Identity.IsAuthenticated);
        }

        #region private method
        private ClaimsPrincipal ValidateToken(TokenResponse result)
        {
            var stream = result.AccessToken;
            var handler = new JwtSecurityTokenHandler();
            var jsonToken = handler.ReadToken(stream);
            var tokenS = handler.ReadToken(stream) as JwtSecurityToken;
            var claims = new List<Claim>
            {
                new Claim("access_token", result.AccessToken),
                new Claim("token_type", result.TokenType),
                new Claim("expires_in", result.ExpiresIn.ToString())
            };
            if (!string.IsNullOrEmpty(result.RefreshToken))
            {
                claims.Add(new Claim("refresh_token", result.RefreshToken));
            }
            claims.AddRange(tokenS!.Claims);
            var claimsIdentity = new ClaimsIdentity(
                claims, CookieAuthenticationDefaults.AuthenticationScheme);
            ClaimsPrincipal principal = new ClaimsPrincipal(claimsIdentity);

            return principal;
        }


        #endregion
    }
}
