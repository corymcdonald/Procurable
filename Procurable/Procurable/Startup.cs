using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Procurable.Startup))]
namespace Procurable
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
