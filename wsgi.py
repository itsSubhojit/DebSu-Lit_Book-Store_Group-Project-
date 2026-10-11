"""Root WSGI entrypoint for cloud deployment (Render, Railway, Heroku, Dokku, etc.)."""
import os
import sys
from pathlib import Path

# Add the inner Django project folder to sys.path
PROJECT_DIR = Path(__file__).resolve().parent / "BOOK STORE (DebSu Lit)" / "book_store"
if str(PROJECT_DIR) not in sys.path:
    sys.path.insert(0, str(PROJECT_DIR))

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'book_store.settings')

from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()
app = application  # Alias for serverless platforms like Vercel
