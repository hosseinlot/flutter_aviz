import 'package:aviz_app/data/model/category.dart';
import 'package:aviz_app/data/model/field.dart';
import 'package:aviz_app/data/model/sub_category.dart';
import 'package:dio/dio.dart';

class AvizDataTemp {
  static Category? selectedCategory;
  static SubCategory? selectedSubCategory;
  static List<Field> selectedFields = [];
  static MultipartFile? selectedThumbnail;

  static void reset() {
    selectedCategory = null;
    selectedSubCategory = null;
    selectedFields = [];
    selectedThumbnail = null;
  }
}
