using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GPRSGPSServer;
using MySql.Data.MySqlClient;
using System.Data;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Request.Cookies["userid"] != null || Request.Cookies["userid"].Value != "")
            {
                Response.Redirect("user-details.aspx");
            }
           
        }
        catch (Exception ex)
        {

        }
    }
    HttpContext context = HttpContext.Current;
    DBMgr dbm = new DBMgr();
    MySqlCommand cmd;
    protected void validate_login(object sender, EventArgs e)
    {
        string username = txt_username.Text;
        string pwd = txt_password.Text;
        cmd = new MySqlCommand("SELECT idusers, first_name, last_name, email, pwd, address1, address2, city, state, zipcode FROM users WHERE  (email = @txt_username) AND (pwd = @txt_password)");
        cmd.Parameters.Add("txt_username", username);
        cmd.Parameters.Add("txt_password", pwd);
        DataTable dt = dbm.SelectQuery(cmd).Tables[0];
        DataView view = dt.DefaultView;
        //  page_names.url, page_names.status AS pagestatus, departments_pages.page_names_sno
        DataTable main_table = view.ToTable(true, "idusers");

        if (dt.Rows.Count > 0)
        {
            Session["idusers"] = null;
            Response.Cookies["userid"].Value = HttpUtility.UrlEncode(main_table.Rows[0]["idusers"].ToString());
            Response.Cookies["userid"].Path = "/";
            Response.Cookies["userid"].Expires = DateTime.Now.AddDays(1);
            Response.Redirect("user-details.aspx");
        }


        else
        {
            Session["idusers"] = null;
            Session["userid"] = null;
            MessageBox.Show("Please check Username and Password", Page);
        }
    }
}