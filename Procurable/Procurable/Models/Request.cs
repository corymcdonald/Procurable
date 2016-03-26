using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Procurable.Models
{
    public class Request
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Comments { get; set; }
        [UIHint("User")]
        public virtual ApplicationUser RequestedFor { get; set; }
        [UIHint("User")]
        public virtual ApplicationUser RequestedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public DateTime LastModified { get; set; }
        public virtual ICollection<ApplicationUser> Approvers { get; set; }
        public virtual ICollection<RequestedItem> Items { get; set; }
    }
}