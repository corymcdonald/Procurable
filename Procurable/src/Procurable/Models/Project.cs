using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Procurable.Models
{
    public class Project
    {
        public int ID { get; set; }
        public Request Request { get; set; }
        public ProjectPriority Priority { get; set; }
        public ProjectStatus Status { get; set; }
        public DateTime CreatedDate { get; set; }
        public DateTime LastModified { get; set; }
        public virtual ICollection<InventoryItem> Items { get; set; }
    }
}