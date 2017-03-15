<%@ Application Language="C#" %>
<%@ Import Namespace="System.Timers" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e) 
    {
        // Code that runs on application startup
        System.Timers.Timer myTimer = new System.Timers.Timer();
        // Set the Interval to 5 seconds (5000 milliseconds).
        myTimer.Interval = 5000*6*1200;
        myTimer.AutoReset = true;
        myTimer.Elapsed += new ElapsedEventHandler(myTimer_Elapsed);
        myTimer.Enabled = true; 
    }

    public void myTimer_Elapsed(object source, System.Timers.ElapsedEventArgs e)
    {
        clsScheduleMail objScheduleMail = new clsScheduleMail();
        objScheduleMail.SendScheduleMail();   
    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e) 
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e) 
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }
       
</script>
