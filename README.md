# 📚 DebSu Lit – Online E-Commerce Bookstore

[![Python](https://img.shields.io/badge/Python-3.12-3776AB?logo=python&logoColor=white)](https://www.python.org/)
[![Django](https://img.shields.io/badge/Django-4.2-092E20?logo=django&logoColor=white)](https://www.djangoproject.com/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Razorpay](https://img.shields.io/badge/Razorpay-Integrated-0C2340?logo=razorpay&logoColor=white)](https://razorpay.com/)
[![Bootstrap](https://img.shields.io/badge/Bootstrap-4.6-7952B3?logo=bootstrap&logoColor=white)](https://getbootstrap.com/)

**DebSu Lit** is a full-featured e-commerce web application tailored for browsing, searching, purchasing, and managing books online. Built with a scalable Django backend, relational MySQL database, and responsive Bootstrap interface, it features full customer authentication, shopping cart management, seamless Razorpay payment gateway integration, and administrative controls.

---

## ✨ Features

- **📖 Catalog & Discovery:** Dynamic book categorization (Epics, Novels, Thrillers, etc.), new arrivals, featured showcases, and detailed book specifications (ISBN, publisher, page count, binding).
- **🛒 Shopping Cart System:** Real-time item additions, quantity management, dynamic subtotal calculations, and item removal.
- **💳 Razorpay Payment Integration:** Checkout workflow supporting online payments in INR with automated order generation upon transaction confirmation.
- **👤 User Management:** Custom authentication model with mobile verification, profile update portal, order history tracking, and session controls.
- **🎓 Student Registration Portal:** Dedicated CRUD interface for student record registration, listing, updates, and deletion.
- **🛡️ Custom Admin Suite:** Customized Django administration interface featuring book cover preview thumbnails directly within data tables.

---

## 🏗️ Architecture & Directory Structure

```text
DebSu-Lit_Book-Store_Group-Project-/
├── BOOK STORE (DebSu Lit)/
│   ├── bookstore.sql              # Pre-populated MySQL database schema & sample catalog
│   ├── Group Documentation.pdf    # Academic project report and documentation
│   └── book_store/                # Django project root
│       ├── manage.py              # CLI management script
│       ├── book_store/            # Settings, URLs, WSGI/ASGI configuration
│       ├── media/items/           # Book covers and UI assets
│       └── myapp/                 # Core application
│           ├── models.py          # CustomUser, Category, Item, CartItem, Order, Student
│           ├── views.py           # Application controllers and payment handlers
│           ├── urls.py            # Route mappings
│           ├── forms.py           # Registration and profile forms
│           ├── templates/myapp/   # Jinja/Django HTML templates
│           └── static/myapp/      # CSS, JS, and image assets
├── .env.example                   # Environment variable template
├── .gitignore                     # Git ignore rules for Python, Django, and IDEs
├── requirements.txt               # Python package dependencies
└── README.md                      # Project documentation
```

---

## 🚀 Quick Start Guide

### 1. Prerequisites
Ensure you have the following installed on your machine:
* **Python Version:** **Python 3.12** *(Supports Python 3.10 – 3.12)*
* **Database:** **MySQL 8.0+** / **XAMPP (MariaDB)**
* **Version Control:** **Git**

> **Note on Python Version:** This project was developed and tested using **Python 3.12.8**. It is recommended to use Python 3.12 to ensure prebuilt wheel compatibility for packages such as `mysqlclient` and `Pillow`.

### 2. Clone Repository & Setup Environment
```bash
git clone https://github.com/itsSubhojit/DebSu-Lit_Book-Store_Group-Project-.git
cd DebSu-Lit_Book-Store_Group-Project-
```


Install the dependencies:
```bash
pip install -r requirements.txt
```

### 3. Database Configuration
1. Start MySQL (e.g., via the XAMPP Control Panel).
2. Create a database named `bookstore`:
   ```sql
   CREATE DATABASE bookstore;
   ```
3. Import the provided SQL dump:
   ```bash
   mysql -u root -p bookstore < "BOOK STORE (DebSu Lit)/bookstore.sql"
   ```
   *(Or import `bookstore.sql` via phpMyAdmin)*.

4. Verify database credentials in `BOOK STORE (DebSu Lit)/book_store/book_store/settings.py` (Default: user `root`, no password, port `3306`).

### 4. Run the Development Server
Navigate to the Django directory and launch the server:
```bash
cd "BOOK STORE (DebSu Lit)/book_store"
python manage.py runserver
```

Open your browser at: **[http://127.0.0.1:8000/](http://127.0.0.1:8000/)**

---

## 🔗 Key Endpoints

| Endpoint | Description |
|---|---|
| `/` | Storefront Homepage |
| `/arrivals/<id>/` | Category filter view |
| `/featuresbook1/<id>/` | Book specifications & details |
| `/cart` | Shopping cart view |
| `/myorder/` | User order history |
| `/useraccount` | User profile update portal |
| `/login` & `/signup` | Authentication views |
| `/stdlist` | Student CRUD administration |
| `/admin/` | Django Administration panel |

---

## 👥 Authors

* **Subhojit Chakraborty**


