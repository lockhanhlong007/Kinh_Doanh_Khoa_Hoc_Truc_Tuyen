using IdentityModel;
using IdentityServer4.Test;
using System.Collections.Generic;
using System.Security.Claims;

namespace EndPointTokenIdentityServer4.ConfigIdentityServer
{
    public class Users
    {
        public static List<TestUser> Get()
        {
            return new List<TestUser> {
            new TestUser {
                SubjectId = "1",
                Username = "admin",
                Password = "123456",
                Claims = new List<Claim> {
                    new Claim(JwtClaimTypes.Email, "admin@gmail.com"),
                    new Claim(JwtClaimTypes.Role, "admin")
                }
            }
        };
        }
    }
}