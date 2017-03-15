using System;
using System.Collections.Generic;

using System.Web;
using System.Web.UI;

/// <summary>
/// Summary description for MessageBox
/// </summary>
public class MessageBox
{

    public static void Show(string message,Control Page)
    {
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append("alert('");
        sb.Append(message);
        sb.Append("');");
       // ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
        ScriptManager.RegisterStartupScript(Page,message.GetType(),"JsStatus", sb.ToString(), true);
    }

    public static void singlejsfun(string funct, Control Page)
    {
        ScriptManager.RegisterStartupScript(Page, funct.GetType(), "JsStatus", funct, true);
    }

    public static void msgfun(string message, Control Page,string fun)
    {
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append("alert('");
        sb.Append(message);
        sb.Append("');");
        // ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
        ScriptManager.RegisterStartupScript(Page, message.GetType(), "JsStatus", sb.ToString() + fun, true);
    }

    public static void confirm(string message, Control Page)
    {
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append("confirm('");
        sb.Append(message);
        sb.Append("');");
        ScriptManager.RegisterStartupScript(Page, message.GetType(), "JsStatus", sb.ToString(), true);

    }

    
}