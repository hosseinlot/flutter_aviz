import 'package:aviz_app/data/model/field.dart';
import 'package:dio/dio.dart';

abstract class AvizEvent {}

class AvizAddEvent extends AvizEvent {
  String title;
  String category;
  String subCategory;
  MultipartFile? selectedThumbnail;
  List<Field> fields;

  AvizAddEvent(
    this.title,
    this.category,
    this.subCategory,
    this.selectedThumbnail,
    this.fields,
  );
}
