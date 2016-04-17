using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;


namespace Procurable.Models
{
    public class ProjectTask
    {
        public int ID { get; set; }

        public string Name { get; set;  }
        public string Comments { get; set; }

        public int ProjectID { get; set; }
        public virtual Project Project { get; set; }

        public ApplicationUser CreatedBy { get; set;  }
        public ApplicationUser AssignedTo { get; set; }

        public DateTime DateNeeded { get; set; }
    }
}