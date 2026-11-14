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
    public partial class Cart : System.Web.UI.Page
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
            string query = "SELECT c.Cart_Id, c.Qty, p.Prod_Name, p.Prod_Img, p.Prod_Price, " +
                           "(p.Prod_Price * c.Qty) AS Subtotal, ISNULL(m.Comp_Name, 'Jewellery Design') AS Comp_Name " +
                           "FROM Cart_Tbl c " +
                           "INNER JOIN Add_Products_Tbl p ON c.Prod_Id = p.Prod_Id " +
                           "LEFT JOIN Add_Company_Tbl m ON p.Prod_Comp_Id = m.Comp_id " +
                           "WHERE c.User_Id = " + Session["uid"] + " ORDER BY c.Cart_Id DESC";

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);
            con.Close();

            gvCart.DataSource = ds;
            gvCart.DataBind();

            bool hasItems = ds.Tables[0].Rows.Count > 0;
            pnlCart.Visible = hasItems;
            pnlEmpty.Visible = !hasItems;

            if (hasItems)
            {
                decimal total = 0;
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    total += Convert.ToDecimal(ds.Tables[0].Rows[i]["Subtotal"]);
                }
                lblTotal.Text = "\u20B9" + total.ToString("N0");
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] != null)
            {
                Response.Redirect("Default.aspx");
            }
            if (Session["user"] == null)
            {
                Response.Redirect("Login.aspx?ret=Cart.aspx");
            }
            Helper.EnsureDb();

            if (!IsPostBack)
            {
                fillGrid();
            }
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            Response.Redirect("Checkout.aspx");
        }

        protected void gvCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string sql = "";
            int cartId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "cmd_inc")
            {
                sql = "UPDATE Cart_Tbl SET Qty = Qty + 1 WHERE Cart_Id=" + cartId + " AND User_Id=" + Session["uid"];
            }
            else if (e.CommandName == "cmd_dec")
            {
                sql = "UPDATE Cart_Tbl SET Qty = Qty - 1 WHERE Cart_Id=" + cartId + " AND User_Id=" + Session["uid"] + " AND Qty > 1";
            }
            else if (e.CommandName == "cmd_rem")
            {
                sql = "DELETE FROM Cart_Tbl WHERE Cart_Id=" + cartId + " AND User_Id=" + Session["uid"];
            }

            if (!string.IsNullOrEmpty(sql))
            {
                getCon();
                cmd = new SqlCommand(sql, con);
                cmd.ExecuteNonQuery();
                con.Close();

                fillGrid();

                if (e.CommandName == "cmd_rem")
                {
                    lblMsg.Text = "Item removed from cart.";
                    lblMsg.Visible = true;
                }
            }
        }
    }
}
