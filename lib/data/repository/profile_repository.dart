import 'package:aviz_app/constants/data_state.dart';
import 'package:aviz_app/data/datasource/profile_datasource.dart';
import 'package:aviz_app/data/model/aviz.dart';
import 'package:aviz_app/data/model/user.dart';
import 'package:aviz_app/utils/api_exception.dart';
import 'package:dio/dio.dart';

import '../../di.dart';

abstract class IProfileRepository {
  Future<DataState<User>> getUserInfo();
  Future<DataState<List<Aviz>>> getUserAviz();
  Future<DataState<List<Aviz>>> getUserBookmarks();
}

class ProfileRepository extends IProfileRepository {
  final IProfileDatasource _datasource = locator.get();

  @override
  Future<DataState<User>> getUserInfo() async {
    try {
      Response response = await _datasource.getUserInfo();
      if (response.statusCode == 200) {
        return DataSuccess(User.fromMapJson(response.data));
      } else {
        return DataFailed('خطا در دریافت اطلاعات کاربر');
      }
    } on ApiException catch (ex) {
      return DataFailed(ex.message ?? 'خطا');
    }
  }

  @override
  Future<DataState<List<Aviz>>> getUserAviz() async {
    try {
      Response response = await _datasource.getUserAviz();
      if (response.statusCode == 200) {
        return DataSuccess(response.data['items'].map<Aviz>((jsonObject) => Aviz.fromMapJson(jsonObject)).toList());
      } else {
        return DataFailed('خطا در دریافت اطلاعات');
      }
    } on ApiException catch (ex) {
      return DataFailed(ex.message ?? 'خطا');
    }
  }

  @override
  Future<DataState<List<Aviz>>> getUserBookmarks() async {
    try {
      List<Aviz> avizList = [];

      Response response = await _datasource.getUserBookmarks();

      if (response.data != null) {
        var bookmarkList = response.data['items'].map<Aviz>((jsonObject) => Aviz.fromMapJson(jsonObject)).toList();
        avizList.addAll(bookmarkList);
      }

      return DataSuccess(avizList);
    } on ApiException catch (ex) {
      return DataFailed(ex.message ?? 'خطا');
    }
  }
}
