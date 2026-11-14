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
    public partial class Login : System.Web.UI.Page
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
            Helper.EnsureDb();

            if (!IsPostBack)
            {
                if (Session["admin"] != null)
                {
                    Response.Redirect("Add_Company.aspx");
                }
                if (Session["user"] != null)
                {
                    Response.Redirect("Products.aspx");
                }
                if (Request.QueryString["ret"] != null)
                {
                    lblMsg.Text = "Please login to continue.";
                    lblMsg.Visible = true;
                }
            }
        }

        protected void login_btn_Click(object sender, EventArgs e)
        {
            if (!(string.IsNullOrEmpty(txtemail.Text)) && !(string.IsNullOrEmpty(txtpassword.Text)))
            {
                getCon();

                string userEmail = txtemail.Text.Trim();
                string password = txtpassword.Text.Trim();

                da = new SqlDataAdapter("SELECT * FROM Emp_tbl WHERE (Email='" + userEmail + "' OR Name='" + userEmail + "') AND ([Password]='" + password + "' OR Email='" + password + "')", con);
                ds = new DataSet();
                da.Fill(ds);
                con.Close();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    string role = ds.Tables[0].Rows[0]["Role"].ToString();
                    string nm = ds.Tables[0].Rows[0]["Name"].ToString();
                    int uid = Convert.ToInt32(ds.Tables[0].Rows[0]["Id"]);

                    if (role == "Admin")
                    {
                        Session["admin"] = nm;
                        Response.Redirect("Add_Company.aspx");
                    }
                    else
                    {
                        Session["user"] = nm;
                        Session["uid"] = uid;

                        string ret = Helper.SafeLocal(Request.QueryString["ret"], "Products.aspx");
                        Response.Redirect(ret);
                    }
                }
                else
                {
                    lblMsg.Text = "Invalid Email or Password";
                    lblMsg.Visible = true;
                    Response.Write("<script>alert('Invalid Email or Password')</script>");
                }
            }
            else
            {
                lblMsg.Text = "Please enter email and password.";
                lblMsg.Visible = true;
                Response.Write("<script>alert('Please enter email and password')</script>");
            }
        }
    }
}
