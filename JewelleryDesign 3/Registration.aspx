<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="JewelleryDesign.Registration" EnableEventValidation="false" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Register — Jewellery Design</title>
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
      <span class="brand-mark">J</span>
      <span class="brand-word">Jewellery<em>Design</em></span>
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMain" aria-label="Toggle navigation">
      <i class="fa-solid fa-bars"></i>
    </button>
    <div class="collapse navbar-collapse" id="navMain">
      <ul class="navbar-nav mx-auto main-links">
        <li class="nav-item"><a class="nav-link" href="Default.aspx#home">Home</a></li>
        <li class="nav-item"><a class="nav-link" href="Products.aspx">Shop</a></li>
        <li class="nav-item"><a class="nav-link" href="Default.aspx#collections">Collections</a></li>
        <li class="nav-item"><a class="nav-link" href="Default.aspx#categories">Categories</a></li>
        <li class="nav-item"><a class="nav-link" href="Default.aspx#about">About</a></li>
        <li class="nav-item"><a class="nav-link" href="Default.aspx#contact">Contact</a></li>
      </ul>
      <div class="d-flex align-items-center nav-icons">
        <button class="icon-btn" id="themeToggle" aria-label="Toggle dark mode"><i class="fa-regular fa-moon"></i></button>
        <a href="Default.aspx" class="btn btn-login ms-2">
          <i class="fa-solid fa-house me-1"></i> Home
        </a>
        <%= Helper.NavRight() %>
      </div>
    </div>
  </div>
</nav>


<div class="reg-hero">
  <img class="reg-hero-img"
       src="https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?q=80&w=1400&auto=format&fit=crop"
       alt="Jewellery Registration Banner" />
  <div class="reg-hero-content">
    <p class="eyebrow">Join the Family</p>
    <h1>Create Your Account</h1>
    <p>Register with your email and password to shop our jewellery collection.</p>
  </div>
</div>

<form id="form1" runat="server" enctype="multipart/form-data">

  <div class="reg-layout">


    <div class="reg-section">
      <div class="reg-card">
        <div class="reg-card-header">
          <i class="fa-solid fa-gem reg-gem-icon"></i>
          <h2>Registration Form</h2>
        </div>

       
        <asp:Label ID="lblMsg" runat="server" CssClass="success-msg" Visible="false"></asp:Label>

        <table class="form-table">

         
          <tr>
            <td><asp:Label ID="lblName" runat="server" Text="Full Name"></asp:Label></td>
            <td class="auto-style1">
              <asp:TextBox ID="txtName" runat="server" CssClass="textbox"
                placeholder="Enter your full name"></asp:TextBox>
            </td>
          </tr>

         
          <tr>
            <td><asp:Label ID="lblGender" runat="server" Text="Gender"></asp:Label></td>
            <td class="auto-style1">
              <asp:RadioButtonList ID="rabgen" runat="server"
                RepeatDirection="Horizontal" CssClass="radiobtn-list">
                <asp:ListItem Value="Male">Male</asp:ListItem>
                <asp:ListItem Value="Female">Female</asp:ListItem>
              </asp:RadioButtonList>
            </td>
          </tr>

          
          <tr>
            <td><asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label></td>
            <td class="auto-style1">
              <asp:TextBox ID="txtEmail" runat="server" CssClass="textbox"
                TextMode="Email" placeholder="Enter your email address"></asp:TextBox>
            </td>
          </tr>

         
          <tr>
            <td><asp:Label ID="lblPass" runat="server" Text="Password"></asp:Label></td>
            <td class="auto-style1">
              <asp:TextBox ID="txtPass" runat="server" CssClass="textbox"
                TextMode="Password" placeholder="Create a password (min 4 characters)"></asp:TextBox>
            </td>
          </tr>

          <tr>
            <td><asp:Label ID="lblConfirm" runat="server" Text="Confirm Password"></asp:Label></td>
            <td class="auto-style1">
              <asp:TextBox ID="txtConfirm" runat="server" CssClass="textbox"
                TextMode="Password" placeholder="Re-enter your password"></asp:TextBox>
            </td>
          </tr>

          <tr>
            <td><asp:Label ID="lblCity" runat="server" Text="City"></asp:Label></td>
            <td class="auto-style1">
              <asp:DropDownList ID="ddlCity" runat="server" CssClass="textbox">
                <asp:ListItem Text="-- Select Your City --" Value=""></asp:ListItem>
                <asp:ListItem>Ahmedabad</asp:ListItem>
                <asp:ListItem>Rajkot</asp:ListItem>
                <asp:ListItem>Surat</asp:ListItem>
                <asp:ListItem>Vadodara</asp:ListItem>
                <asp:ListItem>Bhavnagar</asp:ListItem>
                <asp:ListItem>Mumbai</asp:ListItem>
                <asp:ListItem>Delhi</asp:ListItem>
                <asp:ListItem>Pune</asp:ListItem>
                <asp:ListItem>Bengaluru</asp:ListItem>
                <asp:ListItem>Hyderabad</asp:ListItem>
              </asp:DropDownList>
            </td>
          </tr>

          
          <tr>
            <td><asp:Label ID="lblAddress" runat="server" Text="Address"></asp:Label></td>
            <td class="auto-style1">
              <asp:TextBox ID="txtAddress" runat="server" CssClass="textbox"
                TextMode="MultiLine" Rows="3"
                placeholder="Enter your full address"></asp:TextBox>
            </td>
          </tr>

         
          <tr>
            <td><asp:Label ID="lblMobile" runat="server" Text="Mobile No."></asp:Label></td>
            <td class="auto-style1">
              <asp:TextBox ID="txtMobile" runat="server" CssClass="textbox"
                placeholder="Enter your 10-digit mobile number"
                MaxLength="10"></asp:TextBox>
            </td>
          </tr>

          
          <tr>
            <td><asp:Label ID="lblImage" runat="server" Text="Profile Photo"></asp:Label></td>
            <td class="auto-style1">
              <asp:FileUpload ID="flpimg" runat="server" CssClass="file-upload" />
            </td>
          </tr>

          
          <tr>
            <td></td>
            <td class="auto-style1">
              <asp:Button ID="Save" runat="server" Text="Register Now"
                CssClass="btn-save" OnClick="btnSubmit_Click" />
              &nbsp;
              <asp:Button ID="btnCancel" runat="server" Text="Cancel"
                CssClass="btn-cancel" OnClick="btnCancel_Click" Visible="false" />
            </td>
          </tr>

        </table>
        <p class="login-hint">Already have an account? <a href="Login.aspx">Login here</a></p>
      </div>
    </div>

    <div class="reg-side">
      <div class="reg-side-card">
        <img src="https://images.unsplash.com/photo-1617038260897-41a1f14a8ca0?q=80&w=600&auto=format&fit=crop"
             alt="Jewellery Benefits" />
        <h3><i class="fa-solid fa-crown me-2"></i>Member Benefits</h3>
        <ul class="benefit-list">
          <li>
            <i class="fa-solid fa-circle-check" style="color:var(--gold);"></i>
            Exclusive member-only collections
          </li>
          <li>
            <i class="fa-solid fa-circle-check" style="color:var(--gold);"></i>
            Early access to new arrivals
          </li>
          <li>
            <i class="fa-solid fa-circle-check" style="color:var(--gold);"></i>
            Lifetime exchange on all purchases
          </li>
          <li>
            <i class="fa-solid fa-circle-check" style="color:var(--gold);"></i>
            Track your orders in real time
          </li>
          <li>
            <i class="fa-solid fa-circle-check" style="color:var(--gold);"></i>
            Priority customer support
          </li>
          <li>
            <i class="fa-solid fa-circle-check" style="color:var(--gold);"></i>
            Earn loyalty reward points
          </li>
        </ul>

        <div style="padding:16px 24px 24px; border-top:1px solid var(--border); margin-top:4px;">
          <p style="font-size:.75rem;color:var(--text-muted);letter-spacing:.1em;text-transform:uppercase;margin-bottom:12px;">Trusted &amp; Certified</p>
          <div style="display:flex;gap:16px;align-items:center;flex-wrap:wrap;">
            <div style="text-align:center;">
              <i class="fa-solid fa-certificate" style="font-size:1.6rem;color:var(--gold);display:block;"></i>
              <span style="font-size:.7rem;color:var(--text-muted);">Hallmark</span>
            </div>
            <div style="text-align:center;">
              <i class="fa-solid fa-lock" style="font-size:1.6rem;color:var(--gold);display:block;"></i>
              <span style="font-size:.7rem;color:var(--text-muted);">Secure</span>
            </div>
            <div style="text-align:center;">
              <i class="fa-solid fa-arrows-rotate" style="font-size:1.6rem;color:var(--gold);display:block;"></i>
              <span style="font-size:.7rem;color:var(--text-muted);">Exchange</span>
            </div>
            <div style="text-align:center;">
              <i class="fa-solid fa-truck-fast" style="font-size:1.6rem;color:var(--gold);display:block;"></i>
              <span style="font-size:.7rem;color:var(--text-muted);">Fast Ship</span>
            </div>
          </div>
        </div>
      </div>
    </div>

  </div>

  <div class="gridview-section" id="divMembers" runat="server">
    <h3>
      <i class="fa-solid fa-users" style="color:var(--gold);"></i>
      Registered Members
    </h3>
    <div style="overflow-x:auto;">
      <asp:GridView ID="gvUsers" runat="server"
        CssClass="gridview-table"
        AutoGenerateColumns="False"
        EmptyDataText="No members registered yet. Be the first to join!"
        OnRowCommand="gvUsers_RowCommand">
        <Columns>
          <asp:BoundField DataField="Id"      HeaderText="ID" />
          <asp:BoundField DataField="Name"    HeaderText="Full Name" />
          <asp:BoundField DataField="Gender"  HeaderText="Gender" />
          <asp:BoundField DataField="Email"   HeaderText="Email" />
          <asp:BoundField DataField="City"    HeaderText="City" />
          <asp:BoundField DataField="Address" HeaderText="Address" />
          <asp:BoundField DataField="Mobile"  HeaderText="Mobile" />
          <asp:ImageField DataImageUrlField="Image"
            HeaderText="Photo"
            ControlStyle-Width="55px"
            ControlStyle-Height="55px"
            NullImageUrl="https://cdn-icons-png.flaticon.com/512/1077/1077063.png"
            AlternateText="Photo" />
          <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
              <asp:LinkButton ID="btnEdit" runat="server"
                Text="Edit"
                CommandName="cmd_edt"
                CommandArgument='<%# Eval("Id") %>'
                CssClass="btn-grid-edit" />
              &nbsp;
              <asp:LinkButton ID="btnDelete" runat="server"
                Text="Delete"
                CommandName="cmd_del"
                CommandArgument='<%# Eval("Id") %>'
                CssClass="btn-grid-delete"
                OnClientClick="return confirm('Are you sure you want to delete this member?');" />
            </ItemTemplate>
          </asp:TemplateField>
        </Columns>
      </asp:GridView>
    </div>
  </div>

</form>

<footer class="footer">
  <div class="container">
    <div class="row g-4">
      <div class="col-lg-4">
        <a class="navbar-brand" href="Default.aspx">
          <span class="brand-mark">J</span>
          <span class="brand-word">Jewellery<em>Design</em></span>
        </a>
        <p class="footer-about">Fine jewellery crafted with certified gold, diamonds and silver. Hallmark certified, made to be worn for generations.</p>
        <div class="social-icons">
          <a href="#" aria-label="Facebook"><i class="fa-brands fa-facebook-f"></i></a>
          <a href="#" aria-label="Instagram"><i class="fa-brands fa-instagram"></i></a>
          <a href="#" aria-label="Pinterest"><i class="fa-brands fa-pinterest-p"></i></a>
          <a href="#" aria-label="X"><i class="fa-brands fa-x-twitter"></i></a>
          <a href="#" aria-label="YouTube"><i class="fa-brands fa-youtube"></i></a>
        </div>
      </div>
      <div class="col-6 col-lg-2">
        <h6 class="footer-title">Quick Links</h6>
        <ul>
          <li><a href="Default.aspx#home">Home</a></li>
          <li><a href="Default.aspx#trending">Shop</a></li>
          <li><a href="Default.aspx#collections">Collections</a></li>
          <li><a href="Default.aspx#about">About</a></li>
          <li><a href="Default.aspx#contact">Contact</a></li>
        </ul>
      </div>
      <div class="col-6 col-lg-3">
        <h6 class="footer-title">Customer Support</h6>
        <ul>
          <li><a href="#">Track Your Order</a></li>
          <li><a href="#">Returns &amp; Exchange</a></li>
          <li><a href="#">Shipping Policy</a></li>
          <li><a href="#">FAQs</a></li>
          <li><a href="#">Privacy Policy</a></li>
        </ul>
      </div>
      <div class="col-lg-3">
        <h6 class="footer-title">Newsletter</h6>
        <p class="footer-about">Get updates on new arrivals and exclusive offers.</p>
        <form class="footer-newsletter">
          <input type="email" placeholder="Email address">
          <button type="submit" aria-label="Subscribe"><i class="fa-solid fa-paper-plane"></i></button>
        </form>
      </div>
    </div>
    <hr>
    <div class="footer-bottom">
      <p>&copy; <span id="year"></span> Jewellery Design. All rights reserved.</p>
      <p>Designed with <i class="fa-solid fa-heart"></i> for timeless craftsmanship.</p>
    </div>
  </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="Scripts/script.js"></script>
</body>
</html>

