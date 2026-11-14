<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="JewelleryDesign.Products" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>All Products — Jewellery Design</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,500;0,600;0,700;1,500&family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
  <link rel="stylesheet" href="Styles/style.css">
</head>
<body>

<nav class="navbar navbar-expand-lg fixed-top" id="mainNav">
  <div class="container-fluid px-3 px-lg-5">
    <a class="navbar-brand" href="Default.aspx">
      <span class="brand-mark">J</span><span class="brand-word">Jewellery<em>Design</em></span>
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMain" aria-label="Toggle navigation">
      <i class="fa-solid fa-bars"></i>
    </button>
    <div class="collapse navbar-collapse" id="navMain">
      <ul class="navbar-nav mx-auto main-links">
        <li class="nav-item"><a class="nav-link" href="Default.aspx#home">Home</a></li>
        <li class="nav-item"><a class="nav-link" href="Products.aspx">Shop</a></li>
        <li class="nav-item"><a class="nav-link" href="Default.aspx#collections">Collections</a></li>
        <li class="nav-item"><a class="nav-link" href="Default.aspx#contact">Contact</a></li>
      </ul>
      <div class="d-flex align-items-center nav-icons">
        <button class="icon-btn" id="themeToggle" type="button" aria-label="Toggle dark mode"><i class="fa-regular fa-moon"></i></button>
        <%= Helper.NavRight() %>
      </div>
    </div>
  </div>
</nav>

<div class="reg-hero">
  <img class="reg-hero-img" src="https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?q=80&w=1400&auto=format&fit=crop" alt="Jewellery banner" />
  <div class="reg-hero-content">
    <p class="eyebrow">Our Collection</p>
    <h1>Shop Jewellery</h1>
    <p>Search, filter by category or collection and add your favourites to the cart.</p>
  </div>
</div>

<form id="form1" runat="server">
  <div class="gridview-section" style="margin-top:40px;">
    <div class="shop-filter">
      <asp:TextBox ID="txtSearch" runat="server" CssClass="textbox" placeholder="Search by name or model"></asp:TextBox>
      <asp:DropDownList ID="drpCat" runat="server" CssClass="textbox" AutoPostBack="True" OnSelectedIndexChanged="btnSearch_Click"></asp:DropDownList>
      <asp:DropDownList ID="drpCol" runat="server" CssClass="textbox" AutoPostBack="True" OnSelectedIndexChanged="btnSearch_Click"></asp:DropDownList>
      <asp:DropDownList ID="drpComp" runat="server" CssClass="textbox" AutoPostBack="True" OnSelectedIndexChanged="btnSearch_Click"></asp:DropDownList>
      <asp:DropDownList ID="drpSort" runat="server" CssClass="textbox" AutoPostBack="True" OnSelectedIndexChanged="btnSearch_Click">
        <asp:ListItem Value="new">Newest first</asp:ListItem>
        <asp:ListItem Value="low">Price: Low to High</asp:ListItem>
        <asp:ListItem Value="high">Price: High to Low</asp:ListItem>
      </asp:DropDownList>
      <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn-save" OnClick="btnSearch_Click" />
    </div>
    <p class="prod-meta"><asp:Label ID="lblCount" runat="server"></asp:Label></p>

    <div class="row g-4">
      <asp:Repeater ID="rptProducts" runat="server">
        <ItemTemplate>
          <div class="col-md-6 col-lg-3">
            <div class="product-card">
              <div class="product-media">
                <a href='ProductDetails.aspx?pid=<%# Eval("Prod_Id") %>'>
                  <img src='<%# ResolveUrl("~/" + Convert.ToString(Eval("Prod_Img"))) %>' alt='<%# Server.HtmlEncode(Convert.ToString(Eval("Prod_Name"))) %>'>
                </a>
              </div>
              <div class="product-body">
                <h4><a href='ProductDetails.aspx?pid=<%# Eval("Prod_Id") %>'><%# Server.HtmlEncode(Convert.ToString(Eval("Prod_Name"))) %></a></h4>
                <p class="prod-meta"><%# Server.HtmlEncode(Convert.ToString(Eval("Comp_Name"))) %> &middot; <%# Server.HtmlEncode(Convert.ToString(Eval("Prod_Category"))) %> &middot; <%# Server.HtmlEncode(Convert.ToString(Eval("Prod_Weight"))) %></p>
                <div class="price-row"><span class="price">&#8377;<%# string.Format("{0:N0}", Eval("Prod_Price")) %></span></div>
                <a href='AddToCart.aspx?pid=<%# Eval("Prod_Id") %>&ret=Products.aspx' class="btn btn-add-cart w-100"><i class="fa-solid fa-bag-shopping me-2"></i>Add to Cart</a>
              </div>
            </div>
          </div>
        </ItemTemplate>
      </asp:Repeater>
    </div>
  </div>
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="Scripts/script.js"></script>
</body>
</html>

