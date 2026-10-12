from .models import Category, CartItem


def global_store_context(request):
    """
    Injects global catalog categories and real cart item count into all template contexts.
    Ensures header navigation and cart counter work consistently across every view.
    """
    categories = Category.objects.all().order_by('cat_name')
    cart_count = 0
    if request.user.is_authenticated:
        # Real sum of item quantities in user's cart
        cart_items = CartItem.objects.filter(user=request.user)
        cart_count = sum(item.quantity for item in cart_items)

    return {
        'categories': categories,
        'cart_count': cart_count,
    }
