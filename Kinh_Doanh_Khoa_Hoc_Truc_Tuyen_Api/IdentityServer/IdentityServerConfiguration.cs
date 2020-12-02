using IdentityServer4.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using IdentityServer4;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.IdentityServer
{
    public class IdentityServerConfiguration
    {
        public static IEnumerable<IdentityResource> Ids => new IdentityResource[] { new IdentityResources.OpenId(), new IdentityResources.Profile(), new IdentityResources.Email() };

        public static IEnumerable<ApiResource> Apis => new ApiResource[] { new ApiResource("api.khoahoc", "Khóa Học Trực Tuyến Api") };

        public static IEnumerable<Client> Clients =>
            new Client[]
            {

                new Client
                {
                    ClientId = "swagger",
                    ClientName = "Config Swagger",
                    ClientSecrets = { new Secret("secret".Sha256()) },
                    AllowedGrantTypes = GrantTypes.ResourceOwnerPassword,
                    AllowedScopes = new List<string>
                    {
                        IdentityServerConstants.StandardScopes.OpenId,
                        IdentityServerConstants.StandardScopes.Profile,
                        IdentityServerConstants.StandardScopes.Email,
                        IdentityServerConstants.StandardScopes.OfflineAccess,
                        "api.khoahoc"
                    },
                    RequireConsent = true,
                    AllowOfflineAccess = true,
                    AllowAccessTokensViaBrowser = true,
                  //  RedirectUris = { "https://localhost:44342/signin-oidc" },
                    //PostLogoutRedirectUris =  {   "http://openidclientdemocom:8001/signout-callback-oidc"}
                    AccessTokenType = AccessTokenType.Jwt,
                    AccessTokenLifetime = 3600 * 24, //86400,
                    IdentityTokenLifetime = 3600 * 24, //86400,
                    UpdateAccessTokenClaimsOnRefresh = true,
                    RefreshTokenExpiration = TokenExpiration.Absolute,
                    RefreshTokenUsage = TokenUsage.OneTimeOnly,
                    AlwaysSendClientClaims = true,
                    AlwaysIncludeUserClaimsInIdToken = true,
                    
                    Enabled = true
                },
                new Client
                {
                    ClientId = "angular",
                    ClientName = "Config angular",
                    ClientSecrets = { new Secret("secret".Sha256()) },
                    AllowedGrantTypes = GrantTypes.ResourceOwnerPassword,
                    AllowedScopes = new List<string>
                    {
                        IdentityServerConstants.StandardScopes.OpenId,
                        IdentityServerConstants.StandardScopes.Profile,
                        IdentityServerConstants.StandardScopes.Email,
                        "api.khoahoc"
                    },
                    RequireConsent = true,
                    AllowOfflineAccess = true,
                    AllowAccessTokensViaBrowser = true
                    //    RedirectUris =           { "https://localhost:5000/swagger/oauth2-redirect.html" },
                    //    PostLogoutRedirectUris = { "https://localhost:5000/swagger/oauth2-redirect.html" },
                    //    AllowedCorsOrigins =     { "https://localhost:5000" },
                    //    RedirectUris =           { "https://localhost:5000/swagger/oauth2-redirect.html" },
                    //    PostLogoutRedirectUris =  {   "http://openidclientdemocom:8001/signout-callback-oidc"}
                }
                //new Client
                //{
                //    ClientId = "webportal",
                //    ClientSecrets = { new Secret("secret".Sha256()) },

                //    AllowedGrantTypes = GrantTypes.Code,
                //    RequireConsent = false,
                //    RequirePkce = true,
                //    AllowOfflineAccess = true,

                //    // where to redirect to after login
                //    RedirectUris = { "https://localhost:5002/signin-oidc" },

                //    // where to redirect to after logout
                //    PostLogoutRedirectUris = { "https://localhost:5002/signout-callback-oidc" },

                //    AllowedScopes = new List<string>
                //    {
                //        IdentityServerConstants.StandardScopes.OpenId,
                //        IdentityServerConstants.StandardScopes.Profile,
                //        IdentityServerConstants.StandardScopes.OfflineAccess,
                //        "api.knowledgespace"
                //    }
                // },
                //new Client
                //{
                //    ClientId = "swagger",
                //    ClientName = "Swagger Client",

                //    AllowedGrantTypes = GrantTypes.Implicit,
                //    AllowAccessTokensViaBrowser = true,
                //    RequireConsent = false,

                //    RedirectUris =           { "https://localhost:5000/swagger/oauth2-redirect.html" },
                //    PostLogoutRedirectUris = { "https://localhost:5000/swagger/oauth2-redirect.html" },
                //    AllowedCorsOrigins =     { "https://localhost:5000" },

                //    AllowedScopes = new List<string>
                //    {
                //        IdentityServerConstants.StandardScopes.OpenId,
                //        IdentityServerConstants.StandardScopes.Profile,
                //        "api.knowledgespace"
                //    }
                //},
                //new Client
                //{
                //    ClientName = "Angular Admin",
                //    ClientId = "angular_admin",
                //    AccessTokenType = AccessTokenType.Reference,
                //    RequireConsent = false,
                //    RequireClientSecret = false,
                //    AllowedGrantTypes = GrantTypes.Code,
                //    RequirePkce = true,

                //    AllowAccessTokensViaBrowser = true,
                //    RedirectUris = new List<string>
                //    {
                //        "http://localhost:4200",
                //        "http://localhost:4200/authentication/login-callback",
                //        "http://localhost:4200/silent-renew.html"
                //    },
                //    PostLogoutRedirectUris = new List<string>
                //    {
                //       // "http://localhost:4200/unauthorized",
                //        "http://localhost:4200/authentication/logout-callback",
                //        "http://localhost:4200"
                //    },
                //    AllowedCorsOrigins = new List<string>
                //    {
                //        "http://localhost:4200"
                //    },
                //    AllowedScopes = new List<string>
                //    {
                //        IdentityServerConstants.StandardScopes.OpenId,
                //        IdentityServerConstants.StandardScopes.Profile,
                //        "api.knowledgespace"
                //    }
                //}
            };
    }
}
