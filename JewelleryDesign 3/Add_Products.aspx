<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Add_Products.aspx.cs" Inherits="JewelleryDesign.Add_Products" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Add Products — Jewellery Design</title>
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
    <h1>Add Products</h1>
    <p>Products added here appear on the home page and the Products page.</p>
  </div>
</div>

<form id="form1" runat="server" enctype="multipart/form-data">
  <div class="reg-layout" style="justify-content:center;">
    <div class="reg-section" style="max-width:720px;">
      <div class="reg-card">
        <div class="reg-card-header">
          <i class="fa-solid fa-gem reg-gem-icon"></i>
          <h2>Add Products</h2>
        </div>

        <p><asp:Label ID="lblWelcome" runat="server"></asp:Label></p>
        <asp:Label ID="lblMsg" runat="server" CssClass="success-msg" Visible="false"></asp:Label>

        <table class="form-table">
          <tr><td>Product Company</td><td class="auto-style1"><asp:DropDownList ID="drpcmp" runat="server" CssClass="textbox"></asp:DropDownList></td></tr>
          <tr><td>Category</td><td class="auto-style1"><asp:DropDownList ID="drpCat" runat="server" CssClass="textbox"></asp:DropDownList></td></tr>
          <tr><td>Collection</td><td class="auto-style1"><asp:DropDownList ID="drpCol" runat="server" CssClass="textbox"></asp:DropDownList></td></tr>
          <tr><td>Product Name</td><td class="auto-style1"><asp:TextBox ID="txtpnm" runat="server" CssClass="textbox"></asp:TextBox></td></tr>
          <tr><td>Product Model</td><td class="auto-style1"><asp:TextBox ID="txtmodel" runat="server" CssClass="textbox"></asp:TextBox></td></tr>
          <tr><td>Product Price (&#8377;)</td><td class="auto-style1"><asp:TextBox ID="txtprice" runat="server" CssClass="textbox" placeholder="e.g. 84999"></asp:TextBox></td></tr>
          <tr><td>Product Description</td><td class="auto-style1"><asp:TextBox ID="txtdesc" runat="server" CssClass="textbox" TextMode="MultiLine" Rows="3"></asp:TextBox></td></tr>
          <tr><td>Product Weight</td><td class="auto-style1"><asp:TextBox ID="txtweight" runat="server" CssClass="textbox" placeholder="e.g. 12 g"></asp:TextBox></td></tr>
          <tr><td>Product Configuration</td><td class="auto-style1"><asp:TextBox ID="txtconfig" runat="server" CssClass="textbox" placeholder="e.g. 22K Gold"></asp:TextBox></td></tr>
          <tr><td>Product Image</td><td class="auto-style1"><asp:FileUpload ID="imgUpload" runat="server" CssClass="file-upload" /></td></tr>
          <tr>
            <td></td>
            <td class="auto-style1">
              <asp:Button ID="btnAdd" runat="server" Text="Add Product" CssClass="btn-save" OnClick="btnAdd_Click" />
              <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn-cancel ms-2" OnClick="btnCancel_Click" Visible="false" />
            </td>
          </tr>
        </table>
      </div>
    </div>
  </div>

  <div class="gridview-section">
    <h3><i class="fa-solid fa-gem" style="color:var(--gold);"></i> All Products</h3>
    <div style="overflow-x:auto;">
      <asp:GridView ID="gvProducts" runat="server" CssClass="gridview-table" AutoGenerateColumns="False"
        EmptyDataText="No products added yet." OnRowCommand="gvProducts_RowCommand">
        <Columns>
          <asp:BoundField DataField="Prod_Id" HeaderText="ID" />
          <asp:TemplateField HeaderText="Image">
            <ItemTemplate>
              <asp:Image ID="Image1" runat="server" Width="55" Height="55" CssClass="cart-img" ImageUrl='<%# "~/" + Eval("Prod_Img") %>' />
            </ItemTemplate>
          </asp:TemplateField>
          <asp:BoundField DataField="Prod_Name" HeaderText="Product" />
          <asp:BoundField DataField="Comp_Name" HeaderText="Company" />
          <asp:BoundField DataField="Prod_Category" HeaderText="Category" />
          <asp:BoundField DataField="Prod_Collection" HeaderText="Collection" />
          <asp:BoundField DataField="Prod_Weight" HeaderText="Weight" />
          <asp:BoundField DataField="Prod_Price" HeaderText="Price" DataFormatString="&#8377;{0:N0}" />
          <asp:TemplateField HeaderText="Edit">
            <ItemTemplate>
              <asp:LinkButton ID="lnkEdit" runat="server" CommandArgument='<%# Eval("Prod_Id") %>' CommandName="cmd_edt"
                CssClass="btn-grid-edit">Edit</asp:LinkButton>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Delete">
            <ItemTemplate>
              <asp:LinkButton ID="LinkButton2" runat="server" CommandArgument='<%# Eval("Prod_Id") %>' CommandName="cmd_dlt"
                CssClass="btn-grid-delete" OnClientClick="return confirm('Delete this product?');">Delete</asp:LinkButton>
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

