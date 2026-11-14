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
    public partial class Registration : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;
        string fnm;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        void getCon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void fileUpload()
        {
            if (flpimg.HasFile)
            {
                fnm = "Images/" + DateTime.Now.Ticks + "_" + flpimg.FileName;
                flpimg.SaveAs(Server.MapPath(fnm));
            }
        }

        void fillGrid()
        {
            getCon();
            da = new SqlDataAdapter("SELECT * FROM Emp_tbl ORDER BY Id DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            con.Close();
            gvUsers.DataSource = ds;
            gvUsers.DataBind();
        }

        void clear()
        {
            txtName.Text = string.Empty;
            txtAddress.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtMobile.Text = string.Empty;
            txtPass.Text = string.Empty;
            txtConfirm.Text = string.Empty;
            rabgen.SelectedIndex = -1;
            ddlCity.SelectedIndex = 0;
            ViewState["id"] = null;
            ViewState["old_img"] = null;
            Save.Text = "Register Now";
            btnCancel.Visible = false;
        }

        void fillData()
        {
            getCon();
            da = new SqlDataAdapter("SELECT * FROM Emp_tbl WHERE Id = '" + ViewState["id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            con.Close();

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow row = ds.Tables[0].Rows[0];
                txtName.Text = row["Name"].ToString();
                if (rabgen.Items.FindByValue(row["Gender"].ToString()) != null)
                    rabgen.SelectedValue = row["Gender"].ToString();
                txtEmail.Text = row["Email"].ToString();
                if (ddlCity.Items.FindByValue(row["City"].ToString()) != null)
                    ddlCity.SelectedValue = row["City"].ToString();
                txtAddress.Text = row["Address"].ToString();
                txtMobile.Text = row["Mobile"].ToString();
                ViewState["old_img"] = row["Image"].ToString();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Helper.EnsureDb();

            divMembers.Visible = Session["admin"] != null;

            if (!IsPostBack && Session["admin"] != null)
            {
                fillGrid();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            bool isNew = (Save.Text == "Register Now");

            if (string.IsNullOrWhiteSpace(txtName.Text) ||
                string.IsNullOrWhiteSpace(txtEmail.Text) ||
                string.IsNullOrWhiteSpace(txtMobile.Text))
            {
                lblMsg.Text = "Please fill in all required fields.";
                lblMsg.Visible = true;
                Response.Write("<script>alert('Please fill in all required fields')</script>");
                return;
            }

            if (isNew && string.IsNullOrEmpty(txtPass.Text))
            {
                lblMsg.Text = "Please create a password.";
                lblMsg.Visible = true;
                Response.Write("<script>alert('Please create a password')</script>");
                return;
            }

            if (!string.IsNullOrEmpty(txtPass.Text))
            {
                if (txtPass.Text.Length < 4)
                {
                    lblMsg.Text = "Password must be at least 4 characters.";
                    lblMsg.Visible = true;
                    Response.Write("<script>alert('Password must be at least 4 characters')</script>");
                    return;
                }
                if (txtPass.Text != txtConfirm.Text)
                {
                    lblMsg.Text = "Password and Confirm Password do not match.";
                    lblMsg.Visible = true;
                    Response.Write("<script>alert('Password and Confirm Password do not match')</script>");
                    return;
                }
            }

            if (isNew)
            {
                getCon();
                da = new SqlDataAdapter("SELECT COUNT(*) FROM Emp_tbl WHERE Email='" + txtEmail.Text.Trim().Replace("'", "''") + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                int exists = Convert.ToInt32(ds.Tables[0].Rows[0][0]);
                con.Close();

                if (exists > 0)
                {
                    lblMsg.Text = "This email is already registered. Please login.";
                    lblMsg.Visible = true;
                    Response.Write("<script>alert('This email is already registered. Please login.')</script>");
                    return;
                }

                fileUpload();
                string gender = rabgen.SelectedValue;
                string city = ddlCity.SelectedValue;

                getCon();
                string command = "INSERT INTO Emp_tbl (Name,Gender,Email,City,Address,Mobile,Image,Role,[Password]) VALUES('" +
                                 txtName.Text.Trim().Replace("'", "''") + "','" +
                                 gender + "','" +
                                 txtEmail.Text.Trim().Replace("'", "''") + "','" +
                                 city + "','" +
                                 txtAddress.Text.Trim().Replace("'", "''") + "','" +
                                 txtMobile.Text.Trim().Replace("'", "''") + "','" +
                                 fnm + "','User','" +
                                 txtPass.Text.Replace("'", "''") + "'); SELECT CAST(SCOPE_IDENTITY() AS int);";
                cmd = new SqlCommand(command, con);
                int newId = Convert.ToInt32(cmd.ExecuteScalar());
                con.Close();

                if (Session["admin"] == null)
                {
                    Session["user"] = txtName.Text.Trim();
                    Session["uid"] = newId;
                    Response.Redirect("Products.aspx");
                }
                else
                {
                    lblMsg.Text = "Member registered successfully.";
                    lblMsg.Visible = true;
                    Response.Write("<script>alert('Member registered successfully')</script>");
                    clear();
                    fillGrid();
                }
            }
            else
            {
                fileUpload();
                string imgPath = string.IsNullOrEmpty(fnm) ? Convert.ToString(ViewState["old_img"]) : fnm;
                string pwdUpdate = string.IsNullOrEmpty(txtPass.Text) ? "" : ", [Password]='" + txtPass.Text.Replace("'", "''") + "'";

                getCon();
                string command = "UPDATE Emp_tbl SET Name='" + txtName.Text.Trim().Replace("'", "''") +
                                 "', Gender='" + rabgen.SelectedValue +
                                 "', Email='" + txtEmail.Text.Trim().Replace("'", "''") +
                                 "', City='" + ddlCity.SelectedValue +
                                 "', Address='" + txtAddress.Text.Trim().Replace("'", "''") +
                                 "', Mobile='" + txtMobile.Text.Trim().Replace("'", "''") +
                                 "', Image='" + imgPath + "'" + pwdUpdate +
                                 " WHERE Id='" + ViewState["id"] + "'";
                cmd = new SqlCommand(command, con);
                cmd.ExecuteNonQuery();
                con.Close();

                clear();
                fillGrid();
                lblMsg.Text = "Member details updated successfully.";
                lblMsg.Visible = true;
                Response.Write("<script>alert('Member details updated successfully')</script>");
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            clear();
            lblMsg.Visible = false;
            if (Session["admin"] != null) fillGrid();
        }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (Session["admin"] == null) return;

            if (e.CommandName == "cmd_edt")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ViewState["id"] = id;
                Save.Text = "Update";
                btnCancel.Visible = true;
                fillData();
                lblMsg.Text = "Edit details and click Update.";
                lblMsg.Visible = true;
            }
            else if (e.CommandName == "cmd_del")
            {
                getCon();
                cmd = new SqlCommand("DELETE FROM Emp_tbl WHERE Id = '" + e.CommandArgument + "' AND Role <> 'Admin'", con);
                cmd.ExecuteNonQuery();
                con.Close();

                clear();
                fillGrid();
                lblMsg.Text = "Member deleted successfully.";
                lblMsg.Visible = true;
                Response.Write("<script>alert('Member deleted successfully')</script>");
            }
        }
    }
}
