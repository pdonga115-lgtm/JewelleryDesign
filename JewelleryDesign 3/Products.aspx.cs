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
    public partial class Products : System.Web.UI.Page
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

        void fillCombo()
        {
            getCon();
            da = new SqlDataAdapter("SELECT Comp_id, Comp_Name FROM Add_Company_Tbl ORDER BY Comp_Name", con);
            ds = new DataSet();
            da.Fill(ds);
            con.Close();

            drpComp.Items.Clear();
            drpComp.Items.Add(new ListItem("All Companies", "0"));
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                drpComp.Items.Add(new ListItem(ds.Tables[0].Rows[i]["Comp_Name"].ToString(),
                                               ds.Tables[0].Rows[i]["Comp_id"].ToString()));
            }

            Helper.FillCategories(drpCat, "All Categories");
            Helper.FillCollections(drpCol, "All Collections");

            string cat = Request.QueryString["cat"];
            string col = Request.QueryString["col"];
            string q = Request.QueryString["q"];

            if (cat != null && drpCat.Items.FindByValue(cat) != null) drpCat.SelectedValue = cat;
            if (col != null && drpCol.Items.FindByValue(col) != null) drpCol.SelectedValue = col;
            if (!string.IsNullOrEmpty(q)) txtSearch.Text = q.Trim();
        }

        void fillProducts()
        {
            string order = "p.Prod_Id DESC";
            if (drpSort.SelectedValue == "low") order = "p.Prod_Price ASC";
            else if (drpSort.SelectedValue == "high") order = "p.Prod_Price DESC";

            string searchVal = txtSearch.Text.Trim().Replace("'", "''");
            int compId = Convert.ToInt32(drpComp.SelectedValue);
            string catVal = drpCat.SelectedValue.Replace("'", "''");
            string colVal = drpCol.SelectedValue.Replace("'", "''");

            string query = "SELECT p.*, ISNULL(c.Comp_Name, 'Jewellery Design') AS Comp_Name FROM Add_Products_Tbl p " +
                           "LEFT JOIN Add_Company_Tbl c ON p.Prod_Comp_Id = c.Comp_id WHERE 1=1 ";

            if (!string.IsNullOrEmpty(searchVal))
            {
                query += "AND (p.Prod_Name LIKE '%" + searchVal + "%' OR p.Prod_Model LIKE '%" + searchVal + "%' OR p.Prod_Desc LIKE '%" + searchVal + "%') ";
            }
            if (compId > 0)
            {
                query += "AND p.Prod_Comp_Id = " + compId + " ";
            }
            if (!string.IsNullOrEmpty(catVal))
            {
                query += "AND p.Prod_Category = '" + catVal + "' ";
            }
            if (!string.IsNullOrEmpty(colVal))
            {
                query += "AND p.Prod_Collection = '" + colVal + "' ";
            }

            query += "ORDER BY " + order;

            getCon();
            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);
            con.Close();

            rptProducts.DataSource = ds;
            rptProducts.DataBind();
            lblCount.Text = ds.Tables[0].Rows.Count + " product(s) found";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Helper.RequireLogin(this);
            Helper.EnsureDb();

            if (!IsPostBack)
            {
                fillCombo();
                fillProducts();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            fillProducts();
        }
    }
}
