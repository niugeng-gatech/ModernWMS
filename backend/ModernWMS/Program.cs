
using Microsoft.AspNetCore.Hosting;
using ModernWMS.Core.Extentions;
using NLog;
using NLog.Web;

namespace ModernWMS
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var logger = NLog.LogManager.Setup().LoadConfigurationFromAppSettings().GetCurrentClassLogger();

            try
            {
                logger.Debug("--- run");
                CreateHostBuilder(args).Build().Run();
            }
            catch (Exception exception)
            {
                logger.Error(exception, "---- exception");
                throw;
            }
            finally
            {
                NLog.LogManager.Shutdown();
            }
        }

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder
                    //.UseUrls("http://*:5555")
                    .UseStartup<Startup>()
                    .UseIISIntegration();
                    //.UseKestrel(opt => opt.Limits.MaxRequestBodySize = null);
                }).ConfigureLogging(logging =>
                {
                    logging.ClearProviders();
                    logging.SetMinimumLevel(Microsoft.Extensions.Logging.LogLevel.Trace);
                }).UseNLog()
            .UseDefaultServiceProvider(options =>
            {
                options.ValidateScopes = false;
            })
            .ConfigureServices((context, services) =>
            {
                services.AddHostedService<DatabaseKeepAlive>();
                // Inject logger service
                Microsoft.Extensions.Logging.ILogger logger = LoggerFactory.Create(builder => builder.AddConsole()).CreateLogger("Startup");

                // Log the URLs
                var urls = context.Configuration.GetValue<string>("urls");
                logger.LogInformation("Listening on URLs: {urls}", urls);
            });
    }
}
