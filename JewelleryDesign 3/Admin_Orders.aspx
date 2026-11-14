<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin_Orders.aspx.cs" Inherits="JewelleryDesign.Admin_Orders" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>All Orders — Jewellery Design</title>
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
    <p class="eyebrow">Admin Panel</p>
    <h1>All Orders</h1>
    <p>See every order and update its status.</p>
  </div>
</div>

<form id="form1" runat="server">
  <div class="gridview-section" style="margin-top:48px; max-width:1300px;">
    <h3><i class="fa-solid fa-box" style="color:var(--gold);"></i> Customer Orders</h3>
    <asp:Label ID="lblMsg" runat="server" CssClass="success-msg" Visible="false"></asp:Label>
    <div style="overflow-x:auto;">
      <asp:GridView ID="gvOrders" runat="server" CssClass="gridview-table" AutoGenerateColumns="False"
        EmptyDataText="No orders yet." OnRowCommand="gvOrders_RowCommand" OnRowDataBound="gvOrders_RowDataBound">
        <Columns>
          <asp:BoundField DataField="Order_Id" HeaderText="Order No" />
          <asp:BoundField DataField="Order_Date" HeaderText="Date" DataFormatString="{0:dd MMM yyyy}" />
          <asp:BoundField DataField="Ship_Name" HeaderText="Customer" />
          <asp:BoundField DataField="Ship_Mobile" HeaderText="Mobile" />
          <asp:BoundField DataField="Ship_Address" HeaderText="Address" />
          <asp:BoundField DataField="Ship_City" HeaderText="City" />
          <asp:BoundField DataField="ItemList" HeaderText="Items" />
          <asp:BoundField DataField="Payment" HeaderText="Payment" />
          <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="&#8377;{0:N0}" />
          <asp:TemplateField HeaderText="Status">
            <ItemTemplate>
              <asp:DropDownList ID="ddlStatus" runat="server" CssClass="textbox" style="min-width:120px;">
                <asp:ListItem>Pending</asp:ListItem>
                <asp:ListItem>Confirmed</asp:ListItem>
                <asp:ListItem>Shipped</asp:ListItem>
                <asp:ListItem>Delivered</asp:ListItem>
                <asp:ListItem>Cancelled</asp:ListItem>
              </asp:DropDownList>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Save">
            <ItemTemplate>
              <asp:LinkButton ID="btnUpd" runat="server" CommandName="cmd_upd" CommandArgument='<%# Eval("Order_Id") %>' CssClass="btn-grid-edit">Update</asp:LinkButton>
            </ItemTemplate>
          </asp:TemplateField>
        </Columns>
      </asp:GridView>
    </div>
  </div>
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="Scripts/script.js"></script>
</body>
</html>

