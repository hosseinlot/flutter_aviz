import 'package:aviz_app/constants/data_state.dart';
import 'package:aviz_app/data/datasource/aviz_datasource.dart';
import 'package:aviz_app/data/model/aviz.dart';
import 'package:aviz_app/data/model/field.dart';
import 'package:aviz_app/screens/add_aviz/aviz_data_temp.dart';
import 'package:aviz_app/utils/api_exception.dart';
import 'package:dio/dio.dart';

import '../../di.dart';

abstract class IAvizRepository {
  Future<DataState<List<Aviz>>> getHotAviz();
  Future<DataState<List<Aviz>>> getNormalAviz(int pageNumber);
  Future<DataState<List<Aviz>>> getAllAviz(int pageNumber);
  Future<DataState<List<Aviz>>> searchAviz(String enteredText);
  Future<void> toggleBookmark(String aviz_id);
  Future<DataState<String>> addAviz(String title, String category, String subCategory, MultipartFile? selectedThumbnail, List<Field> fields);
}

class AvizRepository extends IAvizRepository {
  final IAvizDatasource _datasource = locator.get();

  @override
  Future<DataState<List<Aviz>>> getHotAviz() async {
    try {
      Response response = await _datasource.getHotAviz();
      if (response.statusCode == 200) {
        List<Aviz> hotAvizList = response.data['items'].map<Aviz>((jsonObject) => Aviz.fromMapJson(jsonObject)).toList();
        return DataSuccess(hotAvizList);
      }
      return DataFailed('خطا در دریافت هات آویز');
    } on ApiException catch (ex) {
      return DataFailed(ex.message ?? 'خطا');
    }
  }

  @override
  Future<DataState<List<Aviz>>> getNormalAviz(int pageNumber) async {
    try {
      Response response = await _datasource.getNormalAviz(pageNumber);
      if (response.statusCode == 200) {
        List<Aviz> normalAvizList = response.data['items'].map<Aviz>((jsonObject) => Aviz.fromMapJson(jsonObject)).toList();
        return DataSuccess(normalAvizList);
      }
      return DataFailed('خطا در دریافت نرمال آویز');
    } on ApiException catch (ex) {
      return DataFailed(ex.message ?? 'خطا');
    }
  }

  @override
  Future<DataState<List<Aviz>>> searchAviz(String enteredText) async {
    try {
      Response response = await _datasource.searchAviz(enteredText);
      if (response.statusCode == 200) {
        return DataSuccess(response.data['items'].map<Aviz>((jsonObject) => Aviz.fromMapJson(jsonObject)).toList());
      } else {
        return DataFailed('خطا در جستجوی آویز');
      }
    } on ApiException catch (ex) {
      return DataFailed(ex.message ?? 'خطا');
    }
  }

  @override
  Future<void> toggleBookmark(String aviz_id) async {
    try {
      await _datasource.toggleBookmark(aviz_id);
    } on ApiException catch (error) {
      print(error);
    }
  }

  @override
  Future<DataState<String>> addAviz(String title, String category, String subCategory, MultipartFile? selectedThumbnail, List<Field> fields) async {
    try {
      Response response = await _datasource.addAviz(title, category, subCategory, selectedThumbnail, fields);

      if (response.statusCode == 200) {
        AvizDataTemp.reset();
        return DataSuccess('آگهی شما با موفقیت ثبت شد و پس از تایید نمایش داده خواهد شد');
      } else {
        return DataFailed('خطا در اضافه کردن آویز');
      }
    } on ApiException catch (ex) {
      return DataFailed(ex.message ?? 'خطا');
    }
  }

  @override
  Future<DataState<List<Aviz>>> getAllAviz(int pageNumber) async {
    try {
      Response response = await _datasource.getAllAviz(pageNumber);
      if (response.statusCode == 200) {
        List<Aviz> allAvizList = response.data['items'].map<Aviz>((jsonObject) => Aviz.fromMapJson(jsonObject)).toList();
        return DataSuccess(allAvizList);
      }
      return DataFailed('خطا در دریافت همه آویزها');
    } on ApiException catch (ex) {
      return DataFailed(ex.message ?? 'خطا');
    }
  }
}
