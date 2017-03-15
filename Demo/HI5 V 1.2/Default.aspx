<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script type="text/javascript">
    $(function () {
        get_posted_questions();
    });

    function empty_leave_message() {
        document.getElementById('first_name').value = " ";
        document.getElementById('last_name').value = " ";
        document.getElementById('email').value = " ";
        document.getElementById('pwd1').value = " ";
        document.getElementById('pwd2').value = " ";
        document.getElementById('address1').value = " ";
        document.getElementById('address2').value = " "
        document.getElementById('city').value = " ";
        document.getElementById('state').value = " ";
        document.getElementById('zipcode').value = " ";
        check_data();
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
        if (email == null || email == "" || email == " ") {
            document.getElementById("email").focus();
            chck_validate();
            return false;
        }

        var pwd1 = document.getElementById('pwd1').value;
        if (pwd1 == null || pwd1 == "" || pwd1 == " ") {
            document.getElementById("pwd1").focus();
            chck_validate();
            return false;
        }

        var address1 = document.getElementById('address1').value;
        if (address1 == null || address1 == "" || address1 == " ") {
            document.getElementById("address1").focus();
            chck_validate();
            return false;
        }

        var address2 = document.getElementById('address2').value;
        if (address2 == null || address2 == "" || pwd1 == " ") {
            document.getElementById("address2").focus();
            chck_validate();
            return false;
        }

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

        var data = { 'op': 'save_users', 'first_name': first_name, "last_name": last_name, "email": email, "pwd1": pwd1, "address1": address1, "address2": address2, "city": city, "state": state, "zipcode": zipcode };
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
        }, 2000);
    }
    function Message_failed() {
        $("#Message_failed").css("display", "block");
        $("#Message_success").css("display", "none");
        setTimeout(function () {
            $('#Message_failed').fadeOut('fast');
        }, 2500);

    }


    var questionsdata;
    function get_posted_questions() {
        var results = " ";
        var data = { 'op': 'get_posted_questions' };
        var s = function (msg) {
            if (msg) {
                questionsdata = msg;
                for (var i = 0; i < 3; i++) {
                    if (questionsdata[i].sno != null) {
                        $('#div_load').show(); // hide the image when example.php is loaded
                        results += '<div class="col s12 m4 l4">';
                        results += '<div class="blog-post">';
                        results += '<div class="card">';
                        results += '<div class="card-image"> <img src="http://advantageitinc.com/assets/img/slider/3.jpg"></div>';
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

          <!-- START HOME SECTION -->
          <section id="home">
            <div class="overlay-section">
              <div class="container">
                <div class="row">
                  <div class="col s12">
                    <div class="home-inner">
                      <h1 class="home-title">HI! Welcome to the <span>HI5</span></h1>
                      <a href="http://advantageitinc.com" class="btn-large">Donate Now <i class="mdi-content-send left"></i></a>
                      <!-- Call to About Button -->
                    </div>
                  </div>  
                </div>
              </div>
            </div>
          </section>

            <section id="facts">
            <div class="facts-overlay">
              <div class="container">
              <div class="row">
                <div class="col s12">
                  <div class="facts-inner">
                    <div class="row">
                      <div class="col s12 m4 l4">
                        <div class="single-facts waves-effect waves-block waves-light">
                          <i class="material-icons">work</i>
                          <span class="counter">329</span>
                          <span class="counter-text">Project Completed</span>
                        </div>
                      </div>
                      <div class="col s12 m4 l4">
                        <div class="single-facts waves-effect waves-block waves-light">
                          <i class="material-icons">supervisor_account</i>
                          <span class="counter">250</span>
                          <span class="counter-text">Happy Clients</span>
                        </div>
                      </div>
                      <div class="col s12 m4 l4">
                        <div class="single-facts waves-effect waves-block waves-light">
                          <i class="material-icons">redeem</i>
                          <span class="counter">69</span>
                          <span class="counter-text">Award Won</span>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            </div>
          </section>


          <!-- START ABOUT SECTION -->
        
          <!-- Start Resume -->
            <!-- Start Experience -->
           
            <!-- Start Education -->
         
          <!-- Start Portfolio -->
          <hr />
          <!-- Start Facts -->
     
          <!-- Testimonial -->
          <!-- Start Blog -->
          <section id="blog">
            <div class="container" style="display:block;">
              <div class="row">
               <div class="col s12">
                 <div class="blog-inner">
                   <h4 class="title" style="color:#555">Recent Events</h4>
                  <!-- Start Blog area -->
                  <div class="blog-area">
                 <center><div class="row"><div id="div_load" style="display:block;"><img src="img/loading.gif" style="height:150px;width:150px;"/></div></div></center> 

                    <div class="row" id="posted_questions">
                      <!-- Start single blog post -->
                     
                    </div>
                    <!-- All Post Button -->
                    <a class="waves-effect waves-light btn-large allpost-btn" href="Blog.aspx">All Post</a>
                  </div>                    
                 </div>
                </div>
              </div> 
            </div>
          </section>
       
</asp:Content>

