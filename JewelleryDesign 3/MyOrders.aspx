<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyOrders.aspx.cs" Inherits="JewelleryDesign.MyOrders" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Orders — Jewellery Design</title>
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
    <p class="eyebrow">Your Account</p>
    <h1>My Orders</h1>
    <p>Track everything you have ordered.</p>
  </div>
</div>

<form id="form1" runat="server">
  <div class="gridview-section" style="margin-top:48px;">
    <h3><i class="fa-solid fa-box" style="color:var(--gold);"></i> My Orders</h3>

    <asp:Panel ID="pnlNone" runat="server" Visible="false" CssClass="cart-empty">
      <i class="fa-solid fa-box"></i>
      <p>You have not placed any order yet.</p>
      <a href="Products.aspx" class="btn btn-gold-grad">Start Shopping</a>
    </asp:Panel>

    <div style="overflow-x:auto;">
      <asp:GridView ID="gvOrders" runat="server" CssClass="gridview-table" AutoGenerateColumns="False" OnRowCommand="gvOrders_RowCommand">
        <Columns>
          <asp:BoundField DataField="Order_Id" HeaderText="Order No" />
          <asp:BoundField DataField="Order_Date" HeaderText="Date" DataFormatString="{0:dd MMM yyyy}" />
          <asp:BoundField DataField="Payment" HeaderText="Payment" />
          <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="&#8377;{0:N0}" />
          <asp:BoundField DataField="Status" HeaderText="Status" />
          <asp:TemplateField HeaderText="Items">
            <ItemTemplate>
              <asp:LinkButton ID="btnView" runat="server" CommandName="cmd_view" CommandArgument='<%# Eval("Order_Id") %>' CssClass="btn-grid-edit">View</asp:LinkButton>
            </ItemTemplate>
          </asp:TemplateField>
        </Columns>
      </asp:GridView>
    </div>

    <asp:Panel ID="pnlItems" runat="server" Visible="false" style="margin-top:32px;">
      <h3><asp:Label ID="lblTitle" runat="server"></asp:Label></h3>
      <div style="overflow-x:auto;">
        <asp:GridView ID="gvItems" runat="server" CssClass="gridview-table" AutoGenerateColumns="False">
          <Columns>
            <asp:TemplateField HeaderText="Image">
              <ItemTemplate>
                <asp:Image ID="Image1" runat="server" Width="60" Height="60" CssClass="cart-img" ImageUrl='<%# "~/" + Eval("Prod_Img") %>' />
              </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Prod_Name" HeaderText="Product" />
            <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="&#8377;{0:N0}" />
            <asp:BoundField DataField="Qty" HeaderText="Qty" />
            <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="&#8377;{0:N0}" />
          </Columns>
        </asp:GridView>
      </div>
    </asp:Panel>
  </div>
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="Scripts/script.js"></script>
</body>
</html>

