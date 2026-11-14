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
    public partial class Checkout : System.Web.UI.Page
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

        int fillSummary()
        {
            getCon();
            string query = "SELECT p.Prod_Name, c.Qty, (p.Prod_Price * c.Qty) AS Subtotal " +
                           "FROM Cart_Tbl c INNER JOIN Add_Products_Tbl p ON c.Prod_Id = p.Prod_Id " +
                           "WHERE c.User_Id = " + Session["uid"];

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);
            con.Close();

            gvSummary.DataSource = ds;
            gvSummary.DataBind();

            decimal total = 0;
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                total += Convert.ToDecimal(ds.Tables[0].Rows[i]["Subtotal"]);
            }
            lblTotal.Text = "\u20B9" + total.ToString("N0");
            return ds.Tables[0].Rows.Count;
        }

        void fillUser()
        {
            getCon();
            da = new SqlDataAdapter("SELECT Name, Mobile, Address, City FROM Emp_tbl WHERE Id = " + Session["uid"], con);
            ds = new DataSet();
            da.Fill(ds);
            con.Close();

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow r = ds.Tables[0].Rows[0];
                txtName.Text = r["Name"].ToString();
                txtMobile.Text = r["Mobile"].ToString();
                txtAddress.Text = r["Address"].ToString();
                txtCity.Text = r["City"].ToString();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] != null)
            {
                Response.Redirect("Default.aspx");
            }
            Helper.RequireLogin(this);
            Helper.EnsureDb();

            if (!IsPostBack)
            {
                if (fillSummary() == 0)
                {
                    Response.Redirect("Cart.aspx");
                }
                fillUser();
            }
        }

        protected void btnPlace_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtName.Text) || string.IsNullOrWhiteSpace(txtAddress.Text) ||
                string.IsNullOrWhiteSpace(txtCity.Text) || string.IsNullOrWhiteSpace(txtMobile.Text))
            {
                lblMsg.Text = "Please fill all delivery details.";
                lblMsg.Visible = true;
                Response.Write("<script>alert('Please fill all delivery details')</script>");
                fillSummary();
                return;
            }

            string mob = txtMobile.Text.Trim();
            long tmp;
            if (mob.Length != 10 || !long.TryParse(mob, out tmp))
            {
                lblMsg.Text = "Please enter a valid 10-digit mobile number.";
                lblMsg.Visible = true;
                Response.Write("<script>alert('Please enter a valid 10-digit mobile number')</script>");
                fillSummary();
                return;
            }

            int orderId = 0;
            getCon();
            SqlTransaction tr = con.BeginTransaction();
            try
            {
                cmd = new SqlCommand("SELECT ISNULL(SUM(p.Prod_Price * c.Qty), 0) FROM Cart_Tbl c " +
                                     "INNER JOIN Add_Products_Tbl p ON c.Prod_Id = p.Prod_Id WHERE c.User_Id = " + Session["uid"], con, tr);
                decimal total = Convert.ToDecimal(cmd.ExecuteScalar());

                if (total > 0)
                {
                    string shipName = txtName.Text.Trim().Replace("'", "''");
                    string shipAdd = txtAddress.Text.Trim().Replace("'", "''");
                    string shipCity = txtCity.Text.Trim().Replace("'", "''");
                    string payMode = rblPay.SelectedValue.Replace("'", "''");

                    string insertOrder = "INSERT INTO Orders_Tbl(User_Id, Ship_Name, Ship_Mobile, Ship_Address, Ship_City, Payment, Total) " +
                                         "VALUES(" + Session["uid"] + ", '" + shipName + "', '" + mob + "', '" + shipAdd + "', '" + shipCity + "', '" + payMode + "', " + total + "); " +
                                         "SELECT CAST(SCOPE_IDENTITY() AS int);";
                    cmd = new SqlCommand(insertOrder, con, tr);
                    orderId = Convert.ToInt32(cmd.ExecuteScalar());

                    string insertItems = "INSERT INTO Order_Items_Tbl(Order_Id, Prod_Name, Prod_Img, Price, Qty) " +
                                         "SELECT " + orderId + ", p.Prod_Name, p.Prod_Img, p.Prod_Price, c.Qty FROM Cart_Tbl c " +
                                         "INNER JOIN Add_Products_Tbl p ON c.Prod_Id = p.Prod_Id WHERE c.User_Id = " + Session["uid"];
                    cmd = new SqlCommand(insertItems, con, tr);
                    cmd.ExecuteNonQuery();

                    cmd = new SqlCommand("DELETE FROM Cart_Tbl WHERE User_Id = " + Session["uid"], con, tr);
                    cmd.ExecuteNonQuery();
                }
                tr.Commit();
            }
            catch
            {
                try { tr.Rollback(); } catch { }
                throw;
            }
            finally
            {
                con.Close();
            }

            if (orderId == 0)
                Response.Redirect("Cart.aspx");
            else
                Response.Redirect("OrderSuccess.aspx?id=" + orderId);
        }
    }
}
