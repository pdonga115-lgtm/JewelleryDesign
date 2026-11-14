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
    public partial class ProductDetails : System.Web.UI.Page
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
            Helper.RequireLogin(this);
            Helper.EnsureDb();

            if (IsPostBack) return;

            int pid;
            if (!int.TryParse(Request.QueryString["pid"], out pid))
            {
                pnlFound.Visible = false;
                pnlNone.Visible = true;
                return;
            }

            getCon();
            da = new SqlDataAdapter("SELECT p.*, ISNULL(c.Comp_Name, 'Jewellery Design') AS Comp_Name FROM Add_Products_Tbl p " +
                                    "LEFT JOIN Add_Company_Tbl c ON p.Prod_Comp_Id = c.Comp_id " +
                                    "WHERE p.Prod_Id = " + pid, con);
            ds = new DataSet();
            da.Fill(ds);
            con.Close();

            if (ds.Tables[0].Rows.Count == 0)
            {
                pnlFound.Visible = false;
                pnlNone.Visible = true;
                return;
            }

            DataRow r = ds.Tables[0].Rows[0];
            imgProd.ImageUrl = "~/" + r["Prod_Img"].ToString();
            lblCompany.Text = Server.HtmlEncode(r["Comp_Name"].ToString());
            lblName.Text = Server.HtmlEncode(r["Prod_Name"].ToString());
            lblPrice.Text = "\u20B9" + Convert.ToDecimal(r["Prod_Price"]).ToString("N0");
            lblDesc.Text = Server.HtmlEncode(r["Prod_Desc"].ToString());
            lblCategory.Text = Server.HtmlEncode(r["Prod_Category"].ToString());

            string colVal = r["Prod_Collection"].ToString();
            int ci = Array.IndexOf(Helper.CollectionValues, colVal);
            lblCollection.Text = Server.HtmlEncode(ci >= 0 ? Helper.CollectionTexts[ci] : colVal);

            lblModel.Text = Server.HtmlEncode(r["Prod_Model"].ToString());
            lblWeight.Text = Server.HtmlEncode(r["Prod_Weight"].ToString());
            lblConfig.Text = Server.HtmlEncode(r["Prod_Config"].ToString());

            lnkAdd.NavigateUrl = "AddToCart.aspx?pid=" + pid + "&ret=" + Server.UrlEncode("ProductDetails.aspx?pid=" + pid);
            lnkAdd.Visible = Session["admin"] == null;
        }
    }
}
