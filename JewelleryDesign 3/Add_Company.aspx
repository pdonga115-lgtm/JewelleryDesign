<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Add_Company.aspx.cs" Inherits="JewelleryDesign.Add_Company" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Add Company — Jewellery Design</title>
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
    <h1>Add Company</h1>
    <p>Add a jewellery brand / company. Products are added under a company.</p>
  </div>
</div>

<form id="form1" runat="server" enctype="multipart/form-data">
  <div class="reg-layout" style="justify-content:center;">
    <div class="reg-section" style="max-width:720px;">
      <div class="reg-card">
        <div class="reg-card-header">
          <i class="fa-solid fa-building reg-gem-icon"></i>
          <h2>Add Company</h2>
        </div>

        <p><asp:Label ID="lblresult" runat="server"></asp:Label></p>
        <asp:Label ID="lblMsg" runat="server" CssClass="success-msg" Visible="false"></asp:Label>
        <p><asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click1" CssClass="btn-grid-edit">Add Products &rarr;</asp:LinkButton></p>

        <table class="form-table">
          <tr><td>Company Name</td><td class="auto-style1"><asp:TextBox ID="txtnm" runat="server" CssClass="textbox"></asp:TextBox></td></tr>
          <tr><td>Company Owner Name</td><td class="auto-style1"><asp:TextBox ID="txtonm" runat="server" CssClass="textbox"></asp:TextBox></td></tr>
          <tr><td>Company Email</td><td class="auto-style1"><asp:TextBox ID="txteml" runat="server" CssClass="textbox"></asp:TextBox></td></tr>
          <tr><td>Company Address</td><td class="auto-style1"><asp:TextBox ID="txtadd" runat="server" CssClass="textbox"></asp:TextBox></td></tr>
          <tr><td>Company Cover Image</td><td class="auto-style1"><asp:FileUpload ID="imgUpload" runat="server" CssClass="file-upload" /></td></tr>
          <tr>
            <td></td>
            <td class="auto-style1">
              <asp:Button ID="add_comp_btn" runat="server" Text="Add Company" CssClass="btn-save" OnClick="add_comp_btn_Click" />
              <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn-cancel ms-2" OnClick="btnCancel_Click" Visible="false" />
            </td>
          </tr>
        </table>
      </div>
    </div>
  </div>

  <div class="gridview-section">
    <h3><i class="fa-solid fa-building" style="color:var(--gold);"></i> Companies</h3>
    <div style="overflow-x:auto;">
      <asp:GridView ID="gvCompany" runat="server" CssClass="gridview-table" AutoGenerateColumns="False"
        EmptyDataText="No company added yet." OnRowCommand="gvCompany_RowCommand">
        <Columns>
          <asp:BoundField DataField="Comp_id" HeaderText="ID" />
          <asp:BoundField DataField="Comp_Name" HeaderText="Company" />
          <asp:BoundField DataField="Comp_Owner_Name" HeaderText="Owner" />
          <asp:BoundField DataField="Comp_Email" HeaderText="Email" />
          <asp:BoundField DataField="Comp_Address" HeaderText="Address" />
          <asp:ImageField DataImageUrlField="Comp_Cover_Img" HeaderText="Cover" ControlStyle-Width="55px" ControlStyle-Height="55px" />
          <asp:TemplateField HeaderText="Edit">
            <ItemTemplate>
              <asp:LinkButton ID="lnkEdit" runat="server" CommandName="cmd_edt" CommandArgument='<%# Eval("Comp_id") %>' CssClass="btn-grid-edit">Edit</asp:LinkButton>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Delete">
            <ItemTemplate>
              <asp:LinkButton ID="lnkDel" runat="server" CommandName="cmd_dlt" CommandArgument='<%# Eval("Comp_id") %>' CssClass="btn-grid-delete" OnClientClick="return confirm('Delete this company?');">Delete</asp:LinkButton>
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

