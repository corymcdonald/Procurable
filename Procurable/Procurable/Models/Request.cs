using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Procurable.Models
{
    public class Request
    {
        public int ID { get; set; }
        public string Name { get; set; }
        [DisplayName("Details")]
        public string Comments { get; set; }
        [UIHint("User")]
        [DisplayName("Requested For")]
        public virtual ApplicationUser RequestedFor { get; set; }
        [UIHint("User")]
        public virtual ApplicationUser RequestedBy { get; set; }

        public DateTime CreatedDate { get; set; }
        public string   CreatedDateDisplay {
            get
            {
                return CreatedDate.ToString("s") + "Z";
            }

        }
        public DateTime LastModified { get; set; }
        public string   LastModifiedDisplay
        {
            get
            {
                return LastModified.ToString("s") + "Z";
            }
        }

        [UIHint("ItemList")]
        public virtual ICollection<RequestedItem> Items { get; set; }

        public RequestStatus Status { get; set; }
        public string StatusDisplay
        {
            get
            {
                return Status.ToString();
            }
        }
    }
}