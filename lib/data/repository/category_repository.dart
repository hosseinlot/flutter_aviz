import 'package:aviz_app/data/datasource/category_datasource.dart';
import 'package:aviz_app/data/model/category.dart';
// import 'package:aviz_app/data/model/sub_category.dart';
import 'package:aviz_app/utils/api_exception.dart';
import 'package:aviz_app/di.dart';
import 'package:dartz/dartz.dart';

abstract class ICategoryRepository {
  Future<Either<String, List<Category>>> getCategories();
  // Future<Either<String, List<SubCategory>>> getSubCategories(String categoryId);
}

class CategoryRepository extends ICategoryRepository {
  final ICategoryDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<Category>>> getCategories() async {
    try {
      var response = await _datasource.getCategories();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا');
    }
  }

  // @override
  // Future<Either<String, List<SubCategory>>> getSubCategories(String categoryId) async {
  //   try {
  //     var response = await _datasource.getSubCategories(categoryId);
  //     return right(response);
  //   } on ApiException catch (ex) {
  //     return left(ex.message ?? 'خطا');
  //   }
  // }
}
