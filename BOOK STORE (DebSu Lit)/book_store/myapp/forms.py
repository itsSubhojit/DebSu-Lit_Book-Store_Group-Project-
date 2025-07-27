from django import forms
from django.contrib.auth.forms import UserCreationForm, UserChangeForm
from . models import CustomUser, Student


class MyRegFrm(UserCreationForm):
    class Meta:
        model=CustomUser
        fields=('username', 'first_name', 'last_name', 'email', 'mobile')

class StdRegFrm(forms.ModelForm):
    class Meta:
        model=Student
        fields=('name','email','mobile')
        
class MyChngFrm(UserChangeForm):
    password=None
    username=None
    first_name=forms.CharField(
        label=("First Name"),
        widget=forms.TextInput(attrs={'class':'form-control border-primary'})
    )
    last_name=forms.CharField(
        label=("Last Name"),
        widget=forms.TextInput(attrs={'class':'form-control border-primary'})
    )
    email=forms.CharField(
        label=("Email-ID"),
        widget=forms.EmailInput(attrs={'class':'form-control border-primary'})
    )
    mobile=forms.CharField(
        label=("Contact Number"),
        widget=forms.NumberInput(attrs={'class':'form-control border-primary'}))
    class Meta:
        model=CustomUser
        fields=('first_name', 'last_name', 'email', 'mobile')
