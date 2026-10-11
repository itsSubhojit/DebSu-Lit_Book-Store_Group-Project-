# 📚 DebSu Lit – Online E-Commerce Bookstore

[![Python](https://img.shields.io/badge/Python-3.12-3776AB?logo=python&logoColor=white)](https://www.python.org/)
[![Django](https://img.shields.io/badge/Django-4.2-092E20?logo=django&logoColor=white)](https://www.djangoproject.com/)
[![Neon](https://img.shields.io/badge/Neon-PostgreSQL-00E599?logo=postgresql&logoColor=white)](https://neon.tech/)
[![Cloudinary](https://img.shields.io/badge/Cloudinary-Media%20CDN-3448C5?logo=cloudinary&logoColor=white)](https://cloudinary.com/)
[![Render](https://img.shields.io/badge/Render-Deployed-46E3B7?logo=render&logoColor=white)](https://render.com/)
[![Razorpay](https://img.shields.io/badge/Razorpay-Secure%20Checkout-0C2340?logo=razorpay&logoColor=white)](https://razorpay.com/)
[![Bootstrap](https://img.shields.io/badge/Bootstrap-4.6-7952B3?logo=bootstrap&logoColor=white)](https://getbootstrap.com/)

**DebSu Lit** is a production-ready, full-featured e-commerce web application tailored for browsing, purchasing, and managing books online. Built with a scalable Django backend, responsive Bootstrap interface, secure Razorpay payment gateway, Neon serverless PostgreSQL database, and Cloudinary media CDN.

---

## ✨ Features

- **📖 Catalog & Discovery:** Dynamic book categorization (Epics, Novels, Thrillers, etc.), new arrivals, featured showcases, and detailed book specifications (ISBN, publisher, page count, binding).
- **🛒 Shopping Cart System:** Real-time item additions, quantity management, dynamic server-side subtotal calculations, and item removal.
- **💳 Secure Razorpay Integration:** End-to-end payment workflow with server-side price calculation, cryptographic HMAC-SHA256 signature verification (`/verify-payment/`), and transactional order generation.
- **☁️ Cloudinary Media CDN:** Cloud-hosted, high-performance book covers organized under the dedicated `DebSu-Lit_Book-Store_Group-Project` folder.
- **🗄️ Universal Database Engine:** Compatible with Neon PostgreSQL (Production), MySQL (XAMPP/Local), and SQLite with automatic environment switching.
- **👤 User Management:** Custom authentication model with mobile verification, profile update portal, order history tracking, and session controls.
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
├── .env.example                       # Environment variables template
├── .gitignore                         # Git ignore rules (protects .env, staticfiles, etc.)
├── build.sh                           # Production cloud build script (pip, collectstatic, migrate)
├── manage.py                          # Root management script (run directly from repo root)
├── Procfile                           # Production process configuration for Gunicorn
├── requirements.txt                   # Production & development dependencies
├── runtime.txt                        # Python 3.12.8 runtime specifier
├── wsgi.py                            # Production WSGI entrypoint
├── Assets/
│   └── diagram.png                    # System Architecture Diagram
└── BOOK STORE (DebSu Lit)/
    └── book_store/
        ├── manage.py                  # Project CLI management script
        ├── book_store/                # Django core (settings, URLs, WSGI)
        │   ├── settings.py            # Environment-driven settings (WhiteNoise, Cloudinary, DB)
        │   ├── urls.py                # Main URL routing
        │   └── wsgi.py                # Internal WSGI config
        └── myapp/                     # Main bookstore application
            ├── models.py              # CustomUser, Category, Item, CartItem, Order, Student
            ├── views.py               # E-commerce controllers & payment verification
            ├── urls.py                # App route mappings
            ├── forms.py               # Registration and user update forms
            ├── templates/myapp/       # Responsive Bootstrap HTML templates
            └── static/myapp/          # CSS, JS, and image assets
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
Update your credentials in `.env` (or keep defaults to use local settings).

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

Log in using the superuser credentials created above to manage Books, Categories, Orders, Cart items, and Users.

---

## 🔗 Key Endpoints

| Endpoint | Description |
|---|---|
| `/` | Storefront Homepage |
| `/arrivals/<id>/` | Category filter showcase |
| `/featuresbook1/<id>/` | Book specifications & details |
| `/cart` | Shopping cart view |
| `/initiate-payment/` | Backend order creation & price calculation |
| `/verify-payment/` | Cryptographic Razorpay signature verification |
| `/myorder/` | User order history |
| `/useraccount` | User profile update portal |
| `/login` & `/signup` | Customer authentication |
| `/stdlist` | Student CRUD management |
| `/admin/` | Django Administration panel |

---

## 👥 Authors

* **Subhojit Chakraborty**
