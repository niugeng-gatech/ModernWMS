using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using ModernWMS.Core.DBContext;
using ModernWMS.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ModernWMS.Core.Extentions
{
    public class DatabaseKeepAlive : IHostedService, IDisposable
    {
        private Timer _timer;
        private readonly ILogger<DatabaseKeepAlive> _logger;
        private readonly IServiceScopeFactory _scopeFactory;

        public DatabaseKeepAlive(ILogger<DatabaseKeepAlive> logger, IServiceScopeFactory scopeFactory)
        {
            _logger = logger;
            _scopeFactory = scopeFactory;
        }

        public Task StartAsync(CancellationToken cancellationToken)
        {
            _logger.LogInformation("DatabaseKeepAlive Service is starting.");
            _timer = new Timer(ExecuteQuery, null, TimeSpan.Zero, TimeSpan.FromMinutes(10));
            return Task.CompletedTask;
        }

        private void ExecuteQuery(object state)
        {
            try
            {
                using (var scope = _scopeFactory.CreateScope())
                {
                    var dbContext = scope.ServiceProvider.GetRequiredService<SqlDBContext>();

                    // Assuming you have a DbSet<UserroleEntity> or another entity
                    var anyRecord = dbContext.Set<UserroleEntity>().AsNoTracking().Any();
                    _logger.LogInformation("DatabaseKeepAlive query executed successfully.");
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while executing the keep-alive query.");
            }
        }

        public Task StopAsync(CancellationToken cancellationToken)
        {
            _logger.LogInformation("DatabaseKeepAlive Service is stopping.");
            _timer?.Change(Timeout.Infinite, 0);
            return Task.CompletedTask;
        }

        public void Dispose()
        {
            _timer?.Dispose();
        }
    }
}
