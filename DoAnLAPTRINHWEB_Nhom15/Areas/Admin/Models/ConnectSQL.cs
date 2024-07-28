using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DoAnLAPTRINHWEB_Nhom15.Areas.Admin.Models
{
    public class ConnectSQL
    {
        public string conStr { get; set; }
        public  ConnectSQL()
        {
            conStr = "Data Source=ASUS-VIVOBOOK;Initial Catalog=QL_CuaHangVascara;Integrated Security=True";
            //conStr = "Data Source = TANDAT12DHTH07\\SQLEXPRESS; database = QL_CuaHangVascara; Integrated Security = true";
            //conStr = "Data Source=A205PC49;Initial Catalog=QL_CuaHangVascara;Integrated Security=True";
        }       
    }
}