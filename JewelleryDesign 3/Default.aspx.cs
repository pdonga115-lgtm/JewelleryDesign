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
    public partial class Default : System.Web.UI.Page
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

        void fillProducts()
        {
            try
            {
                getCon();
                da = new SqlDataAdapter("SELECT TOP 8 p.*, ISNULL(c.Comp_Name, 'Jewellery Design') AS Comp_Name FROM Add_Products_Tbl p " +
                                        "LEFT JOIN Add_Company_Tbl c ON p.Prod_Comp_Id = c.Comp_id " +
                                        "ORDER BY p.Prod_Id DESC", con);
                ds = new DataSet();
                da.Fill(ds);
                con.Close();

                rptProducts.DataSource = ds;
                rptProducts.DataBind();

                if (ds.Tables[0].Rows.Count == 0)
                {
                    litEmpty.Text = "<div class=\"col-12 text-center\"><p class=\"prod-meta\">No products yet. Admin can add products from the Add Products page.</p></div>";
                }
            }
            catch (Exception ex)
            {
                litEmpty.Text = "<div class=\"col-12 text-center\"><p class=\"prod-meta\">Unable to load products. Error: " + Server.HtmlEncode(ex.Message) + "</p></div>";
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Helper.EnsureDb();
            if (!IsPostBack)
            {
                fillProducts();
            }
        }
    }
}
