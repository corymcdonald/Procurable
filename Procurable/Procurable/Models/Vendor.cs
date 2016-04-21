using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;

namespace Procurable.Models
{
    public class Vendor
    {
        public int ID { get; set; }
        [Display(Name = "Vendor Name")]
        public string Name { get; set; }
        [DataType(DataType.MultilineText)]
        public string Description { get; set; }
        public string Website { get; set; }
        public string Contact { get; set; }

       
    }
}