using System;
using System.Net;
using System.Text;
using System.IO;

public class AndroidGCMPushNotification
{
	public AndroidGCMPushNotification()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public string SendNotification(string deviceId, string message)
    {
        //FdqwXsCSaw__uU1tbzABUsx9
        //444527565813-6jigem9omcgud8gtbochdo5sb40oc62b.apps.googleusercontent.com
        string GoogleAppID = "AIzaSyB9tznYsZPmglDw2xGnlgADWxgzbBSZOFE";
        var SENDER_ID = "444527565813";
        var value = message;
        WebRequest tRequest;
        tRequest = WebRequest.Create("https://android.googleapis.com/gcm/send");
        tRequest.Method = "post";
        tRequest.ContentType = " application/x-www-form-urlencoded;charset=UTF-8";
        tRequest.Headers.Add(string.Format("Authorization: key={0}", GoogleAppID));

        tRequest.Headers.Add(string.Format("Sender: id={0}", SENDER_ID));

        string postData = "collapse_key=score_update&time_to_live=108&delay_while_idle=1&data.message=" + value + "&data.time=" + System.DateTime.Now.ToString() + "&registration_id=" + deviceId;//"®istration_id=" + deviceId + "";
        Console.WriteLine(postData);
        Byte[] byteArray = Encoding.UTF8.GetBytes(postData);
        tRequest.ContentLength = byteArray.Length;

        Stream dataStream = tRequest.GetRequestStream();
        dataStream.Write(byteArray, 0, byteArray.Length);
        dataStream.Close();

        WebResponse tResponse = tRequest.GetResponse();

        dataStream = tResponse.GetResponseStream();

        StreamReader tReader = new StreamReader(dataStream);

        String sResponseFromServer = tReader.ReadToEnd();
        
        tReader.Close();
        dataStream.Close();
        tResponse.Close();
        return sResponseFromServer;
    }
}