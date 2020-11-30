using IdentityServer4.Models;
using System.Collections.Generic;

namespace EndPointTokenIdentityServer4.ConfigIdentityServer
{
    public class Clients
    {
        public static IEnumerable<Client> Get()
        {
            return new List<Client>
        {
            new Client
            {
                ClientId = "oauthClient",
                ClientName = "Example client application using client credentials",
                AllowedGrantTypes = GrantTypes.ClientCredentials,
                ClientSecrets = new List<Secret> {new Secret("SuperSecretPassword".Sha256())},
                AllowedScopes = new List<string> {"api1.read"}
            },
             new Client
            {
                ClientId = "oauthClientPassword",
                ClientName = "Example client application using client password",
                AllowedGrantTypes = GrantTypes.ResourceOwnerPassword,
                ClientSecrets = new List<Secret> {new Secret("SuperSecretPassword".Sha256())},
                AllowedScopes = new List<string> {"api1.password"}
            }
        };
        }
    }
}