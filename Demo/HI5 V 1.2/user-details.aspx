<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="user-details.aspx.cs" Inherits="user_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
  <link href="css/signup.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
    $(function () {
        get_users();

    });

    function feb() {

    }

 
    function save_users() {
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
        var Phone = document.getElementById('phone').value;
        if (Phone == null || Phone == "" || Phone == " ") {
            document.getElementById("phone").focus();
            chck_validate();
            return false;
        }

        var slct_month = document.getElementById('slct_month').value;
        if (slct_month == null || slct_month == "" || slct_month == "0") {
            document.getElementById("slct_month").focus();
            return false;
        }

        var slct_day = document.getElementById('slct_day').value;
        if (slct_day == null || slct_day == "" || slct_day == "0") {
            document.getElementById("slct_day").focus();
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

        var operation = "user_modify";
        loading_gif_start();
        var data = { 'op': 'save_users', 'first_name': first_name, "last_name": last_name, "email": email,"Phone":Phone, "slct_month": slct_month,"slct_day":slct_day, "address1": address1, "address2": address2, "city": city, "state": state, "zipcode": zipcode, 'operation': operation };
        var s = function (msg) {
            if (msg) {
                if (msg == "Data Successfully Saved") {
                    loading_gif_stop();
                    Message_success();
                    get_users();
                    $("#update").css("display", "none");
                    $("#edit").css("display", "block");
                }
                else {
                    loading_gif_stop();
                    Message_failed();
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


    var usersdata;
    function get_users() {
        var data = { 'op': 'get_users' };
        var s = function (msg) {
            if (msg) {
                usersdata = msg;
                for (var i = 0; i < 1; i++) {
                    if (usersdata[i].sno != null) {
                        var user_name = "Welcome " + usersdata[i].first_name;
                        $("#user_name").html(user_name);
                        document.getElementById("first_name").value = usersdata[i].first_name;
                        document.getElementById("first_name").disabled = true;
                        $("#first_name").css("background-color", "#d4d2bf");
                        document.getElementById("last_name").value = usersdata[i].last_name;
                        document.getElementById("last_name").disabled = true;
                        $("#last_name").css("background-color", "#d4d2bf");
                        document.getElementById("email").value = usersdata[i].email;
                        document.getElementById("email").disabled = true;
                        $("#email").css("background-color", "#d4d2bf");
                        document.getElementById("phone").value = usersdata[i].mobile_num;
                        document.getElementById("phone").disabled = true;
                        $("#phone").css("background-color", "#d4d2bf");
                        document.getElementById("slct_month").selectedIndex = usersdata[i].dob_month;
                        document.getElementById("slct_month").disabled = true;
                        $("#slct_month").css("background-color", "#d4d2bf");
                        document.getElementById("slct_day").selectedIndex = usersdata[i].dob_day;
                        document.getElementById("slct_day").disabled = true;
                        $("#slct_day").css("background-color", "#d4d2bf");
                        document.getElementById("address1").value = usersdata[i].address1;
                        document.getElementById("address1").disabled = true;
                        $("#address1").css("background-color", "#d4d2bf");
                        document.getElementById("address2").value = usersdata[i].address2;
                        document.getElementById("address2").disabled = true;
                        $("#address2").css("background-color", "#d4d2bf");
                        document.getElementById("city").value = usersdata[i].city;
                        document.getElementById("city").disabled = true;
                        $("#city").css("background-color", "#d4d2bf");
                        document.getElementById("state").value = usersdata[i].state;
                        document.getElementById("state").disabled = true;
                        $("#state").css("background-color", "#d4d2bf");
                        document.getElementById("zipcode").value = usersdata[i].zipcode;
                        document.getElementById("zipcode").disabled = true;
                        $("#zipcode").css("background-color", "#d4d2bf");

                    }

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
    }

    function Edit_details() {
        document.getElementById("first_name").disabled = false;
        $("#first_name").css("background-color", "#fff");
        document.getElementById("last_name").disabled = false;
        $("#last_name").css("background-color", "#fff");
        document.getElementById("phone").disabled = false;
        $("#phone").css("background-color", "#fff");
        document.getElementById("slct_month").disabled = false;
        $("#slct_month").css("background-color", "#fff");
        document.getElementById("slct_day").disabled = false;
        $("#slct_day").css("background-color", "#fff");
        document.getElementById("address1").disabled = false;
        $("#address1").css("background-color", "#fff");
        document.getElementById("address2").disabled = false;
        $("#address2").css("background-color", "#fff");
        document.getElementById("city").disabled = false;
        $("#city").css("background-color", "#fff");
        document.getElementById("state").disabled = false;
        $("#state").css("background-color", "#fff");
        document.getElementById("zipcode").disabled = false;
        $("#zipcode").css("background-color", "#fff");
        $("#update").css("display", "block");
        $("#edit").css("display", "none");
        document.getElementById("first_name").focus();

    }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
		<div class="container">
			<form action="#" class="sky-form" style="background-color:#40a3a9">
				<header id="user_name" style="color:Red;"></header>
                <fieldset>
					<div class="row" >
						<section class="col col-6">
							<label class="input">
								<input id="first_name"  type="text" placeholder="First name">
							<b class="tooltip tooltip-bottom-right">Now you can Edit your details</b>
							</label>
						</section>
						<section class="col col-6">
							<label class="input">
								<input type="text" id="last_name" placeholder="Last name">
							</label>
						</section>
					</div>
					<section>
						<label class="input">
							<input type="email" id="email"  placeholder="Email address">
						</label>
					</section>
					
					<section>
						<label class="input">
							<input type="number" id="phone" placeholder="Mobile Number">
						</label>
					</section>
					
					<div class="row">
						<section class="col col-6">
							<label class="select">
                            <select id="slct_month">
                            <option selected value='0'>--Select DOB Month--</option>
    <option  value='1'>Janaury</option>
    <option value='2'>February</option>
    <option value='3'>March</option>
    <option value='4'>April</option>
    <option value='5'>May</option>
    <option value='6'>June</option>
    <option value='7'>July</option>
    <option value='8'>August</option>
    <option value='9'>September</option>
    <option value='10'>October</option>
    <option value='11'>November</option>
    <option value='12'>December</option></select>
							</label>
                            </section>
						<section class="col col-6">
							<label class="select">
								<select id="slct_day">
                            <option selected value='0'>--Select DOB Day--</option>
                                 <option  value='1'>1</option>
                                  <option  value='2'>2</option>
                                  <option  value='3'>3</option>
                                  <option  value='4'> 4</option>
                                  <option  value='5'> 5</option>
                                  <option  value='6'>6 </option>
                                  <option  value='7'> 7</option>
                                  <option  value='8'>8 </option>
                                  <option  value='9'>9 </option>
                                  <option  value='10'>10 </option>
                                  <option  value='11'>11 </option>
                                  <option  value='12'>12 </option>
                                  <option  value='13'>13 </option>
                                  <option  value='14'> 14</option>
                                  <option  value='15'> 15</option>
                                  <option  value='16'>16 </option>
                                   <option  value='17'>17 </option>
                                  <option  value='18'> 18</option>
                                  <option  value='19'>19 </option>
                                  <option  value='20'>20 </option>
                                  <option  value='21'>21 </option>
                                  <option  value='22'>22 </option>
                                  <option  value='23'>23 </option>
                                  <option  value='24'>24 </option>
                                  <option  value='25'>25 </option>
                                  <option  value='26'>26 </option>
                                  <option  value='27'>27 </option>
                                  <option  value='28'>28 </option>
                                  <option  value='29'>29 </option>
                                  <option  value='30'>30 </option>
                                  <option  value='31'>31 </option>
                                 </select>
							</label>
						</section>
					</div>
                    <section>
						<label class="input">
							<input type="text" id="address1">
						</label>
					</section>
                    <section>
						<label class="input">
							<input type="text"id="address2">
						</label>
					</section>

                    <div class="row">
						<section class="col col-4">
							<label class="input">
								<input type="text" id="city">
							</label>
						</section>
						<section class="col col-4">
							<label class="input">
								<input type="text" id="state">
							</label>
                            </section>
                            <section class="col col-4">
							<label class="input">
								<input type="number" id="zipcode">
							</label>


						</section>
					</div>
				</fieldset>
				<footer>
					<button type="button" id="edit" onclick="Edit_details();" class="button">Edit Details</button>
					<button type="button" id="update" style="display:none;" onclick="save_users();" class="button">Update Details</button>
					<a class="button" href="Add-dates.aspx">Add Dates</a>
					<a class="button" href="Change-password.aspx">Change Password</a>
                 <div id="gif_load" style="display:none;" ><img  src="img/loader.gif" alt="" style="height:40px;width:40px"/><br /></div> <br />

                 <br />
                 <br /><br />
                 <section>
                  <div class="col col-12" id="Message_success" style="display:none;">
                          <div class="col col-12">

                           <section class="col col-12">
                            <div >

                              <p ><center style="color:green"><h5>Thank you,modifications has been successfully updated!</h5></center></p>
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
                <br />
				</footer>
			</form>
		</div>
</asp:Content>

