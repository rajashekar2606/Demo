<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="Add-dates.aspx.cs" Inherits="Add_dates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<link href="css/signup.css" rel="stylesheet" type="text/css" />
 <link href="css/table.css" rel="stylesheet" type="text/css" />
 <style type="text/css">
table.hovertable {
	font-family: verdana,arial,sans-serif;
	font-size:11px;
	color:#333333;
	border-width: 1px;
	border-color: #999999;
	border-collapse: collapse;
}
table.hovertable th {
	background-color:#c3dde0;
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #a9c6c9;
}
table.hovertable tr {
	background-color:#d4e3e5;
}
table.hovertable td {
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #a9c6c9;
}
</style>
<!-- Table goes in the document BODY -->

<script type="text/javascript">
    $(function () {
        get_dates_users();
    });

    var Sessiondata;
    function get_dates_users() {
        var table = document.getElementById("tbl_Sessioncategorylist");
        for (var i = table.rows.length - 1; i > 0; i--) {
            table.deleteRow(i);
        }
        var data = { 'op': 'get_dates_users' };
        var s = function (msg) {
            if (msg) {
                var getSessionDetails = msg;
                Sessiondata = msg;
                for (var i = 0; i < getSessionDetails.length; i++) {
                    if (getSessionDetails[i].sno != null) {
                        $('#div_load').show()
                        var sno = getSessionDetails[i].sno;
                        var occasion = getSessionDetails[i].occasion;
                        var month;
                        if (getSessionDetails[i].month == "1") {
                            month = "Janaury";
                        }
                        else if (getSessionDetails[i].month == "2") {
                            month = "February";
                        }
                        else if (getSessionDetails[i].month == "3") {
                            month = "March";
                        }
                        else if (getSessionDetails[i].month == "4") {
                            month = "April";
                        }
                        else if (getSessionDetails[i].month == "5") {
                            month = "May";
                        }
                        else if (getSessionDetails[i].month == "6") {
                            month = "June";
                        }
                        else if (getSessionDetails[i].month == "7") {
                            month = "July";
                        }
                        else if (getSessionDetails[i].month == "8") {
                            month = "August";
                        }
                        else if (getSessionDetails[i].month == "9") {
                            month = "September";
                        }
                        else if (getSessionDetails[i].month == "10") {
                            month = "October";
                        }
                        else if (getSessionDetails[i].month == "11") {
                            month = "November";
                        }
                        else if (getSessionDetails[i].month == "12") {
                            month = "December";
                        }
                        var day = getSessionDetails[i].day;
                        var tablerowcnt = document.getElementById("tbl_Sessioncategorylist").rows.length;
                        $('#tbl_Sessioncategorylist').append('<tr onmouseover="mouseoverfun(this);" onmouseout="mouseoutfun(this);"><td style="display:none">' + sno + '</td><td data-title="sno">' + parseFloat(i + 1) + '</td><td scope="occasion">' + occasion + '</td><td data-title="month">' + month + '</td><td data-title="day">' + day + '</td></tr>');
                    }
                    $('#div_load').hide();
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

    function mouseoverfun(thisid) {
        thisid.style.backgroundColor = '#ffff66';

    }

    function mouseoutfun(thisid) {
        thisid.style.backgroundColor = '#d4e3e5';

    }

    function empty_leave_message() {
        document.getElementById('user_occasion').value = "";
        document.getElementById('slct_month').selectedIndex = 0;
        document.getElementById('slct_day').selectedIndex = 0;
    }
    function save_user_dates() {
        var user_occasion = document.getElementById('user_occasion').value;
        if (user_occasion == null || user_occasion == "" || user_occasion == " ") {
            document.getElementById("user_occasion").focus();
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
        loading_gif_start();
        var data = { 'op': 'save_user_dates', 'user_occasion': user_occasion, "slct_month": slct_month, "slct_day": slct_day };
        var s = function (msg) {
            if (msg) {
                if (msg == "Data Successfully Saved") {
                    loading_gif_stop();
                    Message_success();
                    empty_leave_message();
                    get_dates_users();
                }
                else {
                    loading_gif_stop();
                    Message_failed();
                    empty_leave_message();
                    get_dates_users();
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
        loading_gif_start();
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


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="container">
			<form action="#" class="sky-form" style="background-color:#ecf6f7">
				<header>Add Dates</header>
               <fieldset>
						<section>
                        <label class="input">
								<input id="user_occasion"  type="text" placeholder="Occasion">
							<b class="tooltip tooltip-bottom-right">Let us know the Occasion</b>
							</label>
                                  </section>                    
						<section>
							<label class="select">
                            <select id="slct_month">
                            <option selected value='0'>--Select Month--</option>
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
						<section>
							<label class="select">
								<select id="slct_day">
                            <option selected value='0'>--Select Day--</option>
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
                        <section>
					<button  type="button" onclick="save_user_dates();" class="button">SAVE</button>
					<a class="button" href="user-details.aspx">My Profile</a>
                    <a class="button" href="Change-password.aspx">Change Password</a>
                    </section>
                    <section>
                 <div id="gif_load" style="display:none;" ><img  src="img/loader.gif" alt="" style="height:40px;width:40px"/><br /></div> <br />
                    </section>
                    <br /><br />
                    <div class="row" id="11313" style="display:block;">
                           <section class="col col-12">
                              <p ><center style="color:Red;"><h6></h6></center></p>
                              </section>
                      </div>
                      <br />
                      <div class="row" id="password_check" style="display:none;">
                           <section class="col col-12">
                              <p ><center style="color:Red;"><h6>Passwords doesn't match,Please enter again</h6></center></p>
                              </section>
                      </div>
                  <div class="row" id="Message_success" style="display:none;">
                           <section class="col col-12">
                              <p ><center style="color:green"><h5>Thank you,Date has been added</h5></center></p>
                              </section>
                      </div>
                    <div class="row" id="Message_failed" style="display:none;">
                           <section class="col col-12">
                              <p ><center style="color:red"><h5>Sorry, Adding dates failed and  try to  <a href="Login.aspx" style="color:green;"/>Contact us </a></h5></center></p>
                              </section>
                      </div>
				</fieldset>
                 <div class="container" style="background-color:#ecf6f7">
                    <br /><br /><br />
                   <center> <table id="tbl_Sessioncategorylist"  class="table-bordered hovertable" style="overflow:auto">
                    <thead>
                    <tr>
                        <th>
                            Sno
                        </th>
                        <th>
                            Occasion
                        </th>
                        <th >
                           Month
                        </th>
                        <th >
                           Day
                        </th>
                    </tr>
                </thead>
            <div id="div_load"  align="center" style="display:none;" ><img  src="img/loading.gif" alt="" style="height:100px;width:100px"/><br /></div> <br />

                    <tbody>

                    </tbody>
                    
                    </table>
                    
                    </center>
                    </div>
                    <br /><br /><br />
				<footer >
				</footer>
			</form>
		</div>
</asp:Content>

