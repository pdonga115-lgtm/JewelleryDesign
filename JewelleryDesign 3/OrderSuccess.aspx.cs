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
    public partial class OrderSuccess : System.Web.UI.Page
    {
        SqlConnection con;
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
            if (Session["user"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int id;
            if (!int.TryParse(Request.QueryString["id"], out id))
            {
                Response.Redirect("MyOrders.aspx");
                return;
            }

            getCon();
            da = new SqlDataAdapter("SELECT Total, Payment FROM Orders_Tbl WHERE Order_Id = " + id + " AND User_Id = " + Session["uid"], con);
            ds = new DataSet();
            da.Fill(ds);
            con.Close();

            if (ds.Tables[0].Rows.Count == 0)
            {
                Response.Redirect("MyOrders.aspx");
                return;
            }

            lblOrderId.Text = id.ToString();
            lblAmount.Text = "\u20B9" + Convert.ToDecimal(ds.Tables[0].Rows[0]["Total"]).ToString("N0");
            lblPay.Text = Server.HtmlEncode(ds.Tables[0].Rows[0]["Payment"].ToString());
        }
    }
}
