<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="JewelleryDesign.Checkout" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Checkout — Jewellery Design</title>
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
    <p class="eyebrow">Almost There</p>
    <h1>Checkout</h1>
    <p>Confirm your delivery details and place the order.</p>
  </div>
</div>

<form id="form1" runat="server">
  <div class="reg-layout">
    <div class="reg-section">
      <div class="reg-card">
        <div class="reg-card-header">
          <i class="fa-solid fa-truck-fast reg-gem-icon"></i>
          <h2>Delivery Details</h2>
        </div>
        <asp:Label ID="lblMsg" runat="server" CssClass="success-msg" Visible="false"></asp:Label>
        <table class="form-table">
          <tr><td>Full Name</td><td class="auto-style1"><asp:TextBox ID="txtName" runat="server" CssClass="textbox"></asp:TextBox></td></tr>
          <tr><td>Mobile No.</td><td class="auto-style1"><asp:TextBox ID="txtMobile" runat="server" CssClass="textbox" MaxLength="10"></asp:TextBox></td></tr>
          <tr><td>Address</td><td class="auto-style1"><asp:TextBox ID="txtAddress" runat="server" CssClass="textbox" TextMode="MultiLine" Rows="3"></asp:TextBox></td></tr>
          <tr><td>City</td><td class="auto-style1"><asp:TextBox ID="txtCity" runat="server" CssClass="textbox"></asp:TextBox></td></tr>
          <tr>
            <td>Payment</td>
            <td class="auto-style1">
              <asp:RadioButtonList ID="rblPay" runat="server" CssClass="radiobtn-list" RepeatDirection="Vertical">
                <asp:ListItem Selected="True">Cash on Delivery</asp:ListItem>
                <asp:ListItem>Online Payment (Demo)</asp:ListItem>
              </asp:RadioButtonList>
            </td>
          </tr>
          <tr>
            <td></td>
            <td class="auto-style1"><asp:Button ID="btnPlace" runat="server" Text="Place Order" CssClass="btn-save" OnClick="btnPlace_Click" /></td>
          </tr>
        </table>
      </div>
    </div>

    <div class="reg-side">
      <div class="reg-side-card" style="padding-bottom:20px;">
        <h3><i class="fa-solid fa-bag-shopping me-2"></i>Order Summary</h3>
        <asp:GridView ID="gvSummary" runat="server" CssClass="gridview-table" AutoGenerateColumns="False" ShowHeader="False" GridLines="None">
          <Columns>
            <asp:TemplateField>
              <ItemTemplate>
                <strong><%# Server.HtmlEncode(Convert.ToString(Eval("Prod_Name"))) %></strong><br />
                <small style="color:var(--text-muted);">Qty <%# Eval("Qty") %></small>
              </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Subtotal" DataFormatString="&#8377;{0:N0}" />
          </Columns>
        </asp:GridView>
        <div class="cart-total" style="padding:0 24px;">
          <span>Total</span>
          <strong style="font-size:1.4rem;"><asp:Label ID="lblTotal" runat="server"></asp:Label></strong>
        </div>
        <p style="padding:0 24px;"><a href="Cart.aspx" class="login-hint">&larr; Back to cart</a></p>
      </div>
    </div>
  </div>
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="Scripts/script.js"></script>
</body>
</html>

