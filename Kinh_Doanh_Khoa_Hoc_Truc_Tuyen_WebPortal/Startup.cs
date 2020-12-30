using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Security.Claims;
using System.Threading.Tasks;
using FluentValidation.AspNetCore;
using IdentityModel.Client;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.FluentValidation;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Systems;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Extensions;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Services;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Services.Implements;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Identity.UI.Services;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using PaulMiami.AspNetCore.Mvc.Recaptcha;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddHttpClient("BackendApi").ConfigurePrimaryHttpMessageHandler(() =>
            {
                var handler = new HttpClientHandler();
                var environment = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT");
                handler.ServerCertificateCustomValidationCallback = (message, cert, chain, errors) => true;
                return handler;
            });
            services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>();
            services.AddTransient<IBaseApiClient, BaseApiClient>();
            services.AddTransient<IEmailSender, EmailSender>();
            services.AddTransient<IViewRenderService, ViewRenderService>();
            services.AddAuthentication(options =>
                {
                    options.DefaultAuthenticateScheme = CookieAuthenticationDefaults.AuthenticationScheme;
                    options.DefaultSignInScheme = CookieAuthenticationDefaults.AuthenticationScheme;
                })
                .AddCookie(CookieAuthenticationDefaults.AuthenticationScheme, options =>
                {
                    options.Events = new CookieAuthenticationEvents
                    {
                        // this event is fired everytime the cookie has been validated by the cookie middleware,
                        // so basically during every authenticated request
                        // the decryption of the cookie has already happened so we have access to the user claims
                        // and cookie properties - expiration, etc..
                        OnValidatePrincipal = async x =>
                        {
                            // since our cookie lifetime is based on the access token one,
                            // check if we're more than halfway of the cookie lifetime
                            var now = DateTimeOffset.UtcNow;
                            var timeElapsed = now.Subtract(x.Properties.IssuedUtc!.Value);
                            var timeRemaining = x.Properties.ExpiresUtc!.Value.Subtract(now);

                            if (timeElapsed > timeRemaining)
                            {
                                var identity = (ClaimsIdentity)x.Principal.Identity;
                                var accessTokenClaim = identity.FindFirst("access_token");
                                var refreshTokenClaim = identity.FindFirst("refresh_token");
                                // if we have to refresh, grab the refresh token from the claims, and request
                                // new access token and refresh token
                                var refreshToken = refreshTokenClaim.Value;
                                var response = await new HttpClient().RequestRefreshTokenAsync(new RefreshTokenRequest
                                {
                                    Address = Configuration["Authorization:AuthorityUrl"],
                                    ClientId = Configuration["Authorization:ClientId"],
                                    ClientSecret = Configuration["Authorization:ClientSecret"],
                                    RefreshToken = refreshToken,
                                });

                                if (!response.IsError)
                                {
                                    // everything went right, remove old tokens and add new ones
                                    identity.RemoveClaim(accessTokenClaim);
                                    identity.RemoveClaim(refreshTokenClaim);

                                    identity.AddClaims(new[]
                                    {
                                        new Claim("access_token", response.AccessToken),
                                        new Claim("refresh_token", response.RefreshToken)
                                    });

                                    // indicate to the cookie middleware to renew the session cookie
                                    // the new lifetime will be the same as the old one, so the alignment
                                    // between cookie and access token is preserved
                                    x.ShouldRenew = true;
                                }
                            }
                        }
                    };
                    options.LoginPath = new PathString("/Account/Login");
                    options.ReturnUrlParameter = "RequestPath";
                    options.SlidingExpiration = true;
                });
            services.AddRecaptcha(new RecaptchaOptions
            {
                SiteKey = Configuration["Recaptcha:SiteKey"],
                SecretKey = Configuration["Recaptcha:SecretKey"]
            });
            services.AddSession(options =>
            {
                options.IdleTimeout = TimeSpan.FromMinutes(30);
            });
            var builder = services.AddControllersWithViews().AddFluentValidation(fv => fv.RegisterValidatorsFromAssemblyContaining<LoginRequestValidator>()); ;
            var env = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT");
            if (env == Environments.Development)
            {
                builder.AddRazorRuntimeCompilation();
            }

        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }
            app.UseErrorMiddleware();
            // app.UseHttpsRedirection();
            app.UseStaticFiles();
            app.UseAuthentication();

            app.UseRouting();

            app.UseAuthorization();
            app.UseSession();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute(
                    name: "default",
                    pattern: "{controller=Home}/{action=Index}/{id?}");
            });
        }
    }
}
