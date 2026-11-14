using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace JewelleryDesign
{
    public partial class AddToCart : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        void getCon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Helper.EnsureDb();

            int pid;
            if (!int.TryParse(Request.QueryString["pid"], out pid))
            {
                Response.Redirect("Products.aspx");
                return;
            }

            string back = Helper.SafeLocal(Request.QueryString["ret"], "Products.aspx");

            if (Session["user"] == null && Session["admin"] == null)
            {
                string again = "AddToCart.aspx?pid=" + pid + "&ret=" + Server.UrlEncode(back);
                Response.Redirect("Login.aspx?ret=" + Server.UrlEncode(again));
                return;
            }

            if (Session["user"] == null)
            {
                Response.Redirect(back);
                return;
            }

            getCon();
            da = new SqlDataAdapter("SELECT * FROM Cart_Tbl WHERE User_Id = " + Session["uid"] + " AND Prod_Id = " + pid, con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                cmd = new SqlCommand("UPDATE Cart_Tbl SET Qty = Qty + 1 WHERE User_Id = " + Session["uid"] + " AND Prod_Id = " + pid, con);
                cmd.ExecuteNonQuery();
            }
            else
            {
                cmd = new SqlCommand("INSERT INTO Cart_Tbl(User_Id, Prod_Id, Qty) VALUES(" + Session["uid"] + ", " + pid + ", 1)", con);
                cmd.ExecuteNonQuery();
            }
            con.Close();

            string sep = back.IndexOf('?') >= 0 ? "&" : "?";
            string hash = "";
            int h = back.IndexOf('#');
            if (h >= 0)
            {
                hash = back.Substring(h);
                back = back.Substring(0, h);
                sep = back.IndexOf('?') >= 0 ? "&" : "?";
            }
            Response.Redirect(back + sep + "added=1" + hash);
        }
    }
}
