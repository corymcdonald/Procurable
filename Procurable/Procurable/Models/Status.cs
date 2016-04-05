using System;
using System.Collections.Generic;
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
        InProgress,
        New,
        Completed
    }

    public enum RequestStatus
    {
        Opened,
        Reopened,
        Approved,
        Denyed,
        InProgress,
        Completed
    }
}