#!/usr/bin/env python
"""Root proxy runner for Django's command-line utility."""
import os
import sys
from pathlib import Path

# Add the inner Django project folder to sys.path
PROJECT_DIR = Path(__file__).resolve().parent / "BOOK STORE (DebSu Lit)" / "book_store"
if str(PROJECT_DIR) not in sys.path:
    sys.path.insert(0, str(PROJECT_DIR))

def main():
    """Run administrative tasks."""
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'book_store.settings')
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc
    execute_from_command_line(sys.argv)

if __name__ == '__main__':
    main()
