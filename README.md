# 📚 DebSu Lit – Online E-Commerce Bookstore

[![Python](https://img.shields.io/badge/Python-3.12-3776AB?logo=python&logoColor=white)](https://www.python.org/)
[![Django](https://img.shields.io/badge/Django-4.2-092E20?logo=django&logoColor=white)](https://www.djangoproject.com/)
[![Neon](https://img.shields.io/badge/Neon-PostgreSQL-00E599?logo=postgresql&logoColor=white)](https://neon.tech/)
[![Cloudinary](https://img.shields.io/badge/Cloudinary-Media%20CDN-3448C5?logo=cloudinary&logoColor=white)](https://cloudinary.com/)
[![Render](https://img.shields.io/badge/Render-Deployed-46E3B7?logo=render&logoColor=white)](https://render.com/)
[![Razorpay](https://img.shields.io/badge/Razorpay-Secure%20Checkout-0C2340?logo=razorpay&logoColor=white)](https://razorpay.com/)
[![Bootstrap](https://img.shields.io/badge/Bootstrap-4.6-7952B3?logo=bootstrap&logoColor=white)](https://getbootstrap.com/)

**DebSu Lit** is a production-ready, full-featured e-commerce bookstore web application crafted with a scalable Django backend, modern glassmorphic UI, secure Razorpay payment gateway, Neon serverless PostgreSQL database, and Cloudinary media CDN.

---

## ✨ Features

- **📖 Curated Catalog & Discovery:** Dynamic book categorization (Epics, Novels, Thrillers, etc.), new arrivals, featured showcases, and detailed book specifications (ISBN-13, publisher, language, page count, binding).
- **⚡ Interactive Book Details & Dual CTAs:**
  - Dynamic quantity stepper (`-` / `+`) with real-time numeric adjustments.
  - Asynchronous AJAX **"Add to Cart"** that updates the header cart badge in real-time and transitions button state to **"Go to Cart"** (with checkmark and in-cart indicators).
  - High-converting **"Buy Now"** CTA that saves selected quantity to cart and immediately redirects to checkout.
- **🛒 Smart Shopping Cart & Flexible Checkout:**
  - Real-time quantity adjustments and server-side subtotal calculations.
  - Multi-address selection: use saved profile address or enter custom address with 1-click option to save to user profile.
  - **"Booking for someone else"** gift workflow with recipient name, 10-digit mobile validation, and optional gift note.
- **💳 Secure Razorpay Two-Phase Checkout:**
  - Server-side price calculation in paise (INR) preventing tampering.
  - Cryptographic HMAC-SHA256 signature verification (`/verify-payment/`).
  - Clear **Razorpay Test Mode Helper Notice** in checkout explaining test card simulator OTP (`123456` or `Skip OTP`).
- **📦 Order History & Random Order ID Generation:**
  - Unique random order IDs (`DSL-ORD-XXXXXX`) generated for each transaction and indexed in the database.
  - Expandable **"Order details"** drawer breakdown for every order:
    - **Payment & Price Summary:** item rate, quantity, item subtotal, free shipping, total paid, payment gateway, transaction ref (`pay_xxx`), and verification status.
    - **Shipping & Fulfillment:** order confirmed status, 24–48 hr dispatch timeline, and full delivery address.
- **🎨 Glassmorphic Responsive Navigation:**
  - Floating frosted-glass mobile navigation drawer (`backdrop-filter: blur(12px)`).
  - Responsive 3-bar animated hamburger toggle strictly visible on mobile & tablet (`< 992px`) and hidden on desktop (`≥ 992px`).
  - Smooth micro-animations for hover, active, and open drawer transitions.
- **👤 Modern Customer Authentication & Security:**
  - `CustomUser` model supporting username or email login.
  - Real-time client-side & server-side validation (unique username, unique email, 10-digit mobile, complex password rule: min 8 characters, uppercase, lowercase, number, special char).
  - Password visibility toggle (eye icon) on login, signup, user account, and forgot password.
  - Live password confirmation match feedback.
  - Profile management requiring current password confirmation before updates.
- **⚡ High Performance & Zero N+1 Queries:**
  - All database queries optimized with `.select_related('item', 'item__category')`.
  - Header cart counter calculated via database aggregation (`aggregate(total=Sum('quantity'))`).
- **☁️ Cloudinary Media CDN:** Cloud-hosted, high-performance book covers organized under the dedicated `DebSu-Lit_Book-Store_Group-Project` folder.
- **🗄️ Universal Database Engine:** Compatible with Neon PostgreSQL (Production), MySQL (XAMPP/Local), and SQLite with automatic environment switching.
- **🎓 Student Registration Portal:** Dedicated CRUD interface for student record registration, listing, updates, and deletion.
- **🛡️ Custom Admin Suite:** Django administration interface featuring book cover preview thumbnails, order management, and user controls.

---

## 🏗️ Architecture & System Design

<p align="center">
  <img src="./Assets/diagram.png" alt="System Architecture Diagram" width="100%" />
</p>

### 📁 Directory Structure

```text
DebSu-Lit_Book-Store_Group-Project/
├── .env                              # Active local environment variables (ignored by git)
├── .env.example                      # Environment variables template
├── .gitignore                        # Git ignore rules (protects .env, staticfiles, etc.)
├── build.sh                          # Production cloud build script (pip, collectstatic, migrate)
├── manage.py                         # Root management script (run directly from repo root)
├── Procfile                          # Production process configuration for Gunicorn
├── PROJECT_OVERVIEW.md               # Master technical dossier & LLM prompt templates
├── README.md                         # Repository documentation and runbook
├── WALKTHROUGH.md                    # Detailed feature walkthrough & testing guide
├── requirements.txt                  # Production & development dependencies
├── runtime.txt                       # Python 3.12.8 runtime specifier
├── wsgi.py                           # Production WSGI entrypoint
├── Assets/
│   └── diagram.png                   # System Architecture Diagram
└── BOOK STORE (DebSu Lit)/
    └── book_store/
        ├── manage.py                 # Inner project CLI management script
        ├── book_store/               # Django core package
        │   ├── settings.py           # Environment-driven settings (WhiteNoise, Cloudinary, DB)
        │   ├── urls.py               # Main URL routing
        │   └── wsgi.py               # Internal WSGI config
        └── myapp/                    # Bookstore application
            ├── models.py             # CustomUser, Category, Item, CartItem, Order, Student
            ├── views.py              # Controllers, cart logic, payment & order management
            ├── urls.py               # 27 active application routes
            ├── forms.py              # Registration, profile update, and student forms
            ├── context_processors.py # Optimized global category & cart badge counter
            ├── admin.py              # Django admin registrations with thumbnails
            ├── templates/myapp/      # 21 modern templates with glassmorphic styles
            └── static/myapp/         # CSS design tokens, dsl-style.css, JS scripts, icons
```

---

## 🚀 Quick Start Guide (Local Development)

### 1. Prerequisites
* **Python 3.12** *(Recommended: Python 3.12.8)*
* **Git**

### 2. Clone Repository & Install Dependencies
```bash
git clone https://github.com/itsSubhojit/DebSu-Lit_Book-Store_Group-Project.git
cd DebSu-Lit_Book-Store_Group-Project

pip install -r requirements.txt
```

### 3. Setup Environment Variables
Copy `.env.example` to `.env`:
```bash
cp .env.example .env
```
Update your credentials in `.env` (or keep defaults to use local SQLite settings).

### 4. Database Setup & Migrations
Run migrations directly from the repository root:
```bash
python manage.py migrate
```

Create an admin account:
```bash
python manage.py createsuperuser
```

### 5. Launch the Development Server
```bash
python manage.py runserver
```

Open your browser at: **[http://127.0.0.1:8000/](http://127.0.0.1:8000/)**

---

## 🌐 Production Deployment (Render + Neon + Cloudinary)

This project is pre-configured for a **100% Free Forever & Safe** production deployment:

### 1. Services Setup
1. **Database ([Neon.tech](https://neon.tech/)):** Create a free PostgreSQL database and copy the `postgresql://...` connection string.
2. **Media CDN ([Cloudinary.com](https://cloudinary.com/)):** Obtain your Cloud Name, API Key, and API Secret.
3. **Payment Gateway ([Razorpay](https://razorpay.com/)):** Obtain your Test Key ID and Key Secret.

### 2. Deploy on [Render.com](https://render.com/)
1. Create a new **Web Service** connected to your GitHub repository.
2. Configure settings:
   - **Build Command:** `bash build.sh`
   - **Start Command:** `gunicorn wsgi:application`
   - **Root Directory:** *(Leave blank)*
3. Add Environment Variables in Render Dashboard:
   - `DEBUG`: `False`
   - `SECRET_KEY`: *(Generate a secure random string)*
   - `ALLOWED_HOSTS`: `.onrender.com,localhost,127.0.0.1`
   - `CSRF_TRUSTED_ORIGINS`: `https://*.onrender.com`
   - `DATABASE_URL`: *(Your Neon PostgreSQL connection string)*
   - `CLOUDINARY_CLOUD_NAME`: *(Your Cloud Name)*
   - `CLOUDINARY_API_KEY`: *(Your Cloudinary API Key)*
   - `CLOUDINARY_API_SECRET`: *(Your Cloudinary API Secret)*
   - `CLOUDINARY_PREFIX`: `DebSu-Lit_Book-Store_Group-Project`
   - `RAZORPAY_API_KEY`: *(Your Razorpay Key ID)*
   - `RAZORPAY_API_SECRET`: *(Your Razorpay Key Secret)*
4. Click **Deploy Web Service**. Render will automatically run `build.sh` (install packages, collect static files via WhiteNoise, execute database migrations) and launch Gunicorn.

### 3. Creating Admin Superuser for Production
Since Render's free tier disables the interactive web shell, you can create a production superuser directly from your local terminal because your local `.env` points to your Neon PostgreSQL database:
```bash
python manage.py createsuperuser
```
Enter your desired username (e.g. `admin`), email, and password. This immediately saves the administrator credentials into your live Neon cloud database!

### 4. Accessing the Admin Portal
- **Local:** `http://127.0.0.1:8000/admin/`
- **Render Production:** `https://<your-render-subdomain>.onrender.com/admin/`

---

## 🔗 Key Endpoints

| Endpoint | Method | Description |
|---|---|---|
| `/` | GET | Storefront Homepage with category filters |
| `/arrivals/<id>/` | GET | Category filtered books showcase |
| `/featuresbook1/<item_id>/` | GET | Book details, quantity stepper, and dual CTAs |
| `/add/<item_id>/` | GET/POST | Add item to cart with quantity & AJAX support |
| `/buy-now/<item_id>/` | GET/POST | Sets item quantity and redirects directly to cart |
| `/cart` | GET | Shopping cart with saved address / gift checkout |
| `/remove/<id>` | GET | Remove cart item |
| `/initiate-payment/` | POST | Secure server-side Razorpay order initiation |
| `/verify-payment/` | POST | Cryptographic HMAC-SHA256 signature verification & order creation |
| `/payment-success/` | GET | Payment confirmation and celebration screen |
| `/payment-failed/` | GET | Payment failure notice and retry option |
| `/myorder/` | GET | Order history with random Order ID & expandable order details |
| `/useraccount` | GET/POST | User profile & saved delivery address portal |
| `/login` & `/signup` | GET/POST | Customer authentication (username/email login) |
| `/forgotpassword` | GET/POST | Password reset workflow |
| `/stdlist` | GET | Student CRUD management portal |
| `/admin/` | GET/POST | Django Administration panel |

---

## 👥 Authors

* **Subhojit Chakraborty**
