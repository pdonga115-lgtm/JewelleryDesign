<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="JewelleryDesign.Default" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Jewellery Design | Fine Jewellery, Crafted to Last</title>
  <meta name="description" content="Jewellery Design — certified gold, diamond, silver and bridal jewellery. Hallmark certified, lifetime exchange, secure payments and fast delivery across India.">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,500;0,600;0,700;1,500&family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
  <link rel="stylesheet" href="Styles/style.css">
</head>
<body>
<form id="form1" runat="server">

<!-- Loader -->
<div id="loader" class="loader-screen" aria-hidden="true">
  <div class="loader-gem">
    <svg viewBox="0 0 100 100" width="70" height="70">
      <polygon points="50,5 90,35 74,95 26,95 10,35" fill="none" stroke="url(#gemGrad)" stroke-width="2"/>
      <polygon points="50,5 90,35 50,50" fill="url(#gemGrad)" opacity="0.35"/>
      <polygon points="10,35 50,50 26,95" fill="url(#gemGrad)" opacity="0.2"/>
      <polygon points="90,35 74,95 50,50" fill="url(#gemGrad)" opacity="0.5"/>
      <defs>
        <linearGradient id="gemGrad" x1="0%" y1="0%" x2="100%" y2="100%">
          <stop offset="0%" stop-color="#F6E7A8"/>
          <stop offset="50%" stop-color="#D4AF37"/>
          <stop offset="100%" stop-color="#946B2D"/>
        </linearGradient>
      </defs>
    </svg>
  </div>
  <p class="loader-text">JEWELLERY DESIGN</p>
</div>

<button id="scrollTopBtn" aria-label="Scroll to top"><i class="fa-solid fa-angle-up"></i></button>
<div class="cursor-glow" id="cursorGlow"></div>

<!-- Navbar -->
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
        <li class="nav-item"><a class="nav-link active" href="#home">Home</a></li>
        <li class="nav-item"><a class="nav-link" href="Products.aspx">Shop</a></li>
        <li class="nav-item"><a class="nav-link" href="#collections">Collections</a></li>
        <li class="nav-item"><a class="nav-link" href="#categories">Categories</a></li>
        <li class="nav-item"><a class="nav-link" href="#about">About</a></li>
        <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
      </ul>
      <div class="d-flex align-items-center nav-icons">
        <div class="search-wrap">
          <button class="icon-btn" id="searchToggle" aria-label="Search"><i class="fa-solid fa-magnifying-glass"></i></button>
          <input type="search" class="search-input" id="searchInput" placeholder="Search fine jewellery...">
        </div>
        <button class="icon-btn" id="themeToggle" aria-label="Toggle dark mode"><i class="fa-regular fa-moon"></i></button>
        <a href="#" class="icon-btn position-relative" aria-label="Wishlist"><i class="fa-regular fa-heart"></i><span class="badge-count">3</span></a>
        <%= Helper.NavRight() %>
      </div>
    </div>
  </div>
</nav>

<!-- Hero Section -->
<header id="home" class="hero">
  <div class="hero-media">
    <img src="https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?q=80&w=1740&auto=format&fit=crop" alt="Model wearing a statement gold and diamond necklace" loading="eager">
    <div class="hero-overlay"></div>
  </div>
  <div class="container hero-content">
    <div class="row align-items-center">
      <div class="col-lg-7">
        <p class="eyebrow reveal">Est. Heritage &mdash; Hallmark Certified</p>
        <h1 class="hero-title reveal">Jewellery, <span class="gold-shimmer">Woven in Gold</span></h1>
        <p class="hero-sub reveal">Where every facet is cut to catch the light and every setting is made to be worn for a lifetime. Discover the new Aurelia collection.</p>
        <div class="hero-cta reveal">
          <a href="Products.aspx" class="btn btn-gold-grad">Shop Now <i class="fa-solid fa-arrow-right ms-2"></i></a>
          <a href="#collections" class="btn btn-outline-gold">View Collections</a>
        </div>
      </div>
    </div>
  </div>
  <div class="scroll-hint"><span></span>Scroll</div>
</header>

<!-- Collections Section -->
<section class="section collections-section" id="collections">
  <div class="container">
    <div class="section-head text-center">
      <p class="eyebrow">Curated For You</p>
      <h2>Featured Collections</h2>
    </div>
    <div class="row g-4">
      <div class="col-6 col-md-4 col-lg-2">
        <a href="Products.aspx?col=Gold" class="collection-card" style="display:block" data-tilt>
          <img src="https://images.unsplash.com/photo-1611591437281-460bfbe1220a?q=80&w=800&auto=format&fit=crop" alt="Gold Jewellery Collection">
          <div class="collection-info"><h3>Gold</h3><span>Shop Collection</span></div>
        </a>
      </div>
      <div class="col-6 col-md-4 col-lg-2">
        <a href="Products.aspx?col=Diamond" class="collection-card" style="display:block" data-tilt>
          <img src="https://images.unsplash.com/photo-1605100804763-247f67b3557e?q=80&w=800&auto=format&fit=crop" alt="Diamond Jewellery Collection">
          <div class="collection-info"><h3>Diamond</h3><span>Shop Collection</span></div>
        </a>
      </div>
      <div class="col-6 col-md-4 col-lg-2">
        <a href="Products.aspx?col=Silver" class="collection-card" style="display:block" data-tilt>
          <img src="https://images.unsplash.com/photo-1620656798579-1984d9e87df7?q=80&w=800&auto=format&fit=crop" alt="Silver Jewellery Collection">
          <div class="collection-info"><h3>Silver</h3><span>Shop Collection</span></div>
        </a>
      </div>
      <div class="col-6 col-md-4 col-lg-2">
        <a href="Products.aspx?col=Bridal" class="collection-card" style="display:block" data-tilt>
          <img src="https://i.pinimg.com/736x/59/a6/0d/59a60dc249619f48ee06100fe853bb68.jpg" alt="Bridal Jewellery Collection">
          <div class="collection-info"><h3>Bridal</h3><span>Shop Collection</span></div>
        </a>
      </div>
      <div class="col-6 col-md-4 col-lg-2">
        <a href="Products.aspx?col=Mens" class="collection-card" style="display:block" data-tilt>
          <img src="https://i.pinimg.com/736x/d9/dc/ab/d9dcabf6aa8ab5e163e20294a684ffc6.jpg" alt="Men's Jewellery Collection">
          <div class="collection-info"><h3>Men's</h3><span>Shop Collection</span></div>
        </a>
      </div>
      <div class="col-6 col-md-4 col-lg-2">
        <a href="Products.aspx?col=Kids" class="collection-card" style="display:block" data-tilt>
          <img src="https://i.pinimg.com/1200x/54/1d/1a/541d1a6e578a3671694fe3bfaff486d2.jpg" alt="Kids Jewellery Collection">
          <div class="collection-info"><h3>Kids</h3><span>Shop Collection</span></div>
        </a>
      </div>
    </div>
  </div>
</section>

<!-- Trending Products Section -->
<section class="section trending-section" id="trending">
  <div class="container">
    <div class="section-head text-center">
      <p class="eyebrow">Handpicked</p>
      <h2>Trending Products</h2>
    </div>
    <div class="row g-4" id="productGrid">
      <asp:Repeater ID="rptProducts" runat="server">
        <ItemTemplate>
          <div class="col-md-6 col-lg-3">
            <div class="product-card">
              <div class="product-media">
                <button class="wish-btn" aria-label="Add to wishlist"><i class="fa-regular fa-heart"></i></button>
                <a href='ProductDetails.aspx?pid=<%# Eval("Prod_Id") %>'><img src='<%# ResolveUrl("~/" + Convert.ToString(Eval("Prod_Img"))) %>' alt='<%# Server.HtmlEncode(Convert.ToString(Eval("Prod_Name"))) %>'></a>
              </div>
              <div class="product-body">
                <h4><a href='ProductDetails.aspx?pid=<%# Eval("Prod_Id") %>'><%# Server.HtmlEncode(Convert.ToString(Eval("Prod_Name"))) %></a></h4>
                <p class="prod-meta"><%# Server.HtmlEncode(Convert.ToString(Eval("Comp_Name"))) %> &middot; <%# Server.HtmlEncode(Convert.ToString(Eval("Prod_Weight"))) %> &middot; <%# Server.HtmlEncode(Convert.ToString(Eval("Prod_Config"))) %></p>
                <div class="price-row"><span class="price">&#8377;<%# string.Format("{0:N0}", Eval("Prod_Price")) %></span></div>
                <a href='AddToCart.aspx?pid=<%# Eval("Prod_Id") %>&ret=Default.aspx%23trending' class="btn btn-add-cart w-100"><i class="fa-solid fa-bag-shopping me-2"></i>Add to Cart</a>
              </div>
            </div>
          </div>
        </ItemTemplate>
      </asp:Repeater>
      <asp:Literal ID="litEmpty" runat="server" Mode="PassThrough"></asp:Literal>
    </div>
    <div class="text-center mt-5"><a href="Products.aspx" class="btn btn-gold-grad">View All Products <i class="fa-solid fa-arrow-right ms-2"></i></a></div>
  </div>
</section>

<!-- Categories Section -->
<section class="section categories-section" id="categories">
  <div class="container">
    <div class="section-head text-center">
      <p class="eyebrow">Browse</p>
      <h2>Shop by Category</h2>
    </div>
    <div class="row g-3 g-lg-4">
      <div class="col-6 col-md-3"><a href="Products.aspx?cat=Rings" class="category-pill"><div class="cat-icon"><i class="fa-solid fa-ring"></i></div><span>Rings</span></a></div>
      <div class="col-6 col-md-3"><a href="Products.aspx?cat=Necklaces" class="category-pill"><div class="cat-icon"><i class="fa-solid fa-gem"></i></div><span>Necklaces</span></a></div>
      <div class="col-6 col-md-3"><a href="Products.aspx?cat=Earrings" class="category-pill"><div class="cat-icon"><i class="fa-brands fa-connectdevelop"></i></div><span>Earrings</span></a></div>
      <div class="col-6 col-md-3"><a href="Products.aspx?cat=Bangles" class="category-pill"><div class="cat-icon"><i class="fa-solid fa-circle-notch"></i></div><span>Bangles</span></a></div>
      <div class="col-6 col-md-3"><a href="Products.aspx?cat=Bracelets" class="category-pill"><div class="cat-icon"><i class="fa-solid fa-link"></i></div><span>Bracelets</span></a></div>
      <div class="col-6 col-md-3"><a href="Products.aspx?cat=Pendants" class="category-pill"><div class="cat-icon"><i class="fa-solid fa-droplet"></i></div><span>Pendants</span></a></div>
      <div class="col-6 col-md-3"><a href="Products.aspx?cat=Chains" class="category-pill"><div class="cat-icon"><i class="fa-solid fa-infinity"></i></div><span>Chains</span></a></div>
      <div class="col-6 col-md-3"><a href="Products.aspx?cat=Nose%20Pins" class="category-pill"><div class="cat-icon"><i class="fa-solid fa-star-of-life"></i></div><span>Nose Pins</span></a></div>
    </div>
  </div>
</section>

<!-- Why Choose Us Section -->
<section class="section why-section">
  <div class="container">
    <div class="section-head text-center">
      <p class="eyebrow">Our Promise</p>
      <h2>Why Choose Jewellery</h2>
    </div>
    <div class="row g-4">
      <div class="col-6 col-lg-2"><div class="why-card"><i class="fa-solid fa-certificate"></i><h5>Certified Jewellery</h5></div></div>
      <div class="col-6 col-lg-2"><div class="why-card"><i class="fa-solid fa-arrows-rotate"></i><h5>Lifetime Exchange</h5></div></div>
      <div class="col-6 col-lg-2"><div class="why-card"><i class="fa-solid fa-lock"></i><h5>Secure Payment</h5></div></div>
      <div class="col-6 col-lg-2"><div class="why-card"><i class="fa-solid fa-truck-fast"></i><h5>Fast Delivery</h5></div></div>
      <div class="col-6 col-lg-2"><div class="why-card"><i class="fa-solid fa-stamp"></i><h5>Hallmark Certified</h5></div></div>
      <div class="col-6 col-lg-2"><div class="why-card"><i class="fa-solid fa-crown"></i><h5>Premium Quality</h5></div></div>
    </div>
  </div>
</section>

<!-- About Section -->
<section class="section about-section" id="about">
  <div class="container">
    <div class="row align-items-center g-5">
      <div class="col-lg-6">
        <div class="about-media">
          <img src="https://images.unsplash.com/photo-1617038260897-41a1f14a8ca0?q=80&w=1000&auto=format&fit=crop" alt="Jewellery Design master craftsman at work">
          <div class="about-badge">
            <i class="fa-solid fa-award"></i>
            <div><strong>25+</strong><span>Years Legacy</span></div>
          </div>
        </div>
      </div>
      <div class="col-lg-6">
        <p class="eyebrow">Our Story</p>
        <h2>Crafted by Hand, <span class="gold-text">Trusted by Generations</span></h2>
        <p class="about-text">Jewellery Design began as a single family workshop and has grown into a house known for uncompromising craftsmanship. Every piece passes through the hands of master artisans before it reaches yours, hallmark certified and backed by a lifetime exchange promise.</p>
        <div class="row g-4 about-stats">
          <div class="col-4"><h3><span class="counter" data-target="25">0</span>+</h3><p>Years of Trust</p></div>
          <div class="col-4"><h3><span class="counter" data-target="500">0</span>K+</h3><p>Happy Customers</p></div>
          <div class="col-4"><h3><span class="counter" data-target="120">0</span>+</h3><p>Store Locations</p></div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Testimonials Section -->
<section class="section testimonial-section">
  <div class="container">
    <div class="section-head text-center">
      <p class="eyebrow">Reviews</p>
      <h2>What Our Customers Say</h2>
    </div>
    <div id="testimonialCarousel" class="carousel slide" data-bs-ride="carousel">
      <div class="carousel-inner">
        <div class="carousel-item active">
          <div class="testimonial-card mx-auto">
            <div class="stars mb-3"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i></div>
            <p>"The craftsmanship on my bridal set exceeded every expectation. It felt like a piece made only for me."</p>
            <h6>Ananya Sharma</h6><span>Mumbai</span>
          </div>
        </div>
        <div class="carousel-item">
          <div class="testimonial-card mx-auto">
            <div class="stars mb-3"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i></div>
            <p>"Certified quality, transparent pricing, and a delivery experience that felt genuinely premium."</p>
            <h6>Rohan Mehta</h6><span>Delhi</span>
          </div>
        </div>
        <div class="carousel-item">
          <div class="testimonial-card mx-auto">
            <div class="stars mb-3"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-regular fa-star-half-stroke"></i></div>
            <p>"The lifetime exchange policy gave me total confidence. Jewellery has earned a customer for life."</p>
            <h6>Priya Nair</h6><span>Bengaluru</span>
          </div>
        </div>
      </div>
      <button class="carousel-control-prev" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="prev">
        <span class="carousel-arrow"><i class="fa-solid fa-chevron-left"></i></span>
      </button>
      <button class="carousel-control-next" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="next">
        <span class="carousel-arrow"><i class="fa-solid fa-chevron-right"></i></span>
      </button>
    </div>
  </div>
</section>

<!-- Gallery Section -->
<section class="section gallery-section">
  <div class="container-fluid px-0">
    <div class="section-head text-center">
      <p class="eyebrow">Lookbook</p>
      <h2>Gallery</h2>
    </div>
    <div class="gallery-grid">
      <div class="gallery-item"><img src="https://images.unsplash.com/photo-1608042314453-ae338d80c427?q=80&w=800&auto=format&fit=crop" alt="Gold earrings closeup"><div class="gallery-overlay"><i class="fa-solid fa-expand"></i></div></div>
      <div class="gallery-item"><img src="https://i.pinimg.com/736x/1e/47/90/1e47900aed86e0b848af0c65fbc9481b.jpg" alt="Diamond ring closeup"><div class="gallery-overlay"><i class="fa-solid fa-expand"></i></div></div>
      <div class="gallery-item"><img src="https://i.pinimg.com/736x/aa/ec/c5/aaecc55222f8c449fdd1598eabd98b1f.jpg" alt="Pearl and gold set"><div class="gallery-overlay"><i class="fa-solid fa-expand"></i></div></div>
      <div class="gallery-item"><img src="https://i.pinimg.com/1200x/b7/9f/82/b79f82c51ca4f7c27b55eee8b6099036.jpg" alt="Bridal necklace"><div class="gallery-overlay"><i class="fa-solid fa-expand"></i></div></div>
      <div class="gallery-item"><img src="https://images.unsplash.com/photo-1599643477877-530eb83abc8e?q=80&w=800&auto=format&fit=crop" alt="Necklace on display"><div class="gallery-overlay"><i class="fa-solid fa-expand"></i></div></div>
      <div class="gallery-item"><img src="https://i.pinimg.com/736x/df/fd/f8/dffdf82e5cc2abcac475144341b86f07.jpg" alt="Gold bangles stacked"><div class="gallery-overlay"><i class="fa-solid fa-expand"></i></div></div>
    </div>
  </div>
</section>

<!-- Newsletter Section -->
<section class="section newsletter-section">
  <div class="container">
    <div class="newsletter-box text-center">
      <i class="fa-solid fa-envelope-open-text"></i>
      <h2>Join the Jewellery Circle</h2>
      <p>Subscribe for early access to new collections, private previews and member-only offers.</p>
      <form class="newsletter-form" id="newsletterForm">
        <input type="email" placeholder="Enter your email address" required>
        <button type="submit" class="btn btn-gold-grad">Subscribe</button>
      </form>
    </div>
  </div>
</section>

<!-- Contact Section -->
<section class="section contact-section" id="contact">
  <div class="container">
    <div class="section-head text-center">
      <p class="eyebrow">Get in Touch</p>
      <h2>Contact Us</h2>
    </div>
    <div class="row g-5">
      <div class="col-lg-5">
        <div class="contact-info-card">
          <div class="contact-info-item">
            <i class="fa-solid fa-phone"></i>
            <div><h6>Call Us</h6><p>+91 98765 43210</p></div>
          </div>
          <div class="contact-info-item">
            <i class="fa-solid fa-envelope"></i>
            <div><h6>Email Us</h6><p>hello@jewellerydesign.com</p></div>
          </div>
          <div class="contact-info-item">
            <i class="fa-solid fa-location-dot"></i>
            <div><h6>Visit Our Store</h6><p>14 Zaveri Bazaar, Mumbai, Maharashtra 400002</p></div>
          </div>
          <div class="map-placeholder">
            <i class="fa-solid fa-map-location-dot"></i>
            <span>Google Map Placeholder</span>
          </div>
        </div>
      </div>
      <div class="col-lg-7">
        <form class="contact-form">
          <div class="row g-3">
            <div class="col-md-6"><input type="text" class="form-control" placeholder="Your Name" required></div>
            <div class="col-md-6"><input type="email" class="form-control" placeholder="Your Email" required></div>
            <div class="col-12"><input type="text" class="form-control" placeholder="Subject"></div>
            <div class="col-12"><textarea class="form-control" rows="5" placeholder="Your Message" required></textarea></div>
            <div class="col-12">
              <button type="submit" class="btn btn-gold-grad w-100 w-md-auto">Send Message <i class="fa-solid fa-paper-plane ms-2"></i></button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</section>

<!-- Footer -->
<footer class="footer">
  <div class="container">
    <div class="row g-4">
      <div class="col-lg-4">
        <a class="navbar-brand" href="Default.aspx">
          <span class="brand-mark">J</span><span class="brand-word">Jewellery<em>Design</em></span>
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
          <li><a href="#home">Home</a></li>
          <li><a href="#trending">Shop</a></li>
          <li><a href="#collections">Collections</a></li>
          <li><a href="#about">About</a></li>
          <li><a href="#contact">Contact</a></li>
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

<!-- Quick View Modal -->
<div class="modal fade" id="quickViewModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content quick-view-modal">
      <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      <div class="row g-0">
        <div class="col-md-6">
          <img src="https://images.unsplash.com/photo-1599643477877-530eb83abc8e?q=80&w=900&auto=format&fit=crop" alt="Aurelia Gold Necklace" class="quick-view-img">
        </div>
        <div class="col-md-6 p-4 p-lg-5">
          <h3>Aurelia Gold Necklace</h3>
          <div class="stars mb-2"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-regular fa-star-half-stroke"></i><span>(128 reviews)</span></div>
          <div class="price-row mb-3">
            <span class="price">&#8377;84,999</span>
            <span class="price-old">&#8377;1,06,000</span>
          </div>
          <p class="quick-view-desc">22K hallmark certified gold necklace featuring hand-finished filigree work, finished with a secure box clasp. Comes with a lifetime exchange guarantee and authenticity certificate.</p>
          <button class="btn btn-gold-grad w-100 mt-2">Add to Cart</button>
        </div>
      </div>
    </div>
  </div>
</div>

</form>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="Scripts/script.js"></script>
</body>
</html>

