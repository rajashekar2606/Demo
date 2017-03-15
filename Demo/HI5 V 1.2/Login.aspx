<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link href="css/style.css" rel="stylesheet" type="text/css" media="all"/>
<!-- for-mobile-apps -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<link href='//fonts.googleapis.com/css?family=Signika:400,600' rel='stylesheet' type='text/css'>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <body>
<!--header start here-->
<br /><br />
<h1>Login Form</h1>
<div class="header agile">
	<div class="wrap">
		<div class="login-main wthree">
			<div class="login">
			<h3>Login</h3>
			  <form id="Form1" runat="server">
            <asp:TextBox ID="txt_username" runat="server" TextMode="SingleLine" name="contactName" class="input-box" placeholder="Username"></asp:TextBox>
            <asp:TextBox ID="txt_password" runat="server" TextMode="Password" name="contactName" class="input-box" placeholder="Password"></asp:TextBox>
             <asp:Button ID="Button1"  runat="server" Text="Login" onclick="validate_login" Value="Login" type="button"/>
			</form>
			<div class="clear"> </div>
				<h4><a href="#"> Forgot Your Password?</a></h4>
			</div>
			
		</div>
	</div>
</div>
<!--header end here-->
<!--copy rights end here-->
<div class="copy-rights w3l">		 	
	<p> </p>		 	
</div>
<!--copyrights start here-->

</body>
</asp:Content>

