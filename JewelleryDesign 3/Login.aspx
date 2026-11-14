<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="JewelleryDesign.Login" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login — Jewellery Design</title>
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
    <p class="eyebrow">Welcome Back</p>
    <h1>Login to Your Account</h1>
    <p>Login to shop our jewellery collection.</p>
  </div>
</div>

<form id="form1" runat="server">
  <div class="reg-layout" style="justify-content:center;">
    <div class="reg-section" style="max-width:520px;">
      <div class="reg-card">
        <div class="reg-card-header">
          <i class="fa-solid fa-gem reg-gem-icon"></i>
          <h2>Login</h2>
        </div>

        <asp:Label ID="lblMsg" runat="server" CssClass="success-msg" Visible="false"></asp:Label>

        <table class="form-table">
          <tr>
            <td>Email</td>
            <td class="auto-style1">
              <asp:TextBox ID="txtemail" runat="server" CssClass="textbox" TextMode="Email" placeholder="Enter your registered email"></asp:TextBox>
            </td>
          </tr>
          <tr>
            <td>Password</td>
            <td class="auto-style1">
              <asp:TextBox ID="txtpassword" runat="server" CssClass="textbox" TextMode="Password" placeholder="Enter your password"></asp:TextBox>
            </td>
          </tr>
          <tr>
            <td></td>
            <td class="auto-style1">
              <asp:Button ID="login_btn" runat="server" Text="Login Here" CssClass="btn-save" OnClick="login_btn_Click" />
            </td>
          </tr>
        </table>
        <p class="login-hint">New here? <a href="Registration.aspx">Create an account</a></p>
      </div>
    </div>
  </div>
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="Scripts/script.js"></script>
</body>
</html>

