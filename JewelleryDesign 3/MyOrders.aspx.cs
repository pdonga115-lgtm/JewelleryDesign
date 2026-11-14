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
    public partial class MyOrders : System.Web.UI.Page
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

        void fillOrders()
        {
            getCon();
            da = new SqlDataAdapter("SELECT Order_Id, Order_Date, Payment, Total, Status FROM Orders_Tbl WHERE User_Id = " + Session["uid"] + " ORDER BY Order_Id DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            con.Close();

            gvOrders.DataSource = ds;
            gvOrders.DataBind();
            pnlNone.Visible = ds.Tables[0].Rows.Count == 0;
        }

        void fillItems(int orderId)
        {
            getCon();
            string query = "SELECT i.Prod_Name, i.Prod_Img, i.Price, i.Qty, (i.Price * i.Qty) AS Subtotal FROM Order_Items_Tbl i " +
                           "INNER JOIN Orders_Tbl o ON i.Order_Id = o.Order_Id " +
                           "WHERE i.Order_Id = " + orderId + " AND o.User_Id = " + Session["uid"];

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);
            con.Close();

            gvItems.DataSource = ds;
            gvItems.DataBind();
            lblTitle.Text = "Items in Order #" + orderId;
            pnlItems.Visible = true;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] != null)
            {
                Response.Redirect("Admin_Orders.aspx");
            }
            Helper.RequireLogin(this);
            Helper.EnsureDb();

            if (!IsPostBack)
            {
                fillOrders();
            }
        }

        protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_view")
            {
                fillItems(Convert.ToInt32(e.CommandArgument));
            }
        }
    }
}
