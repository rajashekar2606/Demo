using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class user_details : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            if (Request.Cookies["userid"] == null || Request.Cookies["userid"].Value == "")
            {
                Response.Redirect("Login.aspx");
            }

        }
        catch (Exception ex)
        {

        }
    }
}