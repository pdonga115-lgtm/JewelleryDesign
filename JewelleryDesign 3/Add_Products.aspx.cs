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
    public partial class Add_Products : System.Web.UI.Page
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
            if (imgUpload.HasFile)
            {
                fnm = "Images/" + DateTime.Now.Ticks + "_" + imgUpload.FileName;
                imgUpload.SaveAs(Server.MapPath(fnm));
            }
        }

        void fillCombo()
        {
            getCon();
            da = new SqlDataAdapter("SELECT * FROM Add_Company_Tbl ORDER BY Comp_Name", con);
            ds = new DataSet();
            da.Fill(ds);
            con.Close();

            drpcmp.Items.Clear();
            drpcmp.Items.Add(new ListItem("--Select Company--", "0"));
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                drpcmp.Items.Add(new ListItem(ds.Tables[0].Rows[i]["Comp_Name"].ToString(),
                                              ds.Tables[0].Rows[i]["Comp_id"].ToString()));
            }

            Helper.FillCategories(drpCat, "--Select Category--");
            Helper.FillCollections(drpCol, "--Select Collection--");
        }

        void fillGrid()
        {
            getCon();
            da = new SqlDataAdapter("SELECT p.*, ISNULL(c.Comp_Name, 'Unknown') AS Comp_Name FROM Add_Products_Tbl p " +
                                    "LEFT JOIN Add_Company_Tbl c ON p.Prod_Comp_Id = c.Comp_id " +
                                    "ORDER BY p.Prod_Id DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            con.Close();
            gvProducts.DataSource = ds;
            gvProducts.DataBind();
        }

        void fillData()
        {
            getCon();
            da = new SqlDataAdapter("SELECT * FROM Add_Products_Tbl WHERE Prod_Id = '" + ViewState["id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            con.Close();

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow r = ds.Tables[0].Rows[0];
                string compId = r["Prod_Comp_Id"].ToString();
                if (drpcmp.Items.FindByValue(compId) != null)
                    drpcmp.SelectedValue = compId;

                string cat = r["Prod_Category"].ToString();
                if (drpCat.Items.FindByValue(cat) != null)
                    drpCat.SelectedValue = cat;

                string col = r["Prod_Collection"].ToString();
                if (drpCol.Items.FindByValue(col) != null)
                    drpCol.SelectedValue = col;

                txtpnm.Text = r["Prod_Name"].ToString();
                txtmodel.Text = r["Prod_Model"].ToString();
                txtprice.Text = r["Prod_Price"].ToString();
                txtdesc.Text = r["Prod_Desc"].ToString();
                txtweight.Text = r["Prod_Weight"].ToString();
                txtconfig.Text = r["Prod_Config"].ToString();
                ViewState["old_img"] = r["Prod_Img"].ToString();
            }
        }

        void clear()
        {
            if (drpcmp.Items.Count > 0) drpcmp.SelectedIndex = 0;
            if (drpCat.Items.Count > 0) drpCat.SelectedIndex = 0;
            if (drpCol.Items.Count > 0) drpCol.SelectedIndex = 0;
            txtpnm.Text = string.Empty;
            txtmodel.Text = string.Empty;
            txtprice.Text = string.Empty;
            txtdesc.Text = string.Empty;
            txtweight.Text = string.Empty;
            txtconfig.Text = string.Empty;
            ViewState["id"] = null;
            ViewState["old_img"] = null;
            btnAdd.Text = "Add Product";
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
                fillCombo();
                fillGrid();
                lblWelcome.Text = "Welcome, " + Session["admin"].ToString();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            clear();
            lblMsg.Visible = false;
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            decimal price;

            if (drpcmp.SelectedValue == "0" || string.IsNullOrWhiteSpace(txtpnm.Text))
            {
                lblMsg.Text = "Please select a company and enter product name.";
                lblMsg.Visible = true;
                Response.Write("<script>alert('Please select a company and enter product name')</script>");
                return;
            }
            if (drpCat.SelectedValue == "" || drpCol.SelectedValue == "")
            {
                lblMsg.Text = "Please select category and collection.";
                lblMsg.Visible = true;
                Response.Write("<script>alert('Please select category and collection')</script>");
                return;
            }
            if (!decimal.TryParse(txtprice.Text.Trim(), out price) || price < 0)
            {
                lblMsg.Text = "Please enter a valid price.";
                lblMsg.Visible = true;
                Response.Write("<script>alert('Please enter a valid price')</script>");
                return;
            }

            if (btnAdd.Text == "Add Product")
            {
                fileUpload();
                if (string.IsNullOrEmpty(fnm))
                {
                    lblMsg.Text = "Please select a product image.";
                    lblMsg.Visible = true;
                    Response.Write("<script>alert('Please select a product image')</script>");
                    return;
                }

                int cid = Convert.ToInt32(drpcmp.SelectedValue);
                getCon();
                string command = "INSERT INTO Add_Products_Tbl(Prod_Comp_Id, Prod_Name, Prod_Model, Prod_Desc, Prod_Weight, Prod_Config, Prod_Img, Prod_Price, Prod_Category, Prod_Collection) " +
                                 "VALUES('" + cid + "', '" + txtpnm.Text.Trim().Replace("'", "''") + "', '" + txtmodel.Text.Trim().Replace("'", "''") + "', '" + txtdesc.Text.Trim().Replace("'", "''") + "', '" + txtweight.Text.Trim().Replace("'", "''") + "', '" + txtconfig.Text.Trim().Replace("'", "''") + "', '" + fnm + "', '" + price + "', '" + drpCat.SelectedValue.Replace("'", "''") + "', '" + drpCol.SelectedValue.Replace("'", "''") + "')";
                cmd = new SqlCommand(command, con);
                cmd.ExecuteNonQuery();
                con.Close();

                lblMsg.Text = "Product Added Successfully";
                lblMsg.Visible = true;
                Response.Write("<script>alert('Product Added Successfully')</script>");
                clear();
                fillGrid();
            }
            else
            {
                fileUpload();
                string imgPath = string.IsNullOrEmpty(fnm) ? Convert.ToString(ViewState["old_img"]) : fnm;
                int cid = Convert.ToInt32(drpcmp.SelectedValue);

                getCon();
                string command = "UPDATE Add_Products_Tbl SET Prod_Comp_Id='" + cid + "', Prod_Name='" + txtpnm.Text.Trim().Replace("'", "''") + "', Prod_Model='" + txtmodel.Text.Trim().Replace("'", "''") + "', Prod_Desc='" + txtdesc.Text.Trim().Replace("'", "''") + "', Prod_Weight='" + txtweight.Text.Trim().Replace("'", "''") + "', Prod_Config='" + txtconfig.Text.Trim().Replace("'", "''") + "', Prod_Img='" + imgPath + "', Prod_Price='" + price + "', Prod_Category='" + drpCat.SelectedValue.Replace("'", "''") + "', Prod_Collection='" + drpCol.SelectedValue.Replace("'", "''") + "' WHERE Prod_Id='" + ViewState["id"] + "'";
                cmd = new SqlCommand(command, con);
                cmd.ExecuteNonQuery();
                con.Close();

                lblMsg.Text = "Product Updated Successfully";
                lblMsg.Visible = true;
                Response.Write("<script>alert('Product Updated Successfully')</script>");
                clear();
                fillGrid();
            }
        }

        protected void gvProducts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_edt")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ViewState["id"] = id;
                btnAdd.Text = "Update Product";
                btnCancel.Visible = true;
                fillData();
            }
            else if (e.CommandName == "cmd_dlt")
            {
                getCon();
                cmd = new SqlCommand("DELETE FROM Add_Products_Tbl WHERE Prod_Id = '" + e.CommandArgument + "'", con);
                cmd.ExecuteNonQuery();
                con.Close();

                clear();
                fillGrid();
                lblMsg.Text = "Product Deleted Successfully";
                lblMsg.Visible = true;
                Response.Write("<script>alert('Product Deleted Successfully')</script>");
            }
        }
    }
}
