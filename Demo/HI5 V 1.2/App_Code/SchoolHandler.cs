using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using System.Web.Script.Serialization;
using GPRSGPSServer;
using MySql.Data.MySqlClient;
using System.Data;
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
namespace callme
{

    /// <summary>
    /// Summary description for SchoolHandler
    /// </summary>
    public class SchoolHandler : IHttpHandler, IRequiresSessionState
    {
        public SchoolHandler()
        {
            //
            // TODO: Add constructor logic here
            //
        }


        public bool IsReusable
        {
            get { return true; }
        }
        static DateTime todaydate;

        class sessiondetails
        {
            public string sessionName { set; get; }
            public DateTime startdate { set; get; }
            public DateTime enddate { set; get; }
            public int rank { set; get; }
        }
        static sessiondetails session_Details = new sessiondetails();
        class GetJsonData
        {
            public string op { set; get; }
        }

        DBMgr dbm;
        public void ProcessRequest(HttpContext context)
        {
            try
            {
                dbm = new DBMgr();
                string operation = context.Request["op"];
                if (operation == "forgotpasswordclick_login")
                {
                    forgotpasswordclick_login(context);
                    return;

                }
                else if (operation == "send_forgotpasswordmail")
                {
                    send_forgotpasswordmail(context);
                    return;
                }
                else if (operation != "save_users" && operation != "get_all_users")
                {
                    context.Session["user_id"] = HttpUtility.UrlDecode(context.Request.Cookies["userid"].Value);
                }
                switch (operation)
                {
                    case "Leave_message":
                        Leave_message(context);
                        break;
                    case "save_users":
                        save_users(context);
                        break;
                   case "save_user_dates":
                        save_user_dates(context);
                        break;
                    case "add_comment":
                        add_comment(context);
                        break;
                    case "get_add_comments":
                        get_add_comments(context);
                        break;
                    case "get_users":
                        get_users(context);
                        break;
                    case "get_all_users":
                        get_all_users(context);
                        break;
                    case "get_dates_users":
                        get_dates_users(context);
                        break;
                    case "get_posted_questions":
                        get_posted_questions(context);
                        break;
                    case "getFBPosts":
                        getFBPosts(context);
                        break;
                    case "getAdsDetails_actuals":
                        getAdsDetails_actuals(context);
                        break;

                    default:


                        var jsonString = String.Empty;

                        context.Request.InputStream.Position = 0;
                        using (var inputStream = new StreamReader(context.Request.InputStream))
                        {
                            jsonString = HttpUtility.UrlDecode(inputStream.ReadToEnd());
                        }
                        if (jsonString != "")
                        {
                            var js = new JavaScriptSerializer();
                            GetJsonData obj = js.Deserialize<GetJsonData>(jsonString);
                            switch (obj.op)
                            {
                                //case "student_attendance_save":
                                //    student_attendance_save(jsonString, context);
                                //    break;
                            }
                        }
                        else
                        {
                            var js = new JavaScriptSerializer();
                            var title1 = context.Request.Params[1];
                            GetJsonData obj = js.Deserialize<GetJsonData>(title1);
                            switch (obj.op)
                            {


                            }

                        }
                        break;
                }

            }
            catch (Exception ex)
            {
                string response = GetJson(ex.Message);
                context.Response.Write(response);
            }

        }

        #region leave_message


        private void Leave_message(HttpContext context)
        {
            try
            {
                string emailid = context.Request["email"].ToString();
                string name = context.Request["name"].ToString();
                string subject = context.Request["subject"].ToString();
                string message = context.Request["message"].ToString();
                MailMessage Msg = new MailMessage();
                MailAddress fromMail = new MailAddress(emailid);
                // Sender e-mail address.
                Msg.From = fromMail;
                 const string password = "apna6020";
                // Recipient e-mail address.
                if (emailid == "")
                {
                    emailid = "noreply.apnachatbhavan@gmail.com";
                }
                Msg.To.Add(new MailAddress("contactus@apnachatbhavan.com"));
                // Subject of e-mail
                Msg.Subject = "Message From " + name + " , Email:" + emailid + "";
                Msg.Body += "<div style='background-color: #FE5615; font-family: Arial,Helvetica,sans-serif; font-size: 12px'><div style='width: 630px; height: 20px; padding: 10px;'></div><div style='width: 630px; min-height: 20px; padding: 10px; margin: 0 auto; background-color: #FE5615;'><p><div style='font-size: 35px; text-align: center;color:white; margin-bottom: 25px; font-weight: 300;'><a><b style='color:white;'><img src='http://apnabazaarpdx.com/img/logo.jpg' style='height:100px;width:250px;' /></b></a></div>Hello,iam " + name + "<br /><br /> " + message + "<br /><br />Contact me at " + emailid + "</p></div><div style='width: 630px; height: 20px; padding: 10px;'></div>";
                Msg.IsBodyHtml = true;
                //string sSmtpServer = "";
                //sSmtpServer = "smtp.gmail.com";
                //int portNumber = 587;
                //SmtpClient a = new SmtpClient(sSmtpServer, portNumber);
                //a.Host = sSmtpServer;
                //a.Credentials = new NetworkCredential("noreply.apnachatbhavan@gmail.com", password);
                //a.EnableSsl = true;
                SmtpClient a = new SmtpClient();
                a.Host = "relay-hosting.secureserver.net";
                a.Port = 25;
                a.Send(Msg);
                string strresponse = GetJson("Message successfully sent!");
                context.Response.Write(strresponse);

            }
            catch
            {
                string strresponse = GetJson("Invalid request!");
                context.Response.Write(strresponse);
            }
        }
        #endregion leave_message
        #region save_users

        private void save_users(HttpContext context)
        {
            try
            {
                string first_name = context.Request["first_name"];
                string last_name = context.Request["last_name"];
                string email = context.Request["email"];
                string pwd1 = context.Request["pwd1"];
                string address1 = context.Request["address1"];
                string address2 = context.Request["address2"];
                string city = context.Request["city"];
                string state = context.Request["state"];
                string zipcode = context.Request["zipcode"];
                string operation = context.Request["operation"];
                    MySqlCommand cmd;
                    if (operation == "SAVE")
                    {
                    cmd = new MySqlCommand("INSERT INTO users (first_name,last_name,email,pwd, address1,address2,city,state,zipcode) VALUES (@first_name,@last_name,@email,@pwd1, @address1,@address2,@city,@state,@zipcode)");
                    cmd.Parameters.Add("@first_name", first_name);
                    cmd.Parameters.Add("@last_name", last_name);
                    cmd.Parameters.Add("@email", email);
                    cmd.Parameters.Add("@pwd1", pwd1);
                    cmd.Parameters.Add("@address1", address1);//branch_sno
                    cmd.Parameters.Add("@address2", address2);//branch_sno
                    cmd.Parameters.Add("@city", city);//branch_sno
                    cmd.Parameters.Add("@state", state);//branch_sno
                    cmd.Parameters.Add("@zipcode", zipcode);//branch_sno
                        dbm.insert(cmd);
                    }
                    else if (operation == "Update_pwd")
                    {
                        string userid = context.Session["user_id"].ToString();
                        string pwd2 = context.Request["new_pwd1"].ToString();
                        string old_pwd = context.Request["old_pwd"].ToString();
                        cmd = new MySqlCommand("UPDATE  users SET pwd = @pwd2 WHERE(idusers = @userid) AND (pwd=@old_pwd)");
                        cmd.Parameters.Add("@userid", userid);//branch_sno
                        cmd.Parameters.Add("@old_pwd", old_pwd);//branch_sno
                        cmd.Parameters.Add("@pwd2", pwd2);//branch_sno
                        dbm.Update(cmd);
                    }
                    else
                    {
                        string userid = context.Session["user_id"].ToString();
                        string slct_month = context.Request["slct_month"].ToString();
                        string slct_day = context.Request["slct_day"].ToString();
                        string mobile_num = context.Request["Phone"].ToString();
                        cmd = new MySqlCommand("UPDATE  users SET first_name = @first_name,last_name=@last_name,email=@email,mobile_num=@mobile_num,dob_month=@dob_month,dob_day=@dob_day,address1=@address1,address2=@address2,city=@city,state=@state,zipcode=@zipcode WHERE(idusers = @userid)");
                        cmd.Parameters.Add("@userid", userid);//branch_sno
                        cmd.Parameters.Add("@first_name", first_name);
                        cmd.Parameters.Add("@last_name", last_name);
                        cmd.Parameters.Add("@email", email);
                        cmd.Parameters.Add("@mobile_num", mobile_num);
                        cmd.Parameters.Add("@dob_month", slct_month);
                        cmd.Parameters.Add("@dob_day", slct_day);
                        cmd.Parameters.Add("@address1", address1);//branch_sno
                        cmd.Parameters.Add("@address2", address2);//branch_sno
                        cmd.Parameters.Add("@city", city);//branch_sno
                        cmd.Parameters.Add("@state", state);//branch_sno
                        cmd.Parameters.Add("@zipcode", zipcode);//branch_sno
                        dbm.Update(cmd);
                    }
                    string msg = "Data Successfully Saved";
                    string response = GetJson(msg);
                    context.Response.Write(response);
               
            }
            catch (Exception ex)
            {
                string response = GetJson(ex.ToString());
                context.Response.Write(response);
            }
        }
        public class save_userss
        {
            public string sno { set; get; }
            public string first_name { set; get; }
            public string last_name { set; get; }
            public string email { set; get; }
            public string address1 { set; get; }
            public string address2 { set; get; }
            public string city { set; get; }
            public string state { set; get; }
            public string zipcode { set; get; }
            public string mobile_num { set; get; }
            public string dob_month { set; get; }
            public string dob_day { set; get; }
        }
        private void get_users(HttpContext context)
        {
            try
            {
                    MySqlCommand cmd;
                    string userid = context.Session["user_id"].ToString();
                    cmd = new MySqlCommand("SELECT users.* FROM users where(idusers=@userid)");
                    cmd.Parameters.Add("@userid", userid);
                    DataTable sessiondata = dbm.SelectQuery(cmd).Tables[0];
                    List<save_userss> geleavetypelist = new List<save_userss>();
                    foreach (DataRow dr in sessiondata.Rows)
                    {
                        save_userss ss = new save_userss();
                        ss.sno = dr["idusers"].ToString();
                        ss.first_name = dr["first_name"].ToString();
                        ss.last_name = dr["last_name"].ToString();
                        ss.email = dr["email"].ToString();
                        ss.mobile_num = dr["mobile_num"].ToString();
                        ss.dob_month = dr["dob_month"].ToString();
                        ss.dob_day = dr["dob_day"].ToString();
                        ss.address1 = dr["address1"].ToString();
                        ss.address2 = dr["address2"].ToString();
                        ss.city = dr["city"].ToString();
                        ss.state = dr["state"].ToString();
                        ss.zipcode = dr["zipcode"].ToString();
                        geleavetypelist.Add(ss);
                    }
                    string response = GetJson(geleavetypelist);
                    context.Response.Write(response);
                
            }
            catch (Exception ex)
            {
                string response = GetJson(ex.ToString());
                context.Response.Write(response);
            }
        }

        private void get_all_users(HttpContext context)
        {
            try
            {
                MySqlCommand cmd;
                cmd = new MySqlCommand("SELECT users.* FROM users");
                DataTable sessiondata = dbm.SelectQuery(cmd).Tables[0];
                List<save_userss> geleavetypelist = new List<save_userss>();
                foreach (DataRow dr in sessiondata.Rows)
                {
                    save_userss ss = new save_userss();
                    ss.sno = dr["idusers"].ToString();
                    ss.email = dr["email"].ToString();
                    geleavetypelist.Add(ss);
                }
                string response = GetJson(geleavetypelist);
                context.Response.Write(response);

            }
            catch (Exception ex)
            {
                string response = GetJson(ex.ToString());
                context.Response.Write(response);
            }
        }

        private void save_user_dates(HttpContext context)
        {
            try
            {
                string userid = context.Session["user_id"].ToString();
                string user_occasion = context.Request["user_occasion"];
                string slct_month = context.Request["slct_month"];
                string slct_day = context.Request["slct_day"];
                MySqlCommand cmd;
                {
                    cmd = new MySqlCommand("INSERT INTO users_dates (idusers,occasion,month,day) VALUES (@idusers,@occasion,@month,@day)");
                    cmd.Parameters.Add("@idusers", userid);
                    cmd.Parameters.Add("@occasion", user_occasion);
                    cmd.Parameters.Add("@month", slct_month);
                    cmd.Parameters.Add("@day", slct_day);
                    dbm.insert(cmd);
                }
                string msg = "Data Successfully Saved";
                string response = GetJson(msg);
                context.Response.Write(response);

            }
            catch (Exception ex)
            {
                string response = GetJson(ex.ToString());
                context.Response.Write(response);
            }
        }

        public class date_users
        {
            public string sno { set; get; }
            public string idusers { set; get; }
            public string occasion { set; get; }
            public string month { set; get; }
            public string day { set; get; }
        }
        private void get_dates_users(HttpContext context)
        {
            try
            {
                MySqlCommand cmd;
                string userid = context.Session["user_id"].ToString();
                cmd = new MySqlCommand("SELECT users_dates.id_dates, users_dates.idusers, users_dates.occasion, users_dates.month, users_dates.day FROM users INNER JOIN users_dates ON users.idusers = users_dates.idusers WHERE  (users.idusers = @idusers) ORDER BY users_dates.month, users_dates.day ASC");
                cmd.Parameters.Add("@idusers", userid);
                DataTable sessiondata = dbm.SelectQuery(cmd).Tables[0];
                List<date_users> geleavetypelist = new List<date_users>();
                foreach (DataRow dr in sessiondata.Rows)
                {
                    date_users ss = new date_users();
                    ss.sno = dr["id_dates"].ToString();
                    ss.idusers = dr["idusers"].ToString();
                    ss.occasion = dr["occasion"].ToString();
                    ss.month = dr["month"].ToString();
                    ss.day = dr["day"].ToString();
                    geleavetypelist.Add(ss);
                }
                string response = GetJson(geleavetypelist);
                context.Response.Write(response);

            }
            catch (Exception ex)
            {
                string response = GetJson(ex.ToString());
                context.Response.Write(response);
            }
        }


        #endregion save_users

        #region add_comments

        private void add_comment(HttpContext context)
        {
            try
            {
                string name = context.Request["name"];
                string idpost_question = context.Request["comment_sno"];
                string answer = context.Request["answer"];
                //string operation = context.Request["operation"];
                //string sno = context.Request["budget_cat_sno"];
                MySqlCommand cmd;
                //if (operation == "SAVE")
                //{
                cmd = new MySqlCommand("INSERT INTO add_comment (name,answer,idpost_question) VALUES (@name, @answer, @idpost_question)");
                cmd.Parameters.Add("@name", name);
                cmd.Parameters.Add("@answer", answer);
                cmd.Parameters.Add("@idpost_question", idpost_question);
                dbm.insert(cmd);
                //}
                //else
                //{
                //    cmd = new MySqlCommand("UPDATE  budget_category SET budget_category_name = @budget_category_name, budget_cat_desc = @budget_cat_desc, status = @status WHERE (branch_sno = @branch_sno) AND (idbudget_category = @sno)");
                //    cmd.Parameters.Add("@sno", sno);//branch_sno
                //    cmd.Parameters.Add("@budget_category_name", Category_name);
                //    cmd.Parameters.Add("@budget_cat_desc", Description);
                //    cmd.Parameters.Add("@status", status);
                //    cmd.Parameters.Add("@branch_sno", branchid);//branch_sno
                //    dbm.Update(cmd);
                //}

                string msg = "Data Successfully Saved";
                string response = GetJson(msg);
                context.Response.Write(response);

            }
            catch (Exception ex)
            {
                string response = GetJson(ex.ToString());
                context.Response.Write(response);
            }
        }
        public class add_comments
        {
            public string sno { set; get; }
            public string idpost_question { set; get; }
            public string commented_by { set; get; }
            public string commented_time { set; get; }
            public string answer { set; get; }
        }
        private void get_add_comments(HttpContext context)
        {
            try
            {
                string idpost_question = context.Request["comment_sno"];
                MySqlCommand cmd;
                cmd = new MySqlCommand("SELECT idadd_comment, name, answer, comment_time, idpost_question FROM add_comment WHERE  (idpost_question = @idpost_question) ORDER BY idadd_comment DESC");
                cmd.Parameters.Add("@idpost_question", idpost_question);
                DataTable sessiondata = dbm.SelectQuery(cmd).Tables[0];
                List<add_comments> geleavetypelist = new List<add_comments>();
                foreach (DataRow dr in sessiondata.Rows)
                {
                    add_comments ss = new add_comments();
                    ss.sno = dr["idadd_comment"].ToString();
                    ss.commented_by = dr["name"].ToString();
                    ss.answer = dr["answer"].ToString();
                    ss.commented_time = dr["comment_time"].ToString();
                    ss.idpost_question = dr["idpost_question"].ToString();
                    geleavetypelist.Add(ss);
                }
                string response = GetJson(geleavetypelist);
                context.Response.Write(response);

            }
            catch (Exception ex)
            {
                string response = GetJson(ex.ToString());
                context.Response.Write(response);
            }
        }

        #endregion add_comments

        #region post_discussion

        private void post_discussion(HttpContext context)
        {
            try
            {
                string name = context.Request["name"];
                string email = context.Request["email"];
                string subject = context.Request["subject"];
                string question = context.Request["message"];
                //string operation = context.Request["operation"];
                //string sno = context.Request["budget_cat_sno"];
                MySqlCommand cmd;
                //if (operation == "SAVE")
                //{
                cmd = new MySqlCommand("INSERT INTO post_question (posted_by,email,subject, question) VALUES (@posted_by, @email, @subject, @question)");
                cmd.Parameters.Add("@posted_by", name);
                cmd.Parameters.Add("@email", email);
                cmd.Parameters.Add("@subject", subject);
                cmd.Parameters.Add("@question", question);//branch_sno
                dbm.insert(cmd);
                //}
                //else
                //{
                //    cmd = new MySqlCommand("UPDATE  budget_category SET budget_category_name = @budget_category_name, budget_cat_desc = @budget_cat_desc, status = @status WHERE (branch_sno = @branch_sno) AND (idbudget_category = @sno)");
                //    cmd.Parameters.Add("@sno", sno);//branch_sno
                //    cmd.Parameters.Add("@budget_category_name", Category_name);
                //    cmd.Parameters.Add("@budget_cat_desc", Description);
                //    cmd.Parameters.Add("@status", status);
                //    cmd.Parameters.Add("@branch_sno", branchid);//branch_sno
                //    dbm.Update(cmd);
                //}

                string msg = "Data Successfully Saved";
                string response = GetJson(msg);
                context.Response.Write(response);

            }
            catch (Exception ex)
            {
                string response = GetJson(ex.ToString());
                context.Response.Write(response);
            }
        }
        public class post_discussions
        {
            public string sno { set; get; }
            public string posted_by { set; get; }
            public string post_time { set; get; }
            public string subject { set; get; }
            public string question { set; get; }
        }
        private void get_posted_questions(HttpContext context)
        {
            try
            {
                MySqlCommand cmd;
                cmd = new MySqlCommand("SELECT post_question.* FROM post_question ORDER BY idpost_question DESC");
                DataTable sessiondata = dbm.SelectQuery(cmd).Tables[0];
                List<post_discussions> geleavetypelist = new List<post_discussions>();
                foreach (DataRow dr in sessiondata.Rows)
                {
                    post_discussions ss = new post_discussions();
                    ss.sno = dr["idpost_question"].ToString();
                    ss.posted_by = dr["posted_by"].ToString();
                    ss.post_time = dr["post_time"].ToString();
                    ss.subject = dr["subject"].ToString();
                    ss.question = dr["question"].ToString();
                    geleavetypelist.Add(ss);
                }
                string response = GetJson(geleavetypelist);
                context.Response.Write(response);

            }
            catch (Exception ex)
            {
                string response = GetJson(ex.ToString());
                context.Response.Write(response);
            }
        }

        #endregion post_discussion



        #region fb_feeds

        class Posts
        {
            public string PostId { get; set; }
            public string PostStory { get; set; }
            public string PostMessage { get; set; }
            public string PostPictureUri { get; set; }
            public Image PostImage { get; set; }
            public string UserId { get; set; }
            public string UserName { get; set; }

        }


        private List<Posts> getFBPosts(HttpContext context)
        {
            //Facebook.FacebookClient myfacebook = new Facebook.FacebookClient();
            string AppId = "";
            string AppSecret = "";
            var client = new WebClient();

            string oauthUrl = string.Format("https://graph.facebook.com/oauth/access_token?type=client_cred&client_id={0}&client_secret={1}", AppId, AppSecret);

            string accessToken = client.DownloadString(oauthUrl).Split('=')[1];

            FacebookClient myfbclient = new FacebookClient(accessToken);
            var parameters = new Dictionary<string, object>();
            parameters["fields"] = "id,message,full_picture ";
            string myPage = "288142251268992"; // put your page name
            dynamic result = myfbclient.Get(myPage + "/posts", parameters);

            List<Posts> postsList = new List<Posts>();
            int mycount = result.data.Count;

            for (int i = 0; i < result.data.Count; i++)
            {
                Posts posts = new Posts();
                posts.PostId = result.data[i].id;
                posts.PostPictureUri = result.data[i].full_picture;
                posts.PostMessage = result.data[i].message;
                if (posts.PostPictureUri != null)
                {
                    var request = WebRequest.Create(posts.PostPictureUri);
                    using (var response = request.GetResponse())
                    using (var stream = response.GetResponseStream())
                    {
                        posts.PostImage = Bitmap.FromStream(stream);
                    }
                }
                else
                {
                }
                
                postsList.Add(posts);
            }
            string response5 = GetJson(postsList);
            context.Response.Write(response5);
            return postsList;

        }

        #endregion fb_feeds

        #region ads_enable

        public class ads
        {
            public string Name { set; get; }
            public string sno { set; get; }
            public string status { set; get; }
        }
        private void getAdsDetails_actuals(HttpContext context)
        {
            try
            {

                MySqlCommand cmd;
                cmd = new MySqlCommand("SELECT  Ab_ads.ads_id, Ab_ads.Name, Ab_ads.status FROM Ab_ads");
                DataTable leaddata = dbm.SelectQuery(cmd).Tables[0];
                List<ads> getAddleadslist = new List<ads>();
                foreach (DataRow dr in leaddata.Rows)
                {
                    ads ss = new ads();
                    ss.sno = dr["ads_id"].ToString();
                    ss.Name = dr["Name"].ToString();
                    ss.status = dr["status"].ToString();
                    getAddleadslist.Add(ss);
                }
                string response = GetJson(getAddleadslist);
                context.Response.Write(response);

            }
            catch (Exception ex)
            {
                string response = GetJson(ex.ToString());
                context.Response.Write(response);
            }
        }
        #endregion ads_enable

        private void forgotpasswordclick_login(HttpContext context)
        {
            string username = context.Request["username"];
            MySqlCommand cmd;
            cmd = new MySqlCommand("SELECT employees.fullname,employees.email, employees.idemployees, employee_logins.sno AS emp_login_sno, employee_logins.password, employee_logins.role, employees.employee_num, employees.branch_sno, branches.branch_name, employee_login_depts.dept_sno, page_names.url,  page_names.status AS pagestatus, departments_pages.page_names_sno, page_names.page_id,employees.photos FROM departments_pages INNER JOIN employee_login_depts ON departments_pages.departmnt_sno = employee_login_depts.dept_sno INNER JOIN page_names ON departments_pages.page_names_sno = page_names.sno RIGHT OUTER JOIN employees INNER JOIN employee_logins ON employees.idemployees = employee_logins.employee_sno INNER JOIN branches ON employees.branch_sno = branches.sno ON employee_login_depts.employee_logins_sno = employee_logins.sno WHERE (employees.employee_num = @employee_num)");
            cmd.Parameters.Add("@employee_num", username);
            DBMgr dbm = new DBMgr();
            DataTable dt = dbm.SelectQuery(cmd).Tables[0];
            string value = "false";
            List<forgotpasswordclick_logincls> forgotpasswordclickloginclslsit = new List<forgotpasswordclick_logincls>();
            if (dt.Rows.Count > 0)
            {
                forgotpasswordclick_logincls forgotpasswordclicklogincls = new forgotpasswordclick_logincls();
                forgotpasswordclicklogincls.fpuserid = dt.Rows[0]["employee_num"].ToString();
                forgotpasswordclicklogincls.fpuser = dt.Rows[0]["fullname"].ToString();
                forgotpasswordclicklogincls.fpemail = dt.Rows[0]["email"].ToString();
                forgotpasswordclicklogincls.fpphoto = dt.Rows[0]["photos"].ToString();
                forgotpasswordclickloginclslsit.Add(forgotpasswordclicklogincls);
            }
            string strresponse = GetJson(forgotpasswordclickloginclslsit);
            context.Response.Write(strresponse);
        }
        public class forgotpasswordclick_logincls
        {
            public string fpuserid { set; get; }
            public string fpuser { set; get; }
            public string fpemail { set; get; }
            public string fpphoto { set; get; }
        }

        private void send_forgotpasswordmail(HttpContext context)
        {
            try
            {
                string userid = context.Request["userid"];
                string username = context.Request["username"];
                string txt_email = context.Request["txt_email"];
                MySqlCommand cmd;
                cmd = new MySqlCommand("SELECT employee_logins.password FROM departments_pages INNER JOIN employee_login_depts ON departments_pages.departmnt_sno = employee_login_depts.dept_sno INNER JOIN page_names ON departments_pages.page_names_sno = page_names.sno RIGHT OUTER JOIN employees INNER JOIN employee_logins ON employees.idemployees = employee_logins.employee_sno INNER JOIN branches ON employees.branch_sno = branches.sno ON employee_login_depts.employee_logins_sno = employee_logins.sno WHERE (employees.employee_num = @employee_num)");
                cmd.Parameters.Add("@employee_num", userid);
                DBMgr dbm = new DBMgr();
                DataTable dt = dbm.SelectQuery(cmd).Tables[0];
                if (dt.Rows.Count > 0)
                {
                    string userpassword = dt.Rows[0]["password"].ToString();
                    string emailid = txt_email;
                    MailMessage Msg = new MailMessage();
                    MailAddress fromMail = new MailAddress("");
                    // Sender e-mail address.
                    Msg.From = fromMail;
                    const string password = "";
                    // Recipient e-mail address.
                    if (emailid == "")
                    {
                        emailid = "";
                    }
                    Msg.To.Add(new MailAddress(emailid));
                    // Subject of e-mail
                    Msg.Subject = "";
                    Msg.Body += "<div style='background-color: #9fd5e8; font-family: Arial,Helvetica,sans-serif; font-size: 12px'><div style='width: 630px; height: 20px; padding: 10px;'></div><div style='width: 630px; min-height: 20px; padding: 10px; margin: 0 auto; background-color: white;'><p><div style='font-size: 35px; text-align: center; margin-bottom: 25px; font-weight: 300;'><a><b>MyEdu</b>BOX</a></div><br /><br />Hi " + username + "<br /><br />You are receiving this e - mail because we recently received a forgot password request.<br /><br />Your password is <label style='color: darkblue; font-weight: bold; font-size: 20px;'>" + userpassword + "</label></p></div><div style='width: 630px; height: 20px; padding: 10px;'></div></div>";
                    Msg.IsBodyHtml = true;
                    string sSmtpServer = "";
                    sSmtpServer = "smtp.gmail.com";
                    int portNumber = 587;
                    SmtpClient a = new SmtpClient(sSmtpServer, portNumber);
                    a.Host = sSmtpServer;
                    a.Credentials = new NetworkCredential("", password);
                    a.EnableSsl = true;
                    a.Send(Msg);

                    string strresponse = GetJson("Password successfully sent to your email!");
                    context.Response.Write(strresponse);
                }
                else
                {
                    string strresponse = GetJson("Invalid request!");
                    context.Response.Write(strresponse);
                }
            }
            catch
            {
                string strresponse = GetJson("Invalid request!");
                context.Response.Write(strresponse);
            }
        }

        public class clsScheduleMail
        {
            public clsScheduleMail()
            {

            }

            public void SendScheduleMail()
            {
                // Write your send mail code here.
            }
        }

        private static string GetJson(object obj)
        {
            JavaScriptSerializer jsonSerializer = new JavaScriptSerializer();
            jsonSerializer.MaxJsonLength = int.MaxValue;
            return jsonSerializer.Serialize(obj);
        }
    }
}

