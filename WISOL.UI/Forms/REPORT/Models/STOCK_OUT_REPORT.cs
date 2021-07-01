﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Wisol.MES.Forms.REPORT.Models
{
    public class STOCK_OUT_REPORT
    {
        public string UserReive { get; set; }
        public string UserCreate { get; set; }
        public string Day { get; set; }
        public string Month { get; set; }
        public string Year { get; set; }
        public string Cause { get; set; }

        public List<SPARE_PART> LstSpareParts { get; set; }
    }

    public class SPARE_PART
    {
        public string ID { get; set; }
        public string Name { get; set; }
        public string Quantity { get; set; }
        public string Location { get; set; }
        public string Condition { get; set; }

        public string Unit { get; set; }
    }
}
