import 'package:aviz_app/data/model/sub_category.dart';
import 'package:flutter/material.dart';
import 'package:aviz_app/data/model/field.dart';

class Category {
  String? id;
  String? title;
  Icon? icon;
  List<SubCategory> subCategories;
  List<Field> fields;
  Category(this.id, this.title, this.icon, this.subCategories, this.fields);
}
