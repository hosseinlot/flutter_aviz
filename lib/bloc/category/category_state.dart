import 'package:aviz_app/data/model/category.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryState {}

class CategoryInitState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryResponseState extends CategoryState {
  CategoryResponseState(this.response);

  Either<String, List<Category>> response;
}
