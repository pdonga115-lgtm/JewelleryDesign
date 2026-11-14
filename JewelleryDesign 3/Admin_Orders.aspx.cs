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
    public partial class Admin_Orders : System.Web.UI.Page
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

        void fillGrid()
        {
            getCon();
            string query = "SELECT o.Order_Id, o.Order_Date, o.Ship_Name, o.Ship_Mobile, o.Ship_Address, o.Ship_City, " +
                           "o.Payment, o.Total, o.Status, " +
                           "STUFF((SELECT ', ' + i.Prod_Name + ' x' + CAST(i.Qty AS VARCHAR(10)) FROM Order_Items_Tbl i " +
                           "WHERE i.Order_Id = o.Order_Id FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, '') AS ItemList " +
                           "FROM Orders_Tbl o ORDER BY o.Order_Id DESC";

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);
            con.Close();

            gvOrders.DataSource = ds;
            gvOrders.DataBind();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            Helper.EnsureDb();

            if (!IsPostBack)
            {
                fillGrid();
            }
        }

        protected void gvOrders_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList d = (DropDownList)e.Row.FindControl("ddlStatus");
                DataRowView drv = (DataRowView)e.Row.DataItem;
                if (d != null && drv != null)
                {
                    ListItem li = d.Items.FindByValue(drv["Status"].ToString());
                    if (li != null) d.SelectedValue = li.Value;
                }
            }
        }

        protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_upd")
            {
                GridViewRow row = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                DropDownList d = (DropDownList)row.FindControl("ddlStatus");

                getCon();
                string query = "UPDATE Orders_Tbl SET Status = '" + d.SelectedValue.Replace("'", "''") + "' WHERE Order_Id = " + e.CommandArgument;
                cmd = new SqlCommand(query, con);
                cmd.ExecuteNonQuery();
                con.Close();

                lblMsg.Text = "Order #" + e.CommandArgument + " status updated to " + d.SelectedValue + ".";
                lblMsg.Visible = true;
                Response.Write("<script>alert('Order #" + e.CommandArgument + " updated to " + d.SelectedValue + "')</script>");
                fillGrid();
            }
        }
    }
}
