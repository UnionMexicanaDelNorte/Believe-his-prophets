using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.IO;
using System.Collections.Specialized;
using System.Net;
namespace BHP
{
    public partial class Form1 : Form
    {
        public String mensajeGlobal { get; set; }
        public Form1()
        {
            InitializeComponent();
            mensajeGlobal = "ERROR";
        }

        public Form1(String mensajeL)
        {
            InitializeComponent();
            mensajeGlobal = mensajeL;
        }

        private void Form1_Load(object sender, EventArgs e)
        {
             String mensaje = "";
            
            if (mensajeGlobal.Equals("ERROR")) 
            {
                mensaje = "Es hora de creed en sus Profetas";
            }
            else
            {
                mensaje = mensajeGlobal;
            }

              String connString = "Database=BHP;Data Source=localhost;Integrated Security=False;MultipleActiveResultSets=true;User ID='sa';Password='SunPlus7!';connect timeout = 60";
              String token = "";
              int tipo = -1;
              String queryCuentas = "SELECT token,tipo FROM [BHP].[dbo].[tokens]";
            try
            {
                using (SqlConnection connection = new SqlConnection(connString))
                {
                    connection.Open();
                    SqlCommand cmdCheck = new SqlCommand(queryCuentas, connection);
                    SqlDataReader reader = cmdCheck.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            tipo = reader.GetInt32(1);
                            token = reader.GetString(0).Trim();
                             
                           

                            if(tipo==1)
                            {//ios
                                  token = token.Replace("<", "");
                                token = token.Replace(">", "");
                                token = token.Replace(" ", "");
                                token = token.Trim();
                                string URL = "http://unionnorte.org/bhp/push.php";
                                WebClient webClient = new WebClient();

                                NameValueCollection formData = new NameValueCollection();
                                formData["token"] = token;
                                formData["mensaje"] = mensaje;
                                formData["clave"] = "asdwer";

                                byte[] responseBytes = webClient.UploadValues(URL, "POST", formData);
                                string responsefromserver = Encoding.UTF8.GetString(responseBytes);
                                Console.WriteLine(responsefromserver);
                                webClient.Dispose();
                            }
                            else
                            {//android
                                string SERVER_API_KEY = "AIzaSyAkTU659HWIXKOCE26SuujptvI1FbwNvws";
                                var SENDER_ID = "291300710119";
                                var value = mensaje;
                                WebRequest tRequest;
                                tRequest = WebRequest.Create("https://android.googleapis.com/gcm/send");
                                tRequest.Method = "post";
                                tRequest.ContentType = " application/x-www-form-urlencoded;charset=UTF-8";
                                tRequest.Headers.Add(string.Format("Authorization: key={0}", SERVER_API_KEY));

                                tRequest.Headers.Add(string.Format("Sender: id={0}", SENDER_ID));

                                string postData = "collapse_key=score_update&time_to_live=108&delay_while_idle=1&data.message=" + value + "&data.time=" + System.DateTime.Now.ToString() + "&registration_id=" + token + "";
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
                                // return sResponseFromServer;
                            }
                        }//while
                        this.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                System.Windows.Forms.MessageBox.Show(ex.ToString(), "Sunplusito", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }
        }
    }
}
