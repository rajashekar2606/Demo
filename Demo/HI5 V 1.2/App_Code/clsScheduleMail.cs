using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Web.SessionState;
using System.Web.Script.Serialization;
using GPRSGPSServer;
using MySql.Data.MySqlClient;
using System.Globalization;
using System.IO;
using System.Collections.Specialized;
using System.Net;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Net.Mail;
using System.Threading;
using FacebookAPI;
using Facebook;
using Facebook.Web;
using System.Drawing;

/// <summary>
/// Summary description for clsScheduleMail
/// </summary>
public class clsScheduleMail
{
	public clsScheduleMail()
	{
		
	}
    DBMgr dbm;

    public void SendScheduleMail()
    { 
     // Write your send mail code here.
        dbm = new DBMgr();
        MySqlCommand cmd;
        DateTime todaysDate = DateTime.Now.Date;
        var month_today = todaysDate.Month;
        var day_today = todaysDate.Day;
        var day_today2 = todaysDate.Day + 5;
        cmd = new MySqlCommand("SELECT users.email, users_dates.id_dates, users_dates.idusers, users_dates.occasion, users_dates.month, users_dates.day FROM users INNER JOIN users_dates ON users.idusers = users_dates.idusers WHERE  (users_dates.month = @month) AND (users_dates.day BETWEEN @day1 AND @day2) ORDER BY users_dates.day DESC");
        cmd.Parameters.Add("@month", month_today);
        cmd.Parameters.Add("@day1", day_today);
        cmd.Parameters.Add("@day2", day_today2);
        DataTable sessiondata = dbm.SelectQuery(cmd).Tables[0];
        foreach (DataRow dr in sessiondata.Rows)
        {
            var day_occasion = Int32.Parse(dr["day"].ToString());
            var month_occasion = Int32.Parse(dr["month"].ToString());
            var Email_user = dr["email"].ToString();
            var occasion = dr["occasion"].ToString();
            var month_check = month_occasion - month_today;
            var day_check = day_occasion - day_today;
            if (month_check >= 0 )
            {
                if (day_check > 0 && day_check <= 5)
                {
                    MailMessage Msg = new MailMessage();
                    MailAddress fromMail = new MailAddress("");
                    // Sender e-mail address.
                    Msg.From = fromMail;
                    const string password = "";
                    // Recipient e-mail address.
                    Msg.To.Add(new MailAddress(Email_user));
                    // Subject of e-mail
                    Msg.Subject = "HI5 Reminder for Donation on Occasion of "+occasion+"";
                    Msg.Body += "<div style='overflow:auto;width: 630px; min-height: 20px; padding: 10px; margin: 0 auto; background-color: #77e9df;font-family: Arial,Helvetica,sans-serif; font-size: 12px;line-height:20px'><p><div style='font-size: 35px; text-align: center;color:white; margin-bottom: 25px; font-weight: 300;line-height: 150%'><a><b style='color:white;'><img src='http://www.advantageitinc.com/assets/img/logo.png' style='height:70px;width:250px;' /></b></a></div>In economic terms, a nonprofit organization uses its surplus revenues to further achieve its purpose or mission, rather than distributing its surplus income to the organization's shareholders (or equivalents) as profit or dividends. This is known as the non-distribution constraint.</p></div><footer><div style='width: 630px; min-height: 20px; padding: 10px; margin: 0 auto; background-color: #555;font-family: Arial,Helvetica,sans-serif; font-size: 12px;line-height:20px;'><p style='color:White;'>Contact us 93222r323 and contact us at contactus@gmail.com website:hi5.tcaporegon.org</p></div></footer>";
                    Msg.IsBodyHtml = true;
                    SmtpClient a = new SmtpClient();
                    a.Host = "relay-hosting.secureserver.net";
                    a.Port = 25;
                    a.Send(Msg);
                }

            }

        }
    }
}
