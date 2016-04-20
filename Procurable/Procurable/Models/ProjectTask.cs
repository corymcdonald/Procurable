using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;


namespace Procurable.Models
{
    public class ProjectTask
    {
        public int ID { get; set; }

        public string Name { get; set;  }

        [DataType(DataType.MultilineText)]
        public string Comments { get; set; }

        public int ProjectID { get; set; }
        public virtual Project Project { get; set; }

        public ProjectStatus Status { get; set; }

        public string CreatedByID { get; set; }
        public string AssignedToID { get; set; }

        public virtual ApplicationUser CreatedBy { get; set;  }
        public virtual ApplicationUser AssignedTo { get; set; }

        public DateTime? CompletedDate { get; set; }
        public DateTime CreatedDate { get; set; }
        public DateTime LastModified { get; set; }
        public DateTime DateNeeded { get; set; }
    }
}