using Procurable.Models;
using Procurable.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ContinuousJob
{
    class Program
    {
        static void Main(string[] args)
        {
            string APIKey = Environment.GetEnvironmentVariable("SendGridAPI", EnvironmentVariableTarget.User);

            var IIC = new InventoryItemsController();
            foreach (InventoryItem i in IIC.GetInventoryItems())
            {
               
            }
        }
    }
}
