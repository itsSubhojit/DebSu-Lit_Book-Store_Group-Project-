from django.contrib import admin
from django.utils.html import format_html
from . models import Category, Item


# Register your models here.
admin.site.site_header="DebSu Lit Administration"
admin.site.site_title="DebSu Lit"
admin.site.index_title="Administration Panel"



@admin.register(Category)
class categoryAdmin(admin.ModelAdmin):
    list_display=('cat_name', 'abt_cat')

@admin.register(Item)
class ItemAdmin(admin.ModelAdmin):
    def item_img(self, obj):
        return format_html('<img src="{}" width="100" height="100">'.format(obj.b_img.url))
    
    list_display=('name', 'price', 'item_img', 'category')

