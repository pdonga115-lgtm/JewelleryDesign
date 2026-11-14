using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JewelleryDesign
{
    public static class Helper
    {
        public static string ConnStr
        {
            get { return ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString; }
        }

        public static readonly string[] Categories = { "Rings", "Necklaces", "Earrings", "Bangles", "Bracelets", "Pendants", "Chains", "Nose Pins" };
        public static readonly string[] CollectionValues = { "Gold", "Diamond", "Silver", "Bridal", "Mens", "Kids" };
        public static readonly string[] CollectionTexts = { "Gold", "Diamond", "Silver", "Bridal", "Men's", "Kids" };

        public static void FillCategories(DropDownList d, string firstText)
        {
            d.Items.Clear();
            if (!string.IsNullOrEmpty(firstText))
                d.Items.Add(new ListItem(firstText, ""));
            for (int i = 0; i < Categories.Length; i++)
                d.Items.Add(new ListItem(Categories[i], Categories[i]));
        }

        public static void FillCollections(DropDownList d, string firstText)
        {
            d.Items.Clear();
            if (!string.IsNullOrEmpty(firstText))
                d.Items.Add(new ListItem(firstText, ""));
            for (int i = 0; i < CollectionValues.Length; i++)
                d.Items.Add(new ListItem(CollectionTexts[i], CollectionValues[i]));
        }

        public static void RequireLogin(Page page)
        {
            if (page.Session["user"] == null)
            {
                string ret = page.Request.RawUrl;
                page.Response.Redirect("Login.aspx?ret=" + page.Server.UrlEncode(ret));
            }
        }

        public static string SafeLocal(string url, string defaultUrl)
        {
            if (string.IsNullOrEmpty(url)) return defaultUrl;
            if (url.StartsWith("/") && !url.StartsWith("//") && !url.StartsWith("/\\")) return url;
            if (!url.Contains("://") && !url.Contains(@"\")) return url;
            return defaultUrl;
        }

        public static int CartCount()
        {
            var ctx = HttpContext.Current;
            if (ctx == null || ctx.Session == null || ctx.Session["uid"] == null)
                return 0;

            int uid = Convert.ToInt32(ctx.Session["uid"]);
            using (SqlConnection con = new SqlConnection(ConnStr))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand("SELECT ISNULL(SUM(Qty), 0) FROM Cart_Tbl WHERE User_Id = " + uid, con))
                {
                    object o = cmd.ExecuteScalar();
                    return (o != null && o != DBNull.Value) ? Convert.ToInt32(o) : 0;
                }
            }
        }

        public static string NavRight()
        {
            var ctx = HttpContext.Current;
            if (ctx == null || ctx.Session == null) return "";

            if (ctx.Session["admin"] != null)
            {
                string name = HttpUtility.HtmlEncode(Convert.ToString(ctx.Session["admin"]));
                return "<div class=\"dropdown d-inline-block\">" +
                       "<button class=\"btn btn-sm btn-outline-gold dropdown-toggle\" type=\"button\" data-bs-toggle=\"dropdown\">" +
                       "<i class=\"fa-solid fa-crown me-1\"></i> Admin: " + name + "</button>" +
                       "<ul class=\"dropdown-menu dropdown-menu-end\">" +
                       "<li><a class=\"dropdown-item\" href=\"Add_Company.aspx\">Manage Companies</a></li>" +
                       "<li><a class=\"dropdown-item\" href=\"Add_Products.aspx\">Manage Products</a></li>" +
                       "<li><a class=\"dropdown-item\" href=\"Admin_Orders.aspx\">Customer Orders</a></li>" +
                       "<li><hr class=\"dropdown-divider\"></li>" +
                       "<li><a class=\"dropdown-item text-danger\" href=\"Logout.aspx\"><i class=\"fa-solid fa-arrow-right-from-bracket me-1\"></i>Logout</a></li>" +
                       "</ul></div>";
            }

            if (ctx.Session["user"] != null)
            {
                string name = HttpUtility.HtmlEncode(Convert.ToString(ctx.Session["user"]));
                int count = CartCount();
                string badge = count > 0 ? "<span class=\"badge-count\">" + count + "</span>" : "";

                return "<a href=\"Cart.aspx\" class=\"icon-btn position-relative\" aria-label=\"Cart\">" +
                       "<i class=\"fa-solid fa-bag-shopping\"></i>" + badge + "</a>" +
                       "<div class=\"dropdown d-inline-block ms-2\">" +
                       "<button class=\"btn btn-sm btn-outline-gold dropdown-toggle\" type=\"button\" data-bs-toggle=\"dropdown\">" +
                       "<i class=\"fa-regular fa-user me-1\"></i> " + name + "</button>" +
                       "<ul class=\"dropdown-menu dropdown-menu-end\">" +
                       "<li><a class=\"dropdown-item\" href=\"Products.aspx\">Shop Jewellery</a></li>" +
                       "<li><a class=\"dropdown-item\" href=\"Cart.aspx\">My Cart</a></li>" +
                       "<li><a class=\"dropdown-item\" href=\"MyOrders.aspx\">My Orders</a></li>" +
                       "<li><hr class=\"dropdown-divider\"></li>" +
                       "<li><a class=\"dropdown-item text-danger\" href=\"Logout.aspx\"><i class=\"fa-solid fa-arrow-right-from-bracket me-1\"></i>Logout</a></li>" +
                       "</ul></div>";
            }

            return "<a href=\"Login.aspx\" class=\"btn btn-outline-gold me-2\">Login</a>" +
                   "<a href=\"Registration.aspx\" class=\"btn btn-gold\">Register</a>";
        }

        static bool _dbReady = false;
        static readonly object _lock = new object();

        public static void EnsureDb()
        {
            if (_dbReady) return;
            lock (_lock)
            {
                if (_dbReady) return;
                try
                {
                    using (SqlConnection con = new SqlConnection(ConnStr))
                    {
                        con.Open();
                        string[] queries = {
                            "IF OBJECT_ID('dbo.Emp_tbl','U') IS NULL CREATE TABLE dbo.Emp_tbl (Id INT IDENTITY(1,1) PRIMARY KEY, Name NVARCHAR(100), Email NVARCHAR(150), Password NVARCHAR(100), Role NVARCHAR(20) DEFAULT 'User', City NVARCHAR(100), State NVARCHAR(100), Mobile NVARCHAR(20), Pincode NVARCHAR(20), Address NVARCHAR(300))",
                            "IF COL_LENGTH('dbo.Emp_tbl','Role') IS NULL ALTER TABLE dbo.Emp_tbl ADD Role NVARCHAR(20) NOT NULL CONSTRAINT DF_Emp_tbl_Role DEFAULT 'User'",
                            "IF COL_LENGTH('dbo.Emp_tbl','Password') IS NULL ALTER TABLE dbo.Emp_tbl ADD [Password] NVARCHAR(100) NULL",
                            "IF OBJECT_ID('dbo.Add_Company_Tbl','U') IS NULL CREATE TABLE dbo.Add_Company_Tbl (Comp_id INT IDENTITY(1,1) PRIMARY KEY, Comp_Name NVARCHAR(100) NOT NULL, Comp_Owner_Name NVARCHAR(100) NULL, Comp_Email NVARCHAR(150) NULL, Comp_Address NVARCHAR(300) NULL, Comp_Cover_Img NVARCHAR(300) NULL)",
                            "IF OBJECT_ID('dbo.Add_Products_Tbl','U') IS NULL CREATE TABLE dbo.Add_Products_Tbl (Prod_Id INT IDENTITY(1,1) PRIMARY KEY, Prod_Comp_Id INT NOT NULL REFERENCES dbo.Add_Company_Tbl(Comp_id), Prod_Name NVARCHAR(150) NOT NULL, Prod_Model NVARCHAR(100) NULL, Prod_Desc NVARCHAR(500) NULL, Prod_Weight NVARCHAR(50) NULL, Prod_Config NVARCHAR(100) NULL, Prod_Img NVARCHAR(300) NULL, Prod_Price DECIMAL(12,2) NOT NULL DEFAULT 0, Prod_Category NVARCHAR(50) NULL, Prod_Collection NVARCHAR(50) NULL)",
                            "IF COL_LENGTH('dbo.Add_Products_Tbl','Prod_Category') IS NULL ALTER TABLE dbo.Add_Products_Tbl ADD Prod_Category NVARCHAR(50) NULL",
                            "IF COL_LENGTH('dbo.Add_Products_Tbl','Prod_Collection') IS NULL ALTER TABLE dbo.Add_Products_Tbl ADD Prod_Collection NVARCHAR(50) NULL",
                            "IF OBJECT_ID('dbo.Cart_Tbl','U') IS NULL CREATE TABLE dbo.Cart_Tbl (Cart_Id INT IDENTITY(1,1) PRIMARY KEY, User_Id INT NOT NULL REFERENCES dbo.Emp_tbl(Id) ON DELETE CASCADE, Prod_Id INT NOT NULL REFERENCES dbo.Add_Products_Tbl(Prod_Id) ON DELETE CASCADE, Qty INT NOT NULL DEFAULT 1, Added_On DATETIME NOT NULL DEFAULT GETDATE(), CONSTRAINT UQ_Cart_User_Prod UNIQUE (User_Id, Prod_Id))",
                            "IF OBJECT_ID('dbo.Orders_Tbl','U') IS NULL CREATE TABLE dbo.Orders_Tbl (Order_Id INT IDENTITY(1,1) PRIMARY KEY, User_Id INT NOT NULL REFERENCES dbo.Emp_tbl(Id), Full_Name NVARCHAR(100) NOT NULL, Email NVARCHAR(150) NOT NULL, Phone NVARCHAR(30) NOT NULL, Address NVARCHAR(300) NOT NULL, City NVARCHAR(100) NOT NULL, State NVARCHAR(100) NOT NULL, Pincode NVARCHAR(20) NOT NULL, Payment_Method NVARCHAR(50) NOT NULL, Total_Amount DECIMAL(12,2) NOT NULL, Order_Date DATETIME NOT NULL DEFAULT GETDATE(), Order_Status NVARCHAR(50) NOT NULL DEFAULT 'Confirmed')",
                            "IF OBJECT_ID('dbo.Order_Items_Tbl','U') IS NULL CREATE TABLE dbo.Order_Items_Tbl (Item_Id INT IDENTITY(1,1) PRIMARY KEY, Order_Id INT NOT NULL REFERENCES dbo.Orders_Tbl(Order_Id) ON DELETE CASCADE, Prod_Id INT NULL, Prod_Name NVARCHAR(150) NOT NULL, Prod_Price DECIMAL(12,2) NOT NULL, Qty INT NOT NULL, Subtotal DECIMAL(12,2) NOT NULL)",
                            "IF NOT EXISTS (SELECT 1 FROM dbo.Emp_tbl WHERE Role = 'Admin') INSERT INTO dbo.Emp_tbl (Name, Email, [Password], Role) VALUES ('Admin', 'admin@jewellery.com', 'admin123', 'Admin')"
                        };
                        foreach (string q in queries)
                        {
                            using (SqlCommand cmd = new SqlCommand(q, con))
                            {
                                cmd.ExecuteNonQuery();
                            }
                        }
                    }
                    _dbReady = true;
                }
                catch
                {
                }
            }
        }
    }
}
