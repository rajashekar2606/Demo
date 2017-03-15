using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GPRSGPSServer;
using MySql.Data.MySqlClient;
using System.Data;

public partial class Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
           
           
        }
        catch (Exception ex)
        {

        }
    }
    HttpContext context = HttpContext.Current;
    DBMgr dbm = new DBMgr();
    MySqlCommand cmd;
}