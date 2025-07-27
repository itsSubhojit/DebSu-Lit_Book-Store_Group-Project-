import razorpay
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

def cart(request):
    return render(request, 'myapp/cart.html')

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

# def initiate_payment(request):
#     return HttpResponse('Hi')

def initiate_payment(request):
    if request.method == "POST":
        amount = int(request.POST["amount"]) * 100  # Amount in paise
        address=request.POST['address']
        client = razorpay.Client(auth=(settings.RAZORPAY_API_KEY, settings.RAZORPAY_API_SECRET))

        payment_data = {
            "amount": amount,
            "currency": "INR",
            "receipt": "order_receipt",
            "notes": {
                "email": "user_email@example.com",
            },
        }

        order = client.order.create(data=payment_data)
        
        # Include key, name, description, and image in the JSON response
        response_data = {
            "id": order["id"],
            "amount": order["amount"],
            "currency": order["currency"],
            "key": settings.RAZORPAY_API_KEY,
            "name": "My Project",
            "description": "Payment for Your Product",
            "image": "https://yourwebsite.com/logo.png",  # Replace with your logo URL
        }
        cart_items=CartItem.objects.filter(user=request.user)
        # payment_id=response_data.id
        for cart in cart_items:
            Order.objects.get_or_create(user=request.user, item= cart.item, quantity=cart.quantity, payment_status='success', address=address)
        
        CartItem.objects.filter(user=request.user).delete()

        return JsonResponse(response_data)
    return redirect('myapp:viewCart.html')

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
