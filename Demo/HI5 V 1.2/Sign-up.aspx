<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage3.master" AutoEventWireup="true" CodeFile="Sign-up.aspx.cs" Inherits="Signup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
  <link href="css/signup.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
    $(function () {
        get_all_users();
    });

    function empty_leave_message() {
        document.getElementById('first_name').value = " ";
        document.getElementById('last_name').value = " ";
        document.getElementById('email').value = " ";
        document.getElementById('pwd1').value = "";
        document.getElementById('pwd2').value = "";
        document.getElementById('address1').value = "";
        document.getElementById('address2').value = ""
        document.getElementById('city').value = "";
        document.getElementById('state').value = "";
        document.getElementById('zipcode').value = "";
        check_data();
    }
  function reset_pwd(){
        document.getElementById('pwd1').value = "";
        document.getElementById('pwd2').value = "";

  }

    function save_users() {
        loading_gif_start();
        var first_name = document.getElementById('first_name').value;
        if (first_name == null || first_name == "" || first_name == " ") {
            document.getElementById("first_name").focus();
            chck_validate();
            return false;
        }
        var last_name = document.getElementById('last_name').value;
        if (last_name == null || last_name == "" || last_name == " ") {
            document.getElementById("last_name").focus();
            chck_validate();
            return false;
        }

        var email = document.getElementById('email').value;
            var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            if (!filter.test(email)) {
                document.getElementById("email").focus();
                return false;
            }
        var pwd1 = document.getElementById('pwd1').value;
        if (pwd1 == null || pwd1 == "" || pwd1 == " ") {
            document.getElementById("pwd1").focus();
            chck_validate();
            return false;
        }

        var pwd2 = document.getElementById('pwd2').value;
        if (pwd2 == null || pwd2 == "" || pwd2 == " ") {
            document.getElementById("pwd2").focus();
            return false;
        }

        var address1 = document.getElementById('address1').value;
        if (address1 == null || address1 == "" || address1 == " ") {
            document.getElementById("address1").focus();
            chck_validate();
            return false;
        }

        var address2 = document.getElementById('address2').value;
        
        var city = document.getElementById('city').value;
        if (city == null || city == "" || city == " ") {
            document.getElementById("city").focus();
            chck_validate();
            return false;
        }

        var state = document.getElementById('state').value;
        if (state == null || state == "" || state == " ") {
            document.getElementById("state").focus();
            chck_validate();
            return false;
        }

        var zipcode = document.getElementById('zipcode').value;
        if (zipcode == null || zipcode == "" || zipcode == " ") {
            document.getElementById("zipcode").focus();
            chck_validate();
            return false;
        }
        var operation = "SAVE";
        if(pwd1==pwd2){
            var data = { 'op': 'save_users', 'first_name': first_name, "last_name": last_name, "email": email, "pwd1": pwd1, "address1": address1, "address2": address2, "city": city, "state": state, "zipcode": zipcode, 'operation': operation };
        }
    else {
        $("#password_check").css("display", "block");
        reset_pwd();
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
    function get_all_users() {
        var data = { 'op': 'get_all_users' };
        var s = function (msg) {
            if (msg) {
                questionsdata = msg;

            }
        }
        var e = function (x, h, e) {
            alert(e.toString());
        };
        callHandler(data, s, e);
    }

    function check_username() {
        var check_username = document.getElementById("email").value;
        for (i = 0; i <questionsdata.length; i++) {
            if (check_username.toUpperCase() === questionsdata[i].email.toUpperCase()) {
                alert("Please choose different Username");
                document.getElementById("email").value="";
                document.getElementById("email").focus();
                return false;
            }
        }

    }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
		<div class="container">
			<form action="#" class="sky-form" style="background-color:#40a3a9">
				<header>Sign Up form</header>
                <fieldset>
					<div class="row">
						<section class="col col-6">
							<label class="input">
								<input id="first_name" type="text" placeholder="First name">
							<b class="tooltip tooltip-bottom-right">Please Provide valid First Name</b>
							</label>
						</section>
						<section class="col col-6">
							<label class="input">
								<input type="text" id="last_name" placeholder="Last name">
							<b class="tooltip tooltip-bottom-right">Please Provide valid Last Name</b>
							</label>
						</section>
					</div>
					<section>
						<label class="input">
							<i class="icon-append icon-envelope-alt"></i>
							<input type="email" id="email" onblur="check_username();" placeholder="Email address" >
							<b class="tooltip tooltip-bottom-right">Please Provide valid Email Address</b>
						</label>
					</section>
					
					<section>
						<label class="input">
							<i class="icon-append icon-lock"></i>
							<input type="password" id="pwd1" placeholder="Password">
							<b class="tooltip tooltip-bottom-right">Please provide unique Password</b>
						</label>
					</section>
					
					<section>
						<label class="input">
							<i class="icon-append icon-lock"></i>
							<input type="password" id="pwd2" placeholder="Confirm password">
							<b class="tooltip tooltip-bottom-right">Please confirm Password</b>
						</label>
					</section>
                    <section>
						<label class="input">
							<input type="text" id="address1" placeholder="Address1">
							<b class="tooltip tooltip-bottom-right"> Please provide Valid Address</b>
						</label>
					</section>
                    <section>
						<label class="input">
							<input type="text"id="address2" placeholder="Address2">
							<b class="tooltip tooltip-bottom-right">Optional</b>
						</label>
					</section>

                    <div class="row">
						<section class="col col-4">
							<label class="input">
								<input type="text" id="city" placeholder="City">
							<b class="tooltip tooltip-bottom-right">Please provide valid city</b>
                                
							</label>
						</section>
						<section class="col col-4">
							<label class="input">
								<input type="text" id="state" placeholder="State">
							<b class="tooltip tooltip-bottom-right">Please provide valid state</b>
							</label>
                            </section>
                            <section class="col col-4">
							<label class="input">
								<input type="number" id="zipcode" placeholder="Zipcode">
							<b class="tooltip tooltip-bottom-right">Please provide valid Zipcode</b>
							</label>


						</section>
					</div>
				</fieldset>
				<footer>
					<button type="button" onclick="save_users();" class="button">Submit</button><br />
                 <br />
                 <br /><br />
                 <section>
                    <div class="col col-12" id="password_check" style="display:none;">
                          <div class="col col-12">
                           <section class="col col-12">
                           <br />
                           <br />
                              <p ><center style="color:Red;"><h6>Passwords doesn't match,Please enter again</h6></center></p>
                              </section>
                      </div>
                    </div>
                  <div class="col col-12" id="Message_success" style="display:none;">
                          <div class="col col-12">
                 <div id="gif_load" style="display:none;" ><img  src="img/loader.gif" alt="" style="height:40px;width:40px"/><br /></div> <br />

                           <section class="col col-12">
                            <div >

                              <p ><center style="color:green"><h5>Thank you,you have been Signed Up Successfully and now you can <a href="Login.aspx" style="color:red;"/>Login here </a></h5></center></p>
                              </div>
                              </section>
                      </div>
                    </div>
                    <div class="col col-12" id="Message_failed" style="display:none;">
                      <div class="col col-12">
                           <section class="col col-12">
                            <div >
                              <p ><center style="color:red"><h5>Sorry, Signing Up Failed and  try to  <a href="Login.aspx" style="color:green;"/>Contact us </a></h5></center></p>
                              </div>
                              </section>
                      </div>
                    </div>
                    </section>
				</footer>
			</form>
		</div>
</asp:Content>

