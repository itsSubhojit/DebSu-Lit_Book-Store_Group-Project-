from django.db.models import Sum
from .models import Category, CartItem


def global_store_context(request):
    """
    Injects global catalog categories and real cart item count into all template contexts.
    Optimized to use database aggregate Sum to eliminate object instantiation overhead.
    """
    categories = Category.objects.all().order_by('cat_name')
    cart_count = 0
    if request.user.is_authenticated:
        cart_count = CartItem.objects.filter(user=request.user).aggregate(total=Sum('quantity'))['total'] or 0

    return {
        'categories': categories,
        'cart_count': cart_count,
    }
