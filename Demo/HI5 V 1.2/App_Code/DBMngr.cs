using System;
using System.Collections.Generic;

using System.Data;
using MySql.Data.MySqlClient;
namespace GPRSGPSServer
{
    public class DBMgr
    {
        string ConnectionString;
        public MySqlConnection conn = new MySqlConnection();
        List<string> data = new List<string>();
        //  public string UserName = "";
        object obj_lock = new object();

        public DBMgr()
        {
            conn.ConnectionString = @"server=;UserId=;PASSWORD=;Persist Security Info=True;database=";
        }
        public bool insert(MySqlCommand _cmd)
        {
            lock (conn)
            {
                MySqlCommand cmd = _cmd;
                try
                {

                    cmd.Connection = conn;
                    if (cmd.Connection.State == ConnectionState.Open)
                        cmd.Connection.Close();
                    cmd.Connection.Open();
                    cmd.ExecuteNonQuery();
                    cmd.Connection.Close();

                    return true;
                }
                catch (Exception ex)
                {
                    cmd.Connection.Close();
                    throw new ApplicationException(ex.Message);
                }
            }
            //}
        }

        public long insertScalar(MySqlCommand _cmd)
        {
            long sno = 0;
            MySqlCommand cmd = _cmd;
            try
            {
                cmd = _cmd;
              
                    cmd.Connection = conn;
                    if (cmd.Connection.State == ConnectionState.Open)
                        cmd.Connection.Close();
                    cmd.Connection.Open();
                    cmd.ExecuteNonQuery();
                    sno = cmd.LastInsertedId;
                    cmd.Connection.Close();

                return sno;
            }
            catch (Exception ex)
            {
                cmd.Connection.Close();
                throw new ApplicationException(ex.Message);
            }
            //}
        }

        public DataSet SelectQuery(MySqlCommand _cmd)
        {
            lock (conn)
            {
                MySqlCommand cmd = _cmd;


              
                    try
                    {
                        DataSet ds = new DataSet();
                        cmd.Connection = conn;
                        conn.Open();
                        //cmd.ExecuteNonQuery();
                        MySqlDataAdapter sda = new MySqlDataAdapter();
                        sda.SelectCommand = cmd;
                        sda.Fill(ds, "Table");
                        conn.Close();
                        return ds;
                    }
                    catch (Exception ex)
                    {
                        conn.Close();
                        throw new ApplicationException(ex.Message);
                    }
              
            }
        }

        public int Update(MySqlCommand _cmd)
        {
            MySqlCommand cmd = _cmd;
            lock (conn)
            {
                try
                {
                    int i = 0;
                   
                        cmd.Connection = conn;
                        if (cmd.Connection.State == ConnectionState.Open)
                            cmd.Connection.Close();
                        cmd.Connection.Open();
                        i = cmd.ExecuteNonQuery();
                        cmd.Connection.Close();
                        return i;
                }
                catch (Exception ex)
                {
                    cmd.Connection.Close();
                    throw new ApplicationException(ex.Message);
                }
            }
        }

        public void Delete(MySqlCommand _cmd)
        {
            lock (conn)
            {
                MySqlCommand cmd = _cmd;
                try
                {
                    cmd = _cmd;
                    cmd.Connection = conn;
                    if (cmd.Connection.State == ConnectionState.Open)
                        cmd.Connection.Close();
                    cmd.Connection.Open();
                    int ii = cmd.ExecuteNonQuery();
                    cmd.Connection.Close();
                }
                catch (Exception ex)
                {
                    cmd.Connection.Close();
                    throw new ApplicationException(ex.Message);
                }
            }
        }

        public static DateTime GetTime(MySqlConnection conn)
        {

            DataSet ds = new DataSet();
            DateTime dt = DateTime.Now;
            MySqlCommand cmd = new MySqlCommand("SELECT NOW()");
            cmd.Connection = conn;
            if (cmd.Connection.State == ConnectionState.Open)
            {
                cmd.Connection.Close();
            }
            conn.Open();
            //cmd.ExecuteNonQuery();
            MySqlDataAdapter sda = new MySqlDataAdapter();
            sda.SelectCommand = cmd;
            sda.Fill(ds, "Table");
            conn.Close();
            if (ds.Tables[0].Rows.Count > 0)
            {
                dt = (DateTime)ds.Tables[0].Rows[0][0];
            }
            return dt;

        }

        internal bool checkDBConn()
        {
            try
            {
                conn.Open();
                conn.Close();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        static public DateTime GetLowDate(DateTime dt)
        {
            double Hour, Min, Sec;
            DateTime DT = DateTime.Now;
            DT = dt;
            Hour = -dt.Hour;
            Min = -dt.Minute;
            Sec = -dt.Second;
            DT = DT.AddHours(Hour);
            DT = DT.AddMinutes(Min);
            DT = DT.AddSeconds(Sec);
            return DT;

        }

        static public DateTime GetHighDate(DateTime dt)
        {
            double Hour, Min, Sec;
            DateTime DT = DateTime.Now;
            Hour = 23 - dt.Hour;
            Min = 59 - dt.Minute;
            Sec = 59 - dt.Second;
            DT = dt;
            DT = DT.AddHours(Hour);
            DT = DT.AddMinutes(Min);
            DT = DT.AddSeconds(Sec);
            return DT;

        }

        
    }
}