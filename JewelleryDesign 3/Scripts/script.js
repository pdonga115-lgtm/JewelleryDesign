/* ============================================================
   JEWELLERY DESIGN — Main Script
   ============================================================ */

'use strict';

/* ---------- Loader ---------- */
window.addEventListener('load', () => {
  const loader = document.getElementById('loader');
  if (loader) {
    setTimeout(() => loader.classList.add('hide'), 800);
  }
});

/* ---------- Cursor Glow ---------- */
const cursorGlow = document.getElementById('cursorGlow');
if (cursorGlow) {
  document.addEventListener('mousemove', e => {
    cursorGlow.style.left = e.clientX + 'px';
    cursorGlow.style.top  = e.clientY + 'px';
  });
}

/* ---------- Navbar Scroll ---------- */
const mainNav = document.getElementById('mainNav');
if (mainNav) {
  window.addEventListener('scroll', () => {
    mainNav.classList.toggle('scrolled', window.scrollY > 50);
  });
}

/* ---------- Scroll Top Button ---------- */
const scrollTopBtn = document.getElementById('scrollTopBtn');
if (scrollTopBtn) {
  window.addEventListener('scroll', () => {
    scrollTopBtn.classList.toggle('show', window.scrollY > 400);
  });
  scrollTopBtn.addEventListener('click', () => {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  });
}

/* ---------- Active Nav Link on Scroll ---------- */
const sections  = document.querySelectorAll('section[id], header[id]');
const navLinks  = document.querySelectorAll('.main-links .nav-link');

const observerNav = new IntersectionObserver(entries => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      navLinks.forEach(l => l.classList.remove('active'));
      const active = document.querySelector(`.main-links a[href="#${entry.target.id}"]`);
      if (active) active.classList.add('active');
    }
  });
}, { threshold: 0.35 });

sections.forEach(s => observerNav.observe(s));

/* ---------- Reveal on Scroll ---------- */
const revealEls = document.querySelectorAll('.reveal');
const observerReveal = new IntersectionObserver(entries => {
  entries.forEach((entry, i) => {
    if (entry.isIntersecting) {
      setTimeout(() => entry.target.classList.add('visible'), i * 120);
      observerReveal.unobserve(entry.target);
    }
  });
}, { threshold: 0.15 });

revealEls.forEach(el => observerReveal.observe(el));

/* ---------- Dark / Light Toggle ---------- */
const themeToggle = document.getElementById('themeToggle');
const themeIcon   = themeToggle ? themeToggle.querySelector('i') : null;

function applyTheme(mode) {
  if (mode === 'light') {
    document.body.classList.add('light-mode');
    if (themeIcon) { themeIcon.classList.replace('fa-moon', 'fa-sun'); }
  } else {
    document.body.classList.remove('light-mode');
    if (themeIcon) { themeIcon.classList.replace('fa-sun', 'fa-moon'); }
  }
  localStorage.setItem('jd-theme', mode);
}

// Load saved preference
applyTheme(localStorage.getItem('jd-theme') || 'dark');

if (themeToggle) {
  themeToggle.addEventListener('click', () => {
    const isDark = !document.body.classList.contains('light-mode');
    applyTheme(isDark ? 'light' : 'dark');
  });
}

/* ---------- Search Toggle ---------- */
const searchToggle = document.getElementById('searchToggle');
const searchInput  = document.getElementById('searchInput');

if (searchToggle && searchInput) {
  searchToggle.addEventListener('click', e => {
    e.stopPropagation();
    if (searchInput.classList.contains('open') && searchInput.value.trim().length > 0) {
      window.location.href = 'Products.aspx?q=' + encodeURIComponent(searchInput.value.trim());
    } else {
      searchInput.classList.toggle('open');
      if (searchInput.classList.contains('open')) searchInput.focus();
    }
  });
  searchInput.addEventListener('keydown', e => {
    if (e.key === 'Enter') {
      e.preventDefault();
      const q = searchInput.value.trim();
      if (q.length > 0) {
        window.location.href = 'Products.aspx?q=' + encodeURIComponent(q);
      }
    }
  });
  document.addEventListener('click', e => {
    if (!searchInput.contains(e.target) && e.target !== searchToggle) {
      searchInput.classList.remove('open');
    }
  });
}

/* ---------- Wishlist Toggle ---------- */
document.querySelectorAll('.wish-btn').forEach(btn => {
  btn.addEventListener('click', () => {
    btn.classList.toggle('active');
    const icon = btn.querySelector('i');
    if (btn.classList.contains('active')) {
      icon.classList.replace('fa-regular', 'fa-solid');
      showToast('Added to Wishlist ♥');
    } else {
      icon.classList.replace('fa-solid', 'fa-regular');
      showToast('Removed from Wishlist');
    }
  });
});

/* ---------- Add to Cart (links go to AddToCart.aspx; button version is only a demo) ---------- */
document.querySelectorAll('button.btn-add-cart').forEach(btn => {
  btn.addEventListener('click', () => {
    btn.innerHTML = '<i class="fa-solid fa-check me-2"></i>Added!';
    btn.style.background = 'var(--gold-grad)';
    btn.style.color = '#1a1208';
    setTimeout(() => {
      btn.innerHTML = '<i class="fa-solid fa-bag-shopping me-2"></i>Add to Cart';
      btn.style.background = '';
      btn.style.color = '';
    }, 1800);
    showToast('Item added to cart!');
  });
});

/* ---------- Counter Animation ---------- */
function animateCounter(el) {
  const target = parseInt(el.dataset.target, 10);
  const duration = 1800;
  const step = Math.ceil(target / (duration / 16));
  let current = 0;
  const timer = setInterval(() => {
    current += step;
    if (current >= target) { current = target; clearInterval(timer); }
    el.textContent = current;
  }, 16);
}

const counterEls = document.querySelectorAll('.counter');
if (counterEls.length) {
  const observerCounter = new IntersectionObserver(entries => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        animateCounter(entry.target);
        observerCounter.unobserve(entry.target);
      }
    });
  }, { threshold: 0.5 });
  counterEls.forEach(el => observerCounter.observe(el));
}

/* ---------- Gallery Lightbox (simple) ---------- */
document.querySelectorAll('.gallery-item').forEach(item => {
  item.addEventListener('click', () => {
    const src  = item.querySelector('img').src;
    const alt  = item.querySelector('img').alt;
    const overlay = document.createElement('div');
    overlay.style.cssText = `
      position:fixed;inset:0;z-index:9998;background:rgba(0,0,0,0.92);
      display:flex;align-items:center;justify-content:center;cursor:zoom-out;
      animation:fadeIn .25s ease;
    `;
    overlay.innerHTML = `
      <img src="${src}" alt="${alt}"
           style="max-width:88vw;max-height:88vh;border-radius:12px;
                  box-shadow:0 20px 60px rgba(0,0,0,.6);object-fit:contain;">
    `;
    document.body.appendChild(overlay);
    overlay.addEventListener('click', () => overlay.remove());
    document.addEventListener('keydown', function esc(e) {
      if (e.key === 'Escape') { overlay.remove(); document.removeEventListener('keydown', esc); }
    });
  });
});

/* ---------- Toast Notification ---------- */
function showToast(message) {
  let container = document.getElementById('toastContainer');
  if (!container) {
    container = document.createElement('div');
    container.id = 'toastContainer';
    container.style.cssText = `
      position:fixed;bottom:80px;right:24px;z-index:9995;
      display:flex;flex-direction:column;gap:8px;
    `;
    document.body.appendChild(container);
  }
  const toast = document.createElement('div');
  toast.style.cssText = `
    background:var(--gold-grad);color:#1a1208;padding:12px 22px;
    border-radius:30px;font-size:.85rem;font-weight:600;
    box-shadow:0 6px 24px rgba(212,175,55,.35);
    animation:slideUp .3s ease;pointer-events:none;
  `;
  toast.textContent = message;
  container.appendChild(toast);
  setTimeout(() => toast.remove(), 2500);
}

/* ---------- Newsletter Form ---------- */
const newsletterForm = document.getElementById('newsletterForm');
if (newsletterForm) {
  newsletterForm.addEventListener('submit', e => {
    e.preventDefault();
    const input = newsletterForm.querySelector('input[type="email"]');
    if (input && input.value) {
      showToast('Subscribed successfully! ✓');
      input.value = '';
    }
  });
}

/* ---------- Contact Form ---------- */
const contactForm = document.querySelector('.contact-form');
if (contactForm) {
  contactForm.addEventListener('submit', e => {
    e.preventDefault();
    showToast('Message sent! We\'ll be in touch soon.');
    contactForm.reset();
  });
}

/* ---------- Cart toast after AddToCart.aspx redirects back (?added=1) ---------- */
if (window.location.search.indexOf('added=1') > -1) {
  showToast('Item added to cart!');
  if (window.history.replaceState) {
    window.history.replaceState({}, document.title, window.location.pathname + window.location.hash);
  }
}

/* ---------- Footer Year ---------- */
const yearEl = document.getElementById('year');
if (yearEl) yearEl.textContent = new Date().getFullYear();

/* ---------- Keyframe Injection ---------- */
const styleSheet = document.createElement('style');
styleSheet.textContent = `
  @keyframes fadeIn   { from { opacity:0 } to { opacity:1 } }
  @keyframes slideUp  { from { opacity:0; transform:translateY(12px) } to { opacity:1; transform:translateY(0) } }
`;
document.head.appendChild(styleSheet);
