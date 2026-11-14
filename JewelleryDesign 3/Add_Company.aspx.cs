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
    public partial class Add_Company : System.Web.UI.Page
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

        void filUpload()
        {
            if (imgUpload.HasFile)
            {
                fnm = "Images/" + DateTime.Now.Ticks + "_" + imgUpload.FileName;
                imgUpload.SaveAs(Server.MapPath(fnm));
            }
        }

        void fillGrid()
        {
            getCon();
            da = new SqlDataAdapter("SELECT * FROM Add_Company_Tbl ORDER BY Comp_id DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            con.Close();
            gvCompany.DataSource = ds;
            gvCompany.DataBind();
        }

        void fillData()
        {
            getCon();
            da = new SqlDataAdapter("SELECT * FROM Add_Company_Tbl WHERE Comp_id = '" + ViewState["id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            con.Close();

            if (ds.Tables[0].Rows.Count > 0)
            {
                txtnm.Text = ds.Tables[0].Rows[0]["Comp_Name"].ToString();
                txtonm.Text = ds.Tables[0].Rows[0]["Comp_Owner_Name"].ToString();
                txteml.Text = ds.Tables[0].Rows[0]["Comp_Email"].ToString();
                txtadd.Text = ds.Tables[0].Rows[0]["Comp_Address"].ToString();
                ViewState["old_img"] = ds.Tables[0].Rows[0]["Comp_Cover_Img"].ToString();
            }
        }

        void clear()
        {
            txtnm.Text = string.Empty;
            txtadd.Text = string.Empty;
            txteml.Text = string.Empty;
            txtonm.Text = string.Empty;
            ViewState["id"] = null;
            ViewState["old_img"] = null;
            add_comp_btn.Text = "Add Company";
            btnCancel.Visible = false;
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
                lblresult.Text = "Welcome, " + Session["admin"].ToString();
                fillGrid();
            }
        }

        protected void LinkButton1_Click1(object sender, EventArgs e)
        {
            Response.Redirect("Add_Products.aspx");
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            clear();
            lblMsg.Visible = false;
        }

        protected void add_comp_btn_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtnm.Text))
            {
                lblMsg.Text = "Please enter company name.";
                lblMsg.Visible = true;
                Response.Write("<script>alert('Please enter company name')</script>");
                return;
            }

            if (add_comp_btn.Text == "Add Company")
            {
                filUpload();
                if (string.IsNullOrEmpty(fnm))
                {
                    lblMsg.Text = "Please select a cover image.";
                    lblMsg.Visible = true;
                    Response.Write("<script>alert('Please select a cover image')</script>");
                    return;
                }

                getCon();
                string command = "INSERT INTO Add_Company_Tbl(Comp_Name, Comp_Owner_Name, Comp_Email, Comp_Address, Comp_Cover_Img) VALUES('" + txtnm.Text.Trim().Replace("'", "''") + "','" + txtonm.Text.Trim().Replace("'", "''") + "','" + txteml.Text.Trim().Replace("'", "''") + "','" + txtadd.Text.Trim().Replace("'", "''") + "','" + fnm + "')";
                cmd = new SqlCommand(command, con);
                cmd.ExecuteNonQuery();
                con.Close();

                clear();
                fillGrid();
                lblMsg.Text = "Company Added Successfully";
                lblMsg.Visible = true;
                Response.Write("<script>alert('Company Added Successfully')</script>");
            }
            else
            {
                filUpload();
                string imgPath = string.IsNullOrEmpty(fnm) ? Convert.ToString(ViewState["old_img"]) : fnm;

                getCon();
                string command = "UPDATE Add_Company_Tbl SET Comp_Name='" + txtnm.Text.Trim().Replace("'", "''") + "', Comp_Owner_Name='" + txtonm.Text.Trim().Replace("'", "''") + "', Comp_Email='" + txteml.Text.Trim().Replace("'", "''") + "', Comp_Address='" + txtadd.Text.Trim().Replace("'", "''") + "', Comp_Cover_Img='" + imgPath + "' WHERE Comp_id='" + ViewState["id"] + "'";
                cmd = new SqlCommand(command, con);
                cmd.ExecuteNonQuery();
                con.Close();

                clear();
                fillGrid();
                lblMsg.Text = "Company Updated Successfully";
                lblMsg.Visible = true;
                Response.Write("<script>alert('Company Updated Successfully')</script>");
            }
        }

        protected void gvCompany_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_edt")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ViewState["id"] = id;
                add_comp_btn.Text = "Update Company";
                btnCancel.Visible = true;
                fillData();
            }
            else if (e.CommandName == "cmd_dlt")
            {
                getCon();
                cmd = new SqlCommand("DELETE FROM Add_Company_Tbl WHERE Comp_id = '" + e.CommandArgument + "'", con);
                cmd.ExecuteNonQuery();
                con.Close();

                clear();
                fillGrid();
                lblMsg.Text = "Company Deleted Successfully";
                lblMsg.Visible = true;
                Response.Write("<script>alert('Company Deleted Successfully')</script>");
            }
        }
    }
}
