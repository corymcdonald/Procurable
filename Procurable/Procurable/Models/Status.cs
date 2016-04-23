using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Procurable.Models
{
    public enum InventoryStatus
    {
        Allocated,
        Unallocated,
        Deprecated
    }

    public enum ProjectStatus
    {
        New,
        [Display(Name = "In Progress")]
        InProgress,
        Completed
    }

    public enum RequestStatus
    {
        Opened,
        Reopened,
        Approved,
        Denied,
        [Display(Name = "In Progress")]
        InProgress,
        Completed
    }
}