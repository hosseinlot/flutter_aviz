import 'package:flutter/material.dart';
import 'package:aviz_app/data/model/category.dart';
import 'package:aviz_app/data/model/field.dart';
import 'package:aviz_app/data/model/sub_category.dart';

abstract class ICategoryDatasource {
  Future<List<Category>> getCategories();
}

class CategoryLocalDatasource extends ICategoryDatasource {
  @override
  Future<List<Category>> getCategories() async {
    var categoryList = [
      Category(
        '1',
        'املاک',
        Icon(Icons.home_outlined),
        [
          SubCategory('1', '1', 'اجاره مسکونی'),
          SubCategory('1', '2', 'فروش مسکونی'),
          SubCategory('1', '4', 'فروش اداری و تجاری'),
          SubCategory('1', '5', 'اجاره اداری و تجاری'),
          SubCategory('1', '6', 'پروژه‌های ساخت و ساز'),
        ],
        [
          Field('قیمت کل', 0, FieldTypeEnum.GHEYMAT, FieldInputTypeEnum.NUMBER),
          Field('قیمت هر متر', 0, FieldTypeEnum.GHEYMAT, FieldInputTypeEnum.NUMBER),
          Field('متراژ', 350, FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.NUMBER),
          Field('اتاق', 2, FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.NUMBER),
          Field('طبقه', 3, FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.NUMBER),
          Field('ساخت', 1402, FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.NUMBER),
          Field('سند', 'تک برگ', FieldTypeEnum.VIZHEGI, FieldInputTypeEnum.TEXT),
          Field('جهت ساختمان', 'شمال غربی', FieldTypeEnum.VIZHEGI, FieldInputTypeEnum.TEXT),
          Field('آسانسور', true, FieldTypeEnum.EMKANAT, FieldInputTypeEnum.CHECKBOX),
          Field('پارکینگ', false, FieldTypeEnum.EMKANAT, FieldInputTypeEnum.CHECKBOX),
          Field('انباری', true, FieldTypeEnum.EMKANAT, FieldInputTypeEnum.CHECKBOX),
        ],
      ),
      Category(
        '2',
        'وسایل نقلیه',
        Icon(Icons.car_crash_outlined),
        [
          SubCategory('2', '7', 'سواری و وانت'),
          SubCategory('2', '8', 'کلاسیک'),
          SubCategory('2', '9', 'اجاره‌ای'),
          SubCategory('2', '10', 'سنگین'),
        ],
        [
          Field('قیمت', 0, FieldTypeEnum.GHEYMAT, FieldInputTypeEnum.NUMBER),
          Field('برند خودرو', 'پژو پارس سال', FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.TEXT),
          Field('تیپ', 4, FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.NUMBER),
          Field('کارکرد', 76000, FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.NUMBER),
          Field('مدل', 1402, FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.NUMBER),
          Field('رنگ', 'سفید', FieldTypeEnum.VIZHEGI, FieldInputTypeEnum.TEXT),
          Field('شاسی سالم', true, FieldTypeEnum.EMKANAT, FieldInputTypeEnum.CHECKBOX),
          Field('شیشه های دودی', false, FieldTypeEnum.EMKANAT, FieldInputTypeEnum.CHECKBOX),
          Field('سیستم موسیقی', false, FieldTypeEnum.EMKANAT, FieldInputTypeEnum.CHECKBOX),
          Field('دارای خلافی', false, FieldTypeEnum.EMKANAT, FieldInputTypeEnum.CHECKBOX),
          Field('تایر یدکی', true, FieldTypeEnum.EMKANAT, FieldInputTypeEnum.CHECKBOX),
        ],
      ),
      Category(
        '3',
        'کالای دیجیتال',
        Icon(Icons.laptop),
        [
          SubCategory('1', '1', 'اجاره مسکونی'),
          SubCategory('1', '2', 'فروش مسکونی'),
          SubCategory('1', '4', 'فروش اداری و تجاری'),
          SubCategory('1', '5', 'اجاره اداری و تجاری'),
          SubCategory('1', '6', 'پروژه‌های ساخت و ساز'),
        ],
        [
          Field('قیمت کل', 0, FieldTypeEnum.GHEYMAT, FieldInputTypeEnum.NUMBER),
          Field('قیمت هر متر', 0, FieldTypeEnum.GHEYMAT, FieldInputTypeEnum.NUMBER),
          Field('متراژ', 350, FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.NUMBER),
          Field('اتاق', 2, FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.NUMBER),
          Field('طبقه', 3, FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.NUMBER),
          Field('ساخت', 1402, FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.NUMBER),
          Field('سند', 'تک برگ', FieldTypeEnum.VIZHEGI, FieldInputTypeEnum.TEXT),
          Field('جهت ساختمان', 'شمال غربی', FieldTypeEnum.VIZHEGI, FieldInputTypeEnum.TEXT),
          Field('آسانسور', true, FieldTypeEnum.EMKANAT, FieldInputTypeEnum.CHECKBOX),
          Field('پارکینگ', false, FieldTypeEnum.EMKANAT, FieldInputTypeEnum.CHECKBOX),
          Field('انباری', true, FieldTypeEnum.EMKANAT, FieldInputTypeEnum.CHECKBOX),
        ],
      ),
      Category(
        '4',
        'خانه و آشپزخانه',
        Icon(Icons.soup_kitchen),
        [
          SubCategory('1', '1', 'اجاره مسکونی'),
          SubCategory('1', '2', 'فروش مسکونی'),
          SubCategory('1', '4', 'فروش اداری و تجاری'),
          SubCategory('1', '5', 'اجاره اداری و تجاری'),
          SubCategory('1', '6', 'پروژه‌های ساخت و ساز'),
        ],
        [
          Field('قیمت کل', 0, FieldTypeEnum.GHEYMAT, FieldInputTypeEnum.NUMBER),
          Field('قیمت هر متر', 0, FieldTypeEnum.GHEYMAT, FieldInputTypeEnum.NUMBER),
          Field('متراژ', 350, FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.NUMBER),
          Field('اتاق', 2, FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.NUMBER),
          Field('طبقه', 3, FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.NUMBER),
          Field('ساخت', 1402, FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.NUMBER),
          Field('سند', 'تک برگ', FieldTypeEnum.VIZHEGI, FieldInputTypeEnum.TEXT),
          Field('جهت ساختمان', 'شمال غربی', FieldTypeEnum.VIZHEGI, FieldInputTypeEnum.TEXT),
          Field('آسانسور', true, FieldTypeEnum.EMKANAT, FieldInputTypeEnum.CHECKBOX),
          Field('پارکینگ', false, FieldTypeEnum.EMKANAT, FieldInputTypeEnum.CHECKBOX),
          Field('انباری', true, FieldTypeEnum.EMKANAT, FieldInputTypeEnum.CHECKBOX),
        ],
      ),
      Category(
        '5',
        'خدمات',
        Icon(Icons.room_service),
        [
          SubCategory('1', '1', 'اجاره مسکونی'),
          SubCategory('1', '2', 'فروش مسکونی'),
          SubCategory('1', '4', 'فروش اداری و تجاری'),
          SubCategory('1', '5', 'اجاره اداری و تجاری'),
          SubCategory('1', '6', 'پروژه‌های ساخت و ساز'),
        ],
        [
          Field('قیمت کل', 0, FieldTypeEnum.GHEYMAT, FieldInputTypeEnum.NUMBER),
          Field('قیمت هر متر', 0, FieldTypeEnum.GHEYMAT, FieldInputTypeEnum.NUMBER),
          Field('متراژ', 350, FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.NUMBER),
          Field('اتاق', 2, FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.NUMBER),
          Field('طبقه', 3, FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.NUMBER),
          Field('ساخت', 1402, FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.NUMBER),
          Field('سند', 'تک برگ', FieldTypeEnum.VIZHEGI, FieldInputTypeEnum.TEXT),
          Field('جهت ساختمان', 'شمال غربی', FieldTypeEnum.VIZHEGI, FieldInputTypeEnum.TEXT),
          Field('آسانسور', true, FieldTypeEnum.EMKANAT, FieldInputTypeEnum.CHECKBOX),
          Field('پارکینگ', false, FieldTypeEnum.EMKANAT, FieldInputTypeEnum.CHECKBOX),
          Field('انباری', true, FieldTypeEnum.EMKANAT, FieldInputTypeEnum.CHECKBOX),
        ],
      ),
      Category(
        '6',
        'وسایل شخصی',
        Icon(Icons.personal_injury),
        [
          SubCategory('1', '1', 'اجاره مسکونی'),
          SubCategory('1', '2', 'فروش مسکونی'),
          SubCategory('1', '4', 'فروش اداری و تجاری'),
          SubCategory('1', '5', 'اجاره اداری و تجاری'),
          SubCategory('1', '6', 'پروژه‌های ساخت و ساز'),
        ],
        [
          Field('قیمت کل', 0, FieldTypeEnum.GHEYMAT, FieldInputTypeEnum.NUMBER),
          Field('قیمت هر متر', 0, FieldTypeEnum.GHEYMAT, FieldInputTypeEnum.NUMBER),
          Field('متراژ', 350, FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.NUMBER),
          Field('اتاق', 2, FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.NUMBER),
          Field('طبقه', 3, FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.NUMBER),
          Field('ساخت', 1402, FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.NUMBER),
          Field('سند', 'تک برگ', FieldTypeEnum.VIZHEGI, FieldInputTypeEnum.TEXT),
          Field('جهت ساختمان', 'شمال غربی', FieldTypeEnum.VIZHEGI, FieldInputTypeEnum.TEXT),
          Field('آسانسور', true, FieldTypeEnum.EMKANAT, FieldInputTypeEnum.CHECKBOX),
          Field('پارکینگ', false, FieldTypeEnum.EMKANAT, FieldInputTypeEnum.CHECKBOX),
          Field('انباری', true, FieldTypeEnum.EMKANAT, FieldInputTypeEnum.CHECKBOX),
        ],
      ),
      Category(
        '7',
        'سرگرمی و فراغت',
        Icon(Icons.movie),
        [
          SubCategory('1', '1', 'اجاره مسکونی'),
          SubCategory('1', '2', 'فروش مسکونی'),
          SubCategory('1', '4', 'فروش اداری و تجاری'),
          SubCategory('1', '5', 'اجاره اداری و تجاری'),
          SubCategory('1', '6', 'پروژه‌های ساخت و ساز'),
        ],
        [
          Field('قیمت کل', 0, FieldTypeEnum.GHEYMAT, FieldInputTypeEnum.NUMBER),
          Field('قیمت هر متر', 0, FieldTypeEnum.GHEYMAT, FieldInputTypeEnum.NUMBER),
          Field('متراژ', 350, FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.NUMBER),
          Field('اتاق', 2, FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.NUMBER),
          Field('طبقه', 3, FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.NUMBER),
          Field('ساخت', 1402, FieldTypeEnum.MOSHAKHASAT, FieldInputTypeEnum.NUMBER),
          Field('سند', 'تک برگ', FieldTypeEnum.VIZHEGI, FieldInputTypeEnum.TEXT),
          Field('جهت ساختمان', 'شمال غربی', FieldTypeEnum.VIZHEGI, FieldInputTypeEnum.TEXT),
          Field('آسانسور', true, FieldTypeEnum.EMKANAT, FieldInputTypeEnum.CHECKBOX),
          Field('پارکینگ', false, FieldTypeEnum.EMKANAT, FieldInputTypeEnum.CHECKBOX),
          Field('انباری', true, FieldTypeEnum.EMKANAT, FieldInputTypeEnum.CHECKBOX),
        ],
      ),
      // Category('7', 'سرگرمی و فراغت'),
    ];
    return categoryList;
  }
}
