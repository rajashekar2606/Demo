<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="Blog.aspx.cs" Inherits="Blog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script type="text/javascript">
  $(function () {
      get_posted_questions();

    });
     var questionsdata;
     function get_posted_questions() {
        var results = " ";
        var data = { 'op': 'get_posted_questions' };
        var s = function (msg) {
            if (msg) {
                questionsdata = msg;
               changePage(1);

              
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

    var current_page = 1;
    var records_per_page = 3;

    
    function prevPage() {
        if (current_page > 1) {
            current_page--;
            changePage(current_page);
        }
    }

    function nextPage() {
        if (current_page < numPages()) {
            current_page++;
            changePage(current_page);
        }
    }

    function changePage(page) {
        var btn_next = document.getElementById("btn_next");
        var btn_prev = document.getElementById("btn_prev");
        var page_span = document.getElementById("page");
   
        // Validate page
        if (page < 1) page = 1;
        if (page > numPages()) page = numPages();
        listing_table = "";
    $('#div_load').show();// imageId is id to your gif image div
        for (var i = (page - 1) * records_per_page; i < (page * records_per_page) && i < questionsdata.length; i++) {
                    if (questionsdata[i].sno != null) {
                        listing_table += '<div class="col s12 m4 l4">';
                       listing_table += '<div class="blog-post">';
                       listing_table += '<div class="card">';
                       listing_table += '<div class="card-image"> <img src="http://advantageitinc.com/assets/img/slider/3.jpg"></div>';
                       listing_table += '<div class="card-content blog-post-content">';
                       listing_table += ' <br /><br />';
                       listing_table += '<h2 onclick="div_single_posts('+questionsdata[i].sno+')"><a href="#">' + questionsdata[i].subject + '</a></h2>';
                       listing_table += '<div class="meta-media">';
                       listing_table += '<div class="single-meta">';
                       listing_table += 'Post By <a class="posted_by" href="#">' + questionsdata[i].posted_by + '</a></div></br>';
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

                        var datetim = date + ", " + time;
                       listing_table += '<div class="single-meta datetim">Posted Time : <a href="#">' + datetim + '</a></div></div>';
                        var string = ' ' + questionsdata[i].question + ' ';
                        var length = 250;
                        var trimmedString = string.substring(0, length);
                       listing_table += '<p>' + trimmedString + '</p>';
                       listing_table += ' <div class="card-action"><a class="post-comment" href="#" ></a><a class="readmore-btn" href="#" onclick="div_single_posts(' + questionsdata[i].sno + ')" >Read More</a></div>';
                       listing_table += '</div></div></div></div>';
                        $("#posted_questions").html(listing_table);
                        }
                    $('#div_load').hide();// hide the image when example.php is loaded
        }
        page_span.innerHTML = page + "/" + numPages();

        if (page == 1) {
            btn_prev.style.visibility = "hidden";
        } else {
            btn_prev.style.visibility = "visible";
        }

        if (page == numPages()) {
            btn_next.style.visibility = "hidden";
        } else {
            btn_next.style.visibility = "visible";
      }
    }

    function numPages() {
        return Math.ceil(questionsdata.length / records_per_page);
    }

  

   
    var comment_sno;
    function div_single_posts(sno) {
        comment_sno = sno;
        var sub_results = " ";
        for (var i = 0; i < questionsdata.length; i++) {
            if (questionsdata[i].sno != null) {
                if (questionsdata[i].sno == sno) {
                    $(function () {
                            event.preventDefault();

                            //construct htmlForm string
                            var htmlForm = "<form id='myform' method='POST' action='http://localhost:18214/HI5%20V%201.2/'>" +
                           "<input type='hidden' id='"+ questionsdata[i].sno+ "' value='hajan' />" +
                             "</form>";

                            //Submit the form
                            $(htmlForm).appendTo("body").submit();
                        });
                    sub_results += ' <center><div class="blog-content"></center></br>';
                    sub_results += '<p class="sno" style="display:none;">' + questionsdata[i].sno+ '</p>';
                    sub_results += '<p>' + questionsdata[i].subject + '</p>';
                    sub_results += '<div class="blog-image"> <img src="http://advantageitinc.com/assets/img/slider/3.jpg"></div>';
                    sub_results += '<div class="card-content blog-post-content">';
                    sub_results += ' <blockquote><p> ' + questionsdata[i].question + '</p>';
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

                    var datetim = date + "/" + time;
                    sub_results += '<cite>' + questionsdata[i].posted_by + ' ; ' + datetim + '</cite>  ';
                    sub_results += '</blockquote>';
                    sub_results += '</div></div>';
                    $("#blog").css("display", "none")
                    $("#blog-details").css("display", "block")
                    $("#div_sub_posts").html(sub_results);
                }
            }
        }
     get_comments();

    }

      function empty_leave_message() {
        document.getElementById('name').value = " ";
        document.getElementById('message').value = " "
        check_data();
    }

    function add_comment() {
        var name = document.getElementById('name').value;
        if (name == null || name == "" || name == " ") {
            document.getElementById("name").focus();
            chck_validate();
            return false;
        }
        var answer = document.getElementById('message').value;
        if (message == null || message == "" || message == " ") {
            document.getElementById("message").focus();
            chck_validate();
            return false;
        }

        var data = { 'op': 'add_comment', 'name': name, "answer": answer, "comment_sno": comment_sno };
        var s = function (msg) {
            if (msg) {
                if (msg == "Data Successfully Saved") {
                    loading_gif_stop();
                    Message_success();
                    empty_leave_message();
                    get_comments();
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
    var comments_data;
    function get_comments() {
        var results5 = " ";
        var data = { 'op': 'get_add_comments', 'comment_sno': comment_sno };
        var s = function (msg) {
            if (msg) {
                comments_data = msg;
                for (var i = 0; i < comments_data.length; i++) {
                    if (comments_data[i].sno != null) {
                        results5 += '<li>';
                        results5 += ' <div class="media"><div class="media-left">';
                        results5 += '<img class="media-object news-img" src="img/logo.jpeg" alt="img"></div>';
                        results5 += '<div class="media-body"><h4 class="author-name">'+comments_data[i].commented_by+'</h4>';
                         var datetime = new Date('' + comments_data[i].commented_time + '');
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
                        results5 += '<span class="comments-date">'+datetim+'</span>';
                        results5 += '<p>'+comments_data[i].answer+'</p>';
                        results5 += '<a href="#div_sub_posts" class="reply-btn">Reply</a>';
                        results5 += ' </div></div></li>';
                        $("#comment_add").html(results5);
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
    function prevpost() {
        $("#comment_add").empty();
        var sno3 = comment_sno + 1;
        div_single_posts(sno3);
     }

     function nextpost() {
         $("#comment_add").empty();
         var sno2 = comment_sno - 1;
         div_single_posts(sno2);
  }  


   </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <!-- BEGAIN PRELOADER -->         
      <%--    <section id="banner">
            <div class="parallax-container">
              <div class="parallax">
                <img src="img/blog.bg.png">
              </div>
              <div class="overlay-header">       
              </div>
              <div class="overlay-content blog-head">
                <div class="container">
                 <cenyter> <h1 class="header-title">Blog Posts</h1> </cenyter>                 
                </div>
              </div>
            </div>
          </section>--%>
           <section id="blog" >
            <div class="container">
              <div class="row">
               <div class="col s12">
                 <div class="blog-inner">
                   <h2 class="title">Blog</h2>
                  <!-- Start Blog area -->
                  <div class="blog-area" >
                 <center><div class="row"><div id="div_load" style="display:block;"><img src="img/loading.gif" style="height:150px;width:150px;"/></div></div></center> 
                    <div class="row" id="posted_questions" >
                      <!-- Start single blog post -->
                     
                    </div>
                    <div class="row">
                    <div class="col s12">                      
                      <ul class="pagination custom-pagination" id="pagin">
                       <li><a href="javascript:prevPage()" id="btn_prev"><i class="material-icons">chevron_left</i></a></li>
                        <li><span id="page"></span></li>
                        <li class="waves-effect"><a href="javascript:nextPage()"><i class="material-icons">chevron_right</i></a></li>
                      </ul>       
                    </div>
                  </div>
                    <!-- All Post Button -->
                  </div>                    
                 </div>
                </div>
              </div> 
            </div>
          </section>
          <section id="blog-details" style="display:none;">
            <div class="container">
              <div class="row">
                <div class="col s12 m8 l8">
                  <div class="blog-content" id="div_sub_posts" >
                   
                    <!-- Start Blog Content Bottom -->
                    <div class="blog-content-bottom">
                      <div class="row">
                        <div class="col s12 m3 l3">
                          <div class="share-area">       
                            <h4>
                              <i class="fa fa-share-alt"></i>
                              share
                            </h4>
                            <a href="#"><i class="fa fa-facebook"></i></a>
                            <a href="#"><i class="fa fa-twitter"></i></a>
                            <a href="#"><i class="fa fa-linkedin"></i></a>
                            <a href="#"><i class="fa fa-google-plus"></i></a>
                          </div>
                        </div>
                        <div class="col s12 m9 l9">
                          <div class="tag-area">
                            <h4>
                              <i class="fa fa-tag"></i>
                              Tag
                            </h4>
                            <a href="#">Web Design,</a>
                            <a href="#">Graphics,</a>
                            <a href="#">Fashion,</a>
                            <a href="#">Technology,</a>
                            <a href="#">Image,</a>
                            <a href="#">Marketing</a>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <!-- Start Blog Navigation -->
                  <div class="blog-navigation">
                    <div class="blog-navigation-left">
                      <a class="prev-post" onclick="prevpost();" href="#">Prev Post</a>
                    </div>
                    <div class="blog-navigation-right">
                      <a class="next-post" onclick="nextpost();" href="#">Next Post</a>
                    </div>
                  </div>
                  <!-- Strat Related Post -->
                  <!-- Start Comments -->
                  
                  <div class="row">
                  <div class="col s12" id="error_msg" style="display:none;">
                      <div class="contact">
                        <div class="row">
                          <div class="col s12">
                            <div class="contact-form" style="background-color:#26a69a;">
                              <form >
                              <p ><center style="color:White">Please check and fill the boxes</center></p>
                              </form>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  <div class="col s12">
                  <div class="contact-form">
                 <h5  align="left" style="color:Red;">Add Comment</h5>
                                <div class="input-field">
                                  <input type="text" class="input-box" name="contactName" onkeyup="check_data();" id="name">
                                  <label class="input-label" for="contact-name">contact-name</label>
                                </div>
                                <div class="input-field textarea-input">
                                  <textarea class="materialize-textarea" onkeyup="check_data();"  name="contactMessage" id="message"></textarea>
                                  <label class="input-label" for="textarea1">Comment</label>
                                </div>
                                <button class="left waves-effect btn-flat brand-text submit-btn" onclick="add_comment();" type="button">Add Comment</button>
                                <div id="gif_load" style="display:none;" ><img  src="img/loader.gif" alt="" style="height:40px;width:40px"/><br /></div> <br />
                            </div>
                            </div>
                 <div class="col s12" id="Message_success" style="display:none;">
                      <div class="contact">
                        <div class="row">
                          <div class="col s12">
                            <div class="contact-form" style="background-color:green;">
                              <form >
                              <p ><center style="color:White">Comment Posted Successfully!</center></p>
                              </form>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="col s12" id="Message_failed" style="display:none;">
                      <div class="contact">
                        <div class="row">
                          <div class="col s12">
                            <div class="contact-form" style="background-color:red;">
                              <form >
                              <p ><center style="color:White">Adding Comment Failed,Please try again later or report us</center></p>
                              </form>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="col s12">
                      <div class="comments-area">
                        <div class="comments">
                          <ul class="commentlist" id="comment_add">
                          </ul>
                        </div>
                      </div>
                    </div>
                  </div>
                  <!-- Start Pagination -->
               
                </div>
                <!-- Start Sidebar -->
                <%--<div class="col s12 m4 l4">
                  <aside class="sidebar">
                    <!-- Start Single Sidebar -->
                    <div class="single-sidebar">
                      <h3>Recent News</h3>
                      <!-- Single Recent News -->
                      <div class="recent-news">
                        <div class="recent-img">
                          <a href="blog-single.html"><img src="img/blog1.jpg" alt="img"></a>
                        </div>
                        <div class="recent-body">
                          <h4><a href="blog-single.html">Recent News Title</a></h4>
                          <p>The point of using Lorem Ipsum is that it has a more-or-less normal.</p>
                        </div>
                      </div>
                      <!-- Single Recent News -->
                      <div class="recent-news">
                        <div class="recent-img">
                          <a href="blog-single.html"><img src="img/blog2.jpg" alt="img"></a>
                        </div>
                        <div class="recent-body">
                          <h4><a href="blog-single.html">Recent News Title</a></h4>
                          <p>The point of using Lorem Ipsum is that it has a more-or-less normal.</p>
                        </div>
                      </div>
                      <!-- Single Recent News -->
                      <div class="recent-news">
                        <div class="recent-img">
                          <a href="blog-single.html"><img src="img/blog3.jpg" alt="img"></a>
                        </div>
                        <div class="recent-body">
                          <h4><a href="blog-single.html">Recent News Title</a></h4>
                          <p>The point of using Lorem Ipsum is that it has a more-or-less normal.</p>
                        </div>
                      </div>
                    </div>
                    <!-- Start Single Sidebar -->
                    <div class="single-sidebar">
                      <h3>Categories</h3>
                      <!-- Single Category -->
                      <ul>
                        <li class="cat-item"><a href="#">Graphics</a></li>
                        <li class="cat-item"><a href="#">Inspiration</a></li>
                        <li class="cat-item"><a href="#">Web Design</a></li>
                        <li class="cat-item"><a href="#">Web Development</a></li>
                        <li class="cat-item"><a href="#">WordPress</a></li>
                      </ul>
                    </div>
                     <!-- Start Single Sidebar -->
                    <div class="single-sidebar">
                      <h3>Archives</h3>
                      <!-- Single Category -->
                      <ul class="archives">
                       <li><a href="#">March 2015</a></li>
                       <li><a href="#">April 2015</a></li>
                       <li><a href="#">May 2015</a></li>
                       <li><a href="#">June 2015</a></li>
                       <li><a href="#">July 2015</a></li>
                      </ul>
                    </div>
                    <!-- Start Single Sidebar -->
                    <div class="single-sidebar">
                      <h3>Tags</h3>
                      <!-- Single Category -->
                      <div class="tagcloud">
                        <a href="#">Design</a>
                        <a href="#">Photography</a>
                        <a href="#">Development</a>
                        <a href="#">Art</a>
                        <a href="#">WordPress</a>
                        <a href="#">Design</a>
                        <a href="#">Photography</a>
                        <a href="#">Development</a>                        
                        <a href="#">WordPress</a>
                      </div>
                    </div>
                     <!-- Start Single Sidebar -->
                    <div class="single-sidebar">
                      <h3>Important links</h3>                      
                      <ul>
                        <li><a href="#">Login</a></li>
                        <li><a href="#">Link One</a></li>
                        <li><a href="#">Link Two</a></li>
                        <li><a href="#">Link Three</a></li>
                      </ul>
                    </div>
                  </aside>
                </div>--%>
              </div>
            </div>
          </section>  
          <!-- Start Footer -->
</asp:Content>

