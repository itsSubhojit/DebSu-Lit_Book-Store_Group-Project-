import logging
import re
import time
import razorpay
import razorpay.errors
from django.conf import settings
from django.http import JsonResponse
from django.shortcuts import render, redirect
from django.contrib import messages
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth import authenticate, login, logout, update_session_auth_hash
from . forms import MyRegFrm, StdRegFrm, MyChngFrm
from . models import CustomUser, Student, Category, Item, CartItem, Order
from django.http import HttpResponse

logger = logging.getLogger(__name__)



# Create your views here.
def home(request):
    categories = Category.objects.all().order_by('cat_name')
    allItem=Item.objects.all()
    return render(request, 'myapp/home.html', {'allItem':allItem, 'categories':categories})

def about(request):
    categories = Category.objects.all().order_by('cat_name')
    allItem=Item.objects.all()
    return render(request, 'myapp/about.html', {'allItem':allItem, 'categories':categories})

def useraccount(request):
    categories = Category.objects.all().order_by('cat_name')
    allItem = Item.objects.all()
    if not request.user.is_authenticated:
        return redirect('/login')

    if request.method == "POST":
        current_password = request.POST.get('current_password', '')
        if not current_password or not request.user.check_password(current_password):
            messages.error(request, 'Incorrect account password. You must confirm your current password to save profile changes.')
            form = MyChngFrm(instance=request.user)
            return render(request, 'myapp/useraccount.html', {'form': form, 'allItem': allItem, 'categories': categories})

        form = MyChngFrm(request.POST, request.FILES, instance=request.user)
        if form.is_valid():
            try:
                new_password = request.POST.get('new_password', '').strip()
                confirm_new_password = request.POST.get('confirm_new_password', '').strip()
                if new_password:
                    if new_password != confirm_new_password:
                        messages.error(request, 'New password and confirmation do not match.')
                        return render(request, 'myapp/useraccount.html', {'form': form, 'allItem': allItem, 'categories': categories})
                    if len(new_password) < 8 or not re.search(r'[A-Z]', new_password) or not re.search(r'[a-z]', new_password) or not re.search(r'[0-9]', new_password) or not re.search(r'[@$!%*?&#^()_+=\-{}\[\]:;"\'<>,./]', new_password):
                        messages.error(request, 'New password must have at least 8 characters, an uppercase letter, a lowercase letter, a number, and a special character.')
                        return render(request, 'myapp/useraccount.html', {'form': form, 'allItem': allItem, 'categories': categories})
                    request.user.set_password(new_password)

                user = form.save()
                if new_password:
                    update_session_auth_hash(request, user)
                messages.success(request, 'Profile updated successfully!')
                return redirect('/useraccount')
            except Exception:
                logger.exception("Failed to update profile for user %s", request.user.username)
                messages.error(request, 'Profile could not be updated. Please check the entered details.')
        else:
            try:
                request.user.refresh_from_db()
            except Exception:
                pass
            messages.error(request, 'Please correct the errors in the form.')
    else:
        form = MyChngFrm(instance=request.user)

    return render(request, 'myapp/useraccount.html', {'form': form, 'allItem': allItem, 'categories': categories})


def signIn(request):
    if request.user.is_authenticated:
        return redirect('/useraccount')

    if request.method == "POST":
        login_id = request.POST.get('username', '').strip()
        upass = request.POST.get('password', '')

        user_obj = None
        # Support login using email as well as username
        if '@' in login_id:
            user_match = CustomUser.objects.filter(email__iexact=login_id).first()
            if user_match:
                user_obj = authenticate(username=user_match.username, password=upass)
        if not user_obj:
            user_obj = authenticate(username=login_id, password=upass)

        if user_obj is not None:
            login(request, user_obj)
            messages.success(request, f"Welcome back, {user_obj.first_name or user_obj.username}!")
            return redirect('/useraccount')
        else:
            messages.error(request, "Invalid username/email or password.")
            return render(request, 'myapp/login.html', {'login_id': login_id})

    return render(request, 'myapp/login.html')


def signOut(request):
    logout(request)
    return redirect('/login')


def signup(request):
    if request.method == "POST":
        form = MyRegFrm(data=request.POST)
        if form.is_valid():
            try:
                form.save()
                messages.success(request, 'Account created successfully! Please sign in with your credentials.')
                return redirect('/login')
            except Exception:
                logger.exception("Failed to save new user registration")
                messages.error(request, 'Registration could not be completed. Please try again.')
        else:
            messages.error(request, 'Please correct the errors below.')
    else:
        form = MyRegFrm()

    return render(request, 'myapp/signup.html', {'frm': form})


def forgotpassword(request):
    if request.method == "POST":
        identity = request.POST.get('identity', '').strip()
        mobile = request.POST.get('mobile', '').strip()
        new_password = request.POST.get('new_password', '').strip()
        confirm_password = request.POST.get('confirm_password', '').strip()

        # Find user by username or email
        user_match = None
        if '@' in identity:
            user_match = CustomUser.objects.filter(email__iexact=identity).first()
        if not user_match:
            user_match = CustomUser.objects.filter(username__iexact=identity).first()

        if not user_match:
            messages.error(request, 'No registered account found with that username or email.')
            return render(request, 'myapp/forgotpassword.html', {'identity': identity, 'mobile': mobile})

        if user_match.mobile != mobile:
            messages.error(request, 'The mobile number provided does not match our records for this account.')
            return render(request, 'myapp/forgotpassword.html', {'identity': identity, 'mobile': mobile})

        if new_password != confirm_password:
            messages.error(request, 'Passwords do not match.')
            return render(request, 'myapp/forgotpassword.html', {'identity': identity, 'mobile': mobile})

        # Validate password strength: min 8 chars, uppercase, lowercase, number, special char
        if len(new_password) < 8 or not re.search(r'[A-Z]', new_password) or not re.search(r'[a-z]', new_password) or not re.search(r'[0-9]', new_password) or not re.search(r'[@$!%*?&#^()_+=\-{}\[\]:;"\'<>,./]', new_password):
            messages.error(request, 'Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character (e.g. @User123).')
            return render(request, 'myapp/forgotpassword.html', {'identity': identity, 'mobile': mobile})

        # Update password
        user_match.set_password(new_password)
        user_match.save()
        messages.success(request, 'Your password has been reset successfully! Please log in with your new password.')
        return redirect('/login')

    return render(request, 'myapp/forgotpassword.html')

def orders(request):
    return render(request, 'myapp/orders.html')

def shoppingcart(request):
    return render(request, 'myapp/shoppingcart.html')

def featured(request):
    return render(request, 'myapp/featured.html')

def arrivals(request, id):
    categories = Category.objects.all().order_by('cat_name')
    allItem=Item.objects.filter(category=id)
    return render(request, 'myapp/arrivals.html', {'allItem':allItem, 'categories':categories})


def stdReg(request):
    if request.POST:
        form=StdRegFrm(data=request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, 'Registartion is Successfull')
        else:
            messages.error(request, 'Registration is Unsuccessfull')
    else:
         form=StdRegFrm()
    context={'form':form}
    return render(request, 'myapp/stdReg.html', context)

def stdList(request):
    allstd=Student.objects.all()
    return render(request, 'myapp/stdShow.html', {'allstd':allstd})

def stdDel(request, id):
    std=Student.objects.get(id=id)
    if std:
        std.delete()
        messages.success(request, 'Student Details Remove Successfully')
    else:
        messages.error(request, 'Student Details Not Remove Successfully')
    return redirect('/stdlist') 

def stdUpd(request,id):
    std=Student.objects.get(id=id)
    form=StdRegFrm(request.POST or None, instance=std)
    if form.is_valid():
        try:
            form.save()
            messages.success(request, 'Student Details Updated Successfully')
        except Exception:
            logger.exception("Failed to update student details for ID %s", id)
            messages.error(request, 'Student Details Not Updated Successfully')
        return redirect('/stdlist')
    return render(request, 'myapp/stdUpd.html', {'form':form})

def stdAdmin(request):
    allfeatured=Category.objects.all()
    return render(request, 'myapp/stdAdmin.html', {'allfeatured':allfeatured}) 

def featuresbook1(request,item_id):
    item=Item.objects.get(id=item_id)
    return render(request, 'myapp/featuresbook1.html', {'item':item})

def add_to_cart(request, item_id):
	if request.user.is_authenticated:
		item = Item.objects.get(id=item_id)
		cart_item, created = CartItem.objects.get_or_create(item=item, 
                                                        user=request.user)
		cart_item.quantity += 1
		cart_item.save()
		return redirect('/cart')
	else:
		return redirect('/login')

def view_cart(request):
    if request.user.is_authenticated:
          cart_items = CartItem.objects.filter(user=request.user)
          total_price = sum(int(item.item.price) * int(item.quantity) for item in cart_items)
          total_price = int(total_price)
          return render(request, 'myapp/cart.html', {
              'cart_items': cart_items,
              'total_price': total_price,
              'saved_user': request.user
          })
    else:
        return redirect('/login')
    
     
def remove_cart(request,id):
    if request.user.is_authenticated:
        cart_item = CartItem.objects.get(id=id, user=request.user)
        cart_item.delete()
        return redirect('/cart')
    else:
        return redirect('/login')


def initiate_payment(request):
    if not request.user.is_authenticated:
        return JsonResponse({"error": "Please log in to proceed with payment."}, status=401)

    if request.method == "POST":
        address = request.POST.get('address', '').strip()
        if not address:
            return JsonResponse({"error": "Delivery address is required."}, status=400)

        # Optionally save address to user's profile if requested
        if request.POST.get('save_to_profile') == 'true':
            addr_line1 = request.POST.get('addr_line1', '').strip()
            addr_line2 = request.POST.get('addr_line2', '').strip()
            city = request.POST.get('addr_city', '').strip()
            state = request.POST.get('addr_state', '').strip()
            pincode = request.POST.get('addr_pincode', '').strip()
            if addr_line1:
                request.user.address_line1 = addr_line1
            if addr_line2:
                request.user.address_line2 = addr_line2
            if city:
                request.user.city = city
            if state:
                request.user.state = state
            if pincode:
                request.user.pincode = pincode
            try:
                request.user.save()
            except Exception:
                pass

        cart_items = CartItem.objects.filter(user=request.user)
        if not cart_items.exists():
            return JsonResponse({"error": "Your cart is empty."}, status=400)

        # Secure server-side calculation: never trust client-submitted amount
        total_price = sum(int(item.item.price) * int(item.quantity) for item in cart_items)
        if total_price <= 0:
            return JsonResponse({"error": "Invalid order amount."}, status=400)

        amount_in_paise = int(total_price * 100)

        if not settings.RAZORPAY_API_KEY or not settings.RAZORPAY_API_SECRET:
            logger.error("Razorpay API credentials are not configured in settings.")
            return JsonResponse({"error": "Payment service is currently unavailable. Please try again later."}, status=500)

        client = razorpay.Client(auth=(settings.RAZORPAY_API_KEY, settings.RAZORPAY_API_SECRET))

        receipt_id = f"rcpt_{request.user.id}_{int(time.time())}"
        payment_data = {
            "amount": amount_in_paise,
            "currency": "INR",
            "receipt": receipt_id,
            "notes": {
                "user_id": str(request.user.id),
                "username": request.user.username,
            },
        }

        try:
            order = client.order.create(data=payment_data)
        except Exception as e:
            logger.error("Failed to initiate order with Razorpay: %s", e, exc_info=True)
            return JsonResponse({"error": "Failed to initiate payment. Please try again later."}, status=500)

        # Store pending address in session for payment verification
        request.session['pending_order_address'] = address
        request.session['pending_razorpay_order_id'] = order["id"]

        user_name = request.user.get_full_name() or request.user.username
        user_email = request.user.email or ""
        user_contact = getattr(request.user, 'mobile', '') or ""

        response_data = {
            "id": order["id"],
            "amount": order["amount"],
            "currency": order["currency"],
            "key": settings.RAZORPAY_API_KEY,
            "name": "DebSu Lit Book Store",
            "description": "Payment for Book Purchase",
            "prefill": {
                "name": user_name,
                "email": user_email,
                "contact": user_contact,
            },
        }

        return JsonResponse(response_data)
    return redirect('/cart')


def verify_payment(request):
    if not request.user.is_authenticated:
        return JsonResponse({"status": "failure", "message": "User not authenticated."}, status=401)

    if request.method == "POST":
        razorpay_order_id = request.POST.get("razorpay_order_id", "").strip()
        razorpay_payment_id = request.POST.get("razorpay_payment_id", "").strip()
        razorpay_signature = request.POST.get("razorpay_signature", "").strip()
        address = request.POST.get("address", "").strip() or request.session.get("pending_order_address", "")

        if not (razorpay_order_id and razorpay_payment_id and razorpay_signature):
            return JsonResponse({"status": "failure", "message": "Missing payment verification parameters."}, status=400)

        client = razorpay.Client(auth=(settings.RAZORPAY_API_KEY, settings.RAZORPAY_API_SECRET))

        params_dict = {
            "razorpay_order_id": razorpay_order_id,
            "razorpay_payment_id": razorpay_payment_id,
            "razorpay_signature": razorpay_signature,
        }

        # Cryptographically verify that payment was authorized by Razorpay
        try:
            client.utility.verify_payment_signature(params_dict)
        except razorpay.errors.SignatureVerificationError as e:
            logger.warning("Payment signature verification failed for order %s: %s", razorpay_order_id, e)
            return JsonResponse({"status": "failure", "message": "Payment signature verification failed."}, status=400)
        except Exception as e:
            logger.error("Unexpected error during payment verification for order %s: %s", razorpay_order_id, e, exc_info=True)
            return JsonResponse({"status": "failure", "message": "Payment verification failed. Please try again or contact support."}, status=400)

        # Payment verified: create orders and clear cart
        cart_items = CartItem.objects.filter(user=request.user)
        for cart in cart_items:
            Order.objects.create(
                user=request.user,
                item=cart.item,
                quantity=cart.quantity,
                payment_status="success",
                payment_id=razorpay_payment_id,
                address=address,
            )

        cart_items.delete()

        # Clean up session keys
        request.session.pop("pending_order_address", None)
        request.session.pop("pending_razorpay_order_id", None)

        return JsonResponse({"status": "success", "message": "Payment verified successfully!"})

    return JsonResponse({"status": "failure", "message": "Invalid request method."}, status=405)

def payment_success(request):
    return render(request, "myapp/payment_success.html")

def payment_failed(request):
    return render(request, "myapp/payment_failed.html")


def myOrders(request):
    if request.user.is_authenticated:
        allord=Order.objects.filter(user=request.user)
        return render(request, 'myapp/viewOrders.html',{'orderItems':allord})
    else:
        return redirect('/login')
