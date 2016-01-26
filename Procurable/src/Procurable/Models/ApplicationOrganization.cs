using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Procurable.Models
{
    public class ApplicationOrganization
    {
        public virtual ICollection<ApplicationUser> Users { get; set; }
        public string name { get; set; }

    }
}
