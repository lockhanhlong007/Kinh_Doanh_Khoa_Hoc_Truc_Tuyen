using System.Net;
using System.Net.Mail;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity.UI.Services;
using Microsoft.Extensions.Configuration;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Services
{
    // This class is used by the application to send email for account confirmation and password reset.
    // For more details see https://go.microsoft.com/fwlink/?LinkID=532713
    public class EmailSender : IEmailSender
    {
        private readonly IConfiguration _configuration;

        public EmailSender(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public Task SendEmailAsync(string email, string subject, string message)
        {
            var client = new SmtpClient(_configuration["MailSettings:Server"])
            {
                UseDefaultCredentials = false,
                Port = int.Parse(_configuration["MailSettings:Port"]),
                EnableSsl = bool.Parse(_configuration["MailSettings:EnableSsl"]),
                Credentials = new NetworkCredential(_configuration["MailSettings:UserName"], _configuration["MailSettings:Password"])
            };

            var mailMessage = new MailMessage
            {
                From = new MailAddress(_configuration["MailSettings:FromEmail"], _configuration["MailSettings:FromName"]),
            };
            mailMessage.To.Add(email);
            mailMessage.Body = message;
            mailMessage.Subject = subject;
            mailMessage.IsBodyHtml = true;
            client.Send(mailMessage);
            //var client = new RestClient
            //{
            //    BaseUrl = new Uri("https://api.mailgun.net/v3"),
            //    Authenticator = new HttpBasicAuthenticator("api",
            //        "5a3a8ada09b52886a74262c0526ebebc-a83a87a9-27da9e4d")
            //};
            //var request = new RestRequest();
            //request.AddParameter("domain", "sandbox31ad4bb8cc9540728a038a562c9a32dd.mailgun.org", ParameterType.UrlSegment);
            //request.Resource = "{domain}/messages";
            //request.AddParameter("from", "Mailgun Sandbox <postmaster@sandbox31ad4bb8cc9540728a038a562c9a32dd.mailgun.org>");
            //request.AddParameter("to", email);
            //request.AddParameter("subject", subject);
            //request.AddParameter("text", message);
            //request.Method = Method.POST;
            //client.Execute(request);
            return Task.CompletedTask;
        }
    }
}