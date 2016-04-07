using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Procurable
{
    public static class Extensions
    {
        public static string ToHumanString(this int? Days)
        {
            if (Days == null)
                return "0 days";
            return Days.Value.ToHumanString();
        }
        public static string ToHumanString(this int Days)
        {
            int Months = (int)((double)Days / 30.436875);

            return String.Format("{0}{1}",
              (Months == 0 ? "" : string.Format("{0} months ", Months)),
              ((int)(Days - Months * 30.436875) <= 0 ? "" : string.Format("{0} days ", (int)(Days - Months * 30.436875)))
              );
        }
        public static string ToHumanString(this TimeSpan ts)
        {
            int Months = ts.GetMonths();
            return String.Format("{0}{1}{2}",
                (Months == 0 ? "" : string.Format("{0} months ", Months)),
                ((int)(ts.Days - Months* 30.436875) <= 0 ? "" : string.Format("{0} days ", (int)(ts.Days - Months * 30.436875))),
                ((int)ts.Minutes == 0 ? "" : string.Format("{0} minutes ", (int)ts.Minutes))
                );
        }
        public static int GetYears(this TimeSpan timespan)
        {
            return (int)((double)timespan.Days / 365.2425);
        }
        public static int GetMonths(this TimeSpan timespan)
        {
            return (int)((double)timespan.Days / 30.436875);
        }
    }
}