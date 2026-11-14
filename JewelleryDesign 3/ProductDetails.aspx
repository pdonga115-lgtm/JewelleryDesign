<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductDetails.aspx.cs" Inherits="JewelleryDesign.ProductDetails" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Product Details — Jewellery Design</title>
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
    <p class="eyebrow">Product</p>
    <h1>Product Details</h1>
    <p>Everything about this piece.</p>
  </div>
</div>

<form id="form1" runat="server">
  <div class="reg-layout">
    <asp:Panel ID="pnlFound" runat="server" CssClass="detail-wrap">
      <div class="detail-img"><asp:Image ID="imgProd" runat="server" /></div>
      <div class="detail-info">
        <p class="eyebrow"><asp:Label ID="lblCompany" runat="server"></asp:Label></p>
        <h2><asp:Label ID="lblName" runat="server"></asp:Label></h2>
        <div class="price-row"><span class="price detail-price"><asp:Label ID="lblPrice" runat="server"></asp:Label></span></div>
        <p class="detail-desc"><asp:Label ID="lblDesc" runat="server"></asp:Label></p>
        <table class="detail-table">
          <tr><td>Category</td><td><asp:Label ID="lblCategory" runat="server"></asp:Label></td></tr>
          <tr><td>Collection</td><td><asp:Label ID="lblCollection" runat="server"></asp:Label></td></tr>
          <tr><td>Model</td><td><asp:Label ID="lblModel" runat="server"></asp:Label></td></tr>
          <tr><td>Weight</td><td><asp:Label ID="lblWeight" runat="server"></asp:Label></td></tr>
          <tr><td>Configuration</td><td><asp:Label ID="lblConfig" runat="server"></asp:Label></td></tr>
        </table>
        <asp:HyperLink ID="lnkAdd" runat="server" CssClass="btn btn-gold-grad"><i class="fa-solid fa-bag-shopping me-2"></i>Add to Cart</asp:HyperLink>
        <a href="Products.aspx" class="btn btn-outline-gold ms-2">Back to Products</a>
      </div>
    </asp:Panel>
    <asp:Panel ID="pnlNone" runat="server" Visible="false" CssClass="cart-empty" style="width:100%;">
      <i class="fa-solid fa-gem"></i>
      <p>Product not found.</p>
      <a href="Products.aspx" class="btn btn-gold-grad">Back to Products</a>
    </asp:Panel>
  </div>
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="Scripts/script.js"></script>
</body>
</html>

