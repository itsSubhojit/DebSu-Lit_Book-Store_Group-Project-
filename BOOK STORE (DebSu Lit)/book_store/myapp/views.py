import time
import razorpay
import razorpay.errors
from django.conf import settings
from django.http import JsonResponse
from django.shortcuts import render, redirect
from django.contrib import messages
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth import authenticate, login, logout
from . forms import MyRegFrm, StdRegFrm, MyChngFrm
from . models import Student, Category, Item, CartItem, Order
from django.http import HttpResponse


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
    allItem=Item.objects.all()
    if request.user.is_authenticated:
        if request.POST:
            form = MyChngFrm(request.POST, instance=request.user)
            if form.is_valid():
                try:
                    form.save()
                    messages.success(request,'Profile Update successfully')
                except Exception as e:
                    messages.error(request, 'Profile Could Not Update successfully')
        else:
            form=MyChngFrm(instance=request.user)
        return render(request, 'myapp/useraccount.html', {'form':form, 'allItem':allItem, 'categories':categories})
    else:
        return redirect('/login')


def signIn(request):
    if request.user.is_authenticated:
        return redirect('/useraccount')
    else:
        if request.POST:
            form=AuthenticationForm(request=request, data=request.POST)
            if form.is_valid():
                uname=form.cleaned_data['username']
                upass=form.cleaned_data['password']
                user=authenticate(username=uname, password=upass)
                if user is not None:
                    login(request, user)
                    return redirect('/useraccount')
        else:
            form=AuthenticationForm()
        context={"form":form}
        return render(request, 'myapp/login.html', context)

def signOut(request):
    logout(request)
    return redirect('/login')


def signup(request):
    if request.POST:
        form=MyRegFrm(data=request.POST)
        if form.is_valid:
            try:
                form.save()
                messages.success(request, 'Your registration is succesfull')
            except Exception as e:
                messages.error(request, 'Your registration is not successfull')
    else:
        form=MyRegFrm()
    context={'frm':form}
    return render(request, 'myapp/signup.html', context)

def forgotpassword(request):
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
        except Exception as e:
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
          total_price=int(total_price)
          return render(request, 'myapp/cart.html', {'cart_items': cart_items, 'total_price': total_price})
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

        cart_items = CartItem.objects.filter(user=request.user)
        if not cart_items.exists():
            return JsonResponse({"error": "Your cart is empty."}, status=400)

        # Secure server-side calculation: never trust client-submitted amount
        total_price = sum(int(item.item.price) * int(item.quantity) for item in cart_items)
        if total_price <= 0:
            return JsonResponse({"error": "Invalid order amount."}, status=400)

        amount_in_paise = int(total_price * 100)

        if not settings.RAZORPAY_API_KEY or not settings.RAZORPAY_API_SECRET:
            return JsonResponse({"error": "Razorpay payment keys are not configured. Please set them in your .env file."}, status=500)

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
            return JsonResponse({"error": f"Failed to initiate order with Razorpay: {str(e)}"}, status=500)

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
        except razorpay.errors.SignatureVerificationError:
            return JsonResponse({"status": "failure", "message": "Payment signature verification failed."}, status=400)
        except Exception as e:
            return JsonResponse({"status": "failure", "message": f"Verification error: {str(e)}"}, status=400)

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
