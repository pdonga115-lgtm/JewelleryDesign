<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="JewelleryDesign.Cart" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Cart — Jewellery Design</title>
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
    <p class="eyebrow">Shopping Bag</p>
    <h1>Your Cart</h1>
    <p>Review the jewellery you have added.</p>
  </div>
</div>

<form id="form1" runat="server">
  <div class="gridview-section" style="margin-top:48px;">
    <h3><i class="fa-solid fa-bag-shopping" style="color:var(--gold);"></i> My Cart</h3>

    <asp:Label ID="lblMsg" runat="server" CssClass="success-msg" Visible="false"></asp:Label>

    <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="cart-empty">
      <i class="fa-solid fa-bag-shopping"></i>
      <p>Your cart is empty.</p>
      <a href="Products.aspx" class="btn btn-gold-grad">Start Shopping</a>
    </asp:Panel>

    <asp:Panel ID="pnlCart" runat="server">
      <div style="overflow-x:auto;">
        <asp:GridView ID="gvCart" runat="server" CssClass="gridview-table" AutoGenerateColumns="False"
          OnRowCommand="gvCart_RowCommand">
          <Columns>
            <asp:TemplateField HeaderText="Image">
              <ItemTemplate>
                <asp:Image ID="Image1" runat="server" Width="70" Height="70" CssClass="cart-img" ImageUrl='<%# "~/" + Eval("Prod_Img") %>' />
              </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Product">
              <ItemTemplate>
                <strong><asp:Label ID="Label1" runat="server" Text='<%# Server.HtmlEncode(Convert.ToString(Eval("Prod_Name"))) %>'></asp:Label></strong><br />
                <small style="color:var(--text-muted);"><asp:Label ID="Label2" runat="server" Text='<%# Server.HtmlEncode(Convert.ToString(Eval("Comp_Name"))) %>'></asp:Label></small>
              </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Prod_Price" HeaderText="Price" DataFormatString="&#8377;{0:N0}" />
            <asp:TemplateField HeaderText="Quantity">
              <ItemTemplate>
                <asp:LinkButton ID="btnDec" runat="server" CommandName="cmd_dec" CommandArgument='<%# Eval("Cart_Id") %>' CssClass="qty-btn">&minus;</asp:LinkButton>
                <span class="qty-num"><%# Eval("Qty") %></span>
                <asp:LinkButton ID="btnInc" runat="server" CommandName="cmd_inc" CommandArgument='<%# Eval("Cart_Id") %>' CssClass="qty-btn">+</asp:LinkButton>
              </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="&#8377;{0:N0}" />
            <asp:TemplateField HeaderText="Remove">
              <ItemTemplate>
                <asp:LinkButton ID="btnRem" runat="server" CommandName="cmd_rem" CommandArgument='<%# Eval("Cart_Id") %>' CssClass="btn-grid-delete">Remove</asp:LinkButton>
              </ItemTemplate>
            </asp:TemplateField>
          </Columns>
        </asp:GridView>
      </div>

      <div class="cart-total">
        <span>Total</span>
        <strong><asp:Label ID="lblTotal" runat="server"></asp:Label></strong>
      </div>
      <p style="text-align:right;">
        <a href="Products.aspx" class="btn btn-outline-gold">Continue Shopping</a>
        <asp:Button ID="btnCheckout" runat="server" Text="Proceed to Checkout" CssClass="btn-save ms-2" OnClick="btnCheckout_Click" />
      </p>
    </asp:Panel>
  </div>
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="Scripts/script.js"></script>
</body>
</html>

