<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage3.master" AutoEventWireup="true" CodeFile="Change-password.aspx.cs" Inherits="Change_password" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <link href="css/signup.css" rel="stylesheet" type="text/css" />
    <script src="CustomJS/signup.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function () {
        get_users();
    });

    function empty_leave_message() {
        document.getElementById('old_pwd').value = "";
        document.getElementById('new_pwd1').value = "";
        document.getElementById('new_pwd2').value = "";
    }


    function update_users() {
        var old_pwd = document.getElementById('old_pwd').value;
        if (old_pwd == null || old_pwd == "" || old_pwd == " ") {
            document.getElementById("old_pwd").focus();
            return false;
        }

        var new_pwd1 = document.getElementById('new_pwd1').value;
        if (new_pwd1 == null || new_pwd1 == "" || new_pwd1 == " ") {
            document.getElementById("new_pwd1").focus();
            return false;
        }

        var new_pwd2 = document.getElementById('new_pwd2').value;
        if (new_pwd2 == null || new_pwd2 == "" || new_pwd2 == " ") {
            document.getElementById("new_pwd2").focus();
            return false;
        }
        var operation = "Update_pwd";
        if (new_pwd1 == new_pwd2) {
            loading_gif_start();
            var data = { 'op': 'save_users', "new_pwd1": new_pwd1, 'old_pwd': old_pwd, 'operation': operation };
        }
        else {
            $("#password_check").css("display", "block");
            empty_leave_message();
            return false;
        }
        var s = function (msg) {
            if (msg) {
                if (msg == "Data Successfully Saved") {
                    loading_gif_stop();
                    Message_success();
                    empty_leave_message();
                    get_users();
                }
                else {
                    loading_gif_stop();
                    Message_failed();
                    empty_leave_message();
                }

            }
            else {
                document.location = "Default.aspx";
            }
        }
        var e = function (x, h, e) {
            alert(e.toString());
        };
        callHandler(data, s, e);
        check_data();
        loading_gif_start();
    }

    function check_data() {
        $("#error_msg").css("display", "none");

    }
    function chck_validate() {
        $("#error_msg").css("display", "block");

    }
    function loading_gif_start() {

        $("#gif_load").css("display", "block");


    }
    function loading_gif_stop() {

        $("#gif_load").css("display", "none");


    }


    function Message_success() {
        $("#Message_failed").css("display", "none");
        $("#Message_success").css("display", "block");
        setTimeout(function () {
            $('#Message_success').fadeOut('fast');
        }, 6000);
    }
    function Message_failed() {
        $("#Message_failed").css("display", "block");
        $("#Message_success").css("display", "none");
        setTimeout(function () {
            $('#Message_failed').fadeOut('fast');
        }, 6000);

    }


    var questionsdata;
    function get_users() {
        var results = " ";
        var data = { 'op': 'get_users' };
        var s = function (msg) {
            if (msg) {
                questionsdata = msg;
                $('#div_load').show(); // hide the image when example.php is loaded
                for (var i = 0; i < 3; i++) {
                    if (questionsdata[i].sno != null) {
                        results += '<div class="col s12 m4 l4">';
                        results += '<div class="blog-post">';
                        results += '<div class="card">';
                        results += '<div class="card-content blog-post-content">';
                        results += ' <br /><br />';
                        results += '<h2><a href="blog.aspx">' + questionsdata[i].subject + '</a></h2>';
                        results += '<div class="meta-media">';
                        results += '<div class="single-meta">';
                        results += 'Post By <a href="#">' + questionsdata[i].posted_by + '</a></div></br>';
                        var datetime = new Date('' + questionsdata[i].post_time + '');
                        var day = datetime.getDate();
                        var month = datetime.getMonth() + 1; //month: 0-11
                        var year = datetime.getFullYear();
                        var date = month + "-" + day + "-" + year;
                        var hours = datetime.getHours();
                        var minutes = datetime.getMinutes();
                        if (minutes < 10) {
                            var time = hours + ":0" + minutes;
                        }
                        else {
                            var time = hours + ":" + minutes;
                        }

                        var datetim = date + "/ " + time;
                        results += '<div class="single-meta">Posted Time : <a href="#">' + datetim + '</a></div></div>';
                        var string = ' ' + questionsdata[i].question + ' ';
                        var length = 250;
                        var trimmedString = string.substring(0, length);
                        results += '<p>' + trimmedString + '</p>';
                        results += '</div></div></div></div>';
                        $("#posted_questions").html(results);
                    }

                }
                $('#div_load').hide(); // hide the image when example.php is loaded

            }
            else {
                document.location = "Default.aspx";
            }
        }
        var e = function (x, h, e) {
            alert(e.toString());
        };
        callHandler(data, s, e);
    }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="container">
			<form action="#" class="sky-form" style="background-color:#40a3a9">
				<header>Change Password</header>
                <fieldset>
					<div class="row">
						<section>
							<label class="input">
							<i class="icon-append icon-lock"></i>
								<input id="old_pwd" type="text"  placeholder="Old Password">
							<b class="tooltip tooltip-bottom-right">Please Provide valid Old Password</b>
							</label>
						</section>
					<section>
						<label class="input">
							<i class="icon-append icon-lock"></i>
							<input type="password" id="new_pwd1" placeholder=" New Password">
							<b class="tooltip tooltip-bottom-right">Please provide unique New Password</b>
						</label>
					</section>
					<section>
						<label class="input">
							<i class="icon-append icon-lock"></i>
							<input type="password" id="new_pwd2" placeholder="Confirm New password">
							<b class="tooltip tooltip-bottom-right">Please confirm New Password</b>
						</label>
					</section>
				<footer>
					<button type="button" onclick="update_users();" class="button">Update</button>
					<a class="button" href="user-details.aspx">About Me</a>
					<a class="button" href="Add-dates.aspx">Add Dates</a>
                 <div id="gif_load" style="display:none;" ><img  src="img/loader.gif" alt="" style="height:40px;width:40px"/><br /></div> <br />
                 <br />
                 <br /><br />
                 <section>
                 <div class="col col-12" id="password_check" style="display:none;">
                          <div class="col col-12">
                           <section class="col col-12">
                           <br />
                           <br />
                              <p ><center style="color:Red;"><h5>New password doesn't matches,Please enter again</h5></center></p>
                              </section>
                      </div>
                    </div>
                  <div class="col col-12" id="Message_success" style="display:none;">
                          <div class="col col-12">

                           <section class="col col-12">
                            <div >
                            <br />
                           <br />
                              <p ><center style="color:green"><h5>Password updated successfully!</h5></center></p>
                              </div>
                              </section>
                      </div>
                    </div>
                    <div class="col col-12" id="Message_failed" style="display:none;">
                      <div class="col col-12">
                           <section class="col col-12">
                            <div >
                            <br />
                           <br />
                              <p ><center style="color:red;font-family: "Roboto", sans-serif;"><h5>Sorry, Updating Failed and  try again later  <a href="contact-us.aspx" style="color:green;"/>Contact us </a></h5></center></p>
                              </div>
                              </section>
                      </div>
                    </div>
                    </section>
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
				</footer>
			</form>
		</div>
</asp:Content>

