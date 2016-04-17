using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Procurable.Models
{
    public class Project
    {
        public int ProjectID { get; set; }
        public int RequestID { get; set; }

        public virtual  Request Request { get; set; }
        public ProjectPriority Priority { get; set; }
        public ProjectStatus Status { get; set; }

        public DateTime CreatedDate { get; set; }
        public DateTime LastModified { get; set; }
        public DateTime? DateNeeded { get; set; }

        public ApplicationUser CreatedBy { get; set; }
        public ApplicationUser AssignedTo { get; set; }
    }
}