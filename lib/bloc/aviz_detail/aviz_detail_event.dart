import 'package:aviz_app/data/model/field.dart';
import 'package:dio/dio.dart';

abstract class AvizDetailEvent {}

class AvizGetDetailEvent extends AvizDetailEvent {
  String avizId;
  AvizGetDetailEvent(this.avizId);
}

class AvizGetAuthorDetailEvent extends AvizDetailEvent {
  String avizId;
  AvizGetAuthorDetailEvent(this.avizId);
}

class AvizGetBookmarkDetailEvent extends AvizDetailEvent {
  String avizId;
  AvizGetBookmarkDetailEvent(this.avizId);
}

class AvizAddEvent extends AvizDetailEvent {
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
