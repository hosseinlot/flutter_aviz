import 'package:aviz_app/constants/data_state.dart';
import 'package:aviz_app/data/datasource/aviz_detail_datasource.dart';
import 'package:aviz_app/data/model/aviz.dart';
import 'package:aviz_app/data/model/variant.dart';
import 'package:aviz_app/utils/api_exception.dart';
import 'package:dio/dio.dart';

import '../../di.dart';

abstract class IAvizDetailRepository {
  Future<DataState<Aviz>> getAvizDetail(String avizId);
  Future<DataState<List<Variant>>> getAvizVariants(String avizId);
  Future<DataState<String>> getAvizAuthorInfo(String avizId);
  Future<DataState<bool>> isBookmarked(String avizId);
}

class AvizDetailRepository extends IAvizDetailRepository {
  final IAvizDetailDatasource _datasource = locator.get();

  @override
  Future<DataState<Aviz>> getAvizDetail(String avizId) async {
    try {
      Response response = await _datasource.getAvizDetail(avizId);
      if (response.statusCode == 200) {
        Aviz aviz = Aviz.fromMapJson(response.data);
        return DataSuccess(aviz);
      } else {
        return DataFailed('chap error by DataState');
      }
    } on ApiException catch (error) {
      return DataFailed(error.message!);
    }
  }

  @override
  Future<DataState<List<Variant>>> getAvizVariants(String avizId) async {
    try {
      Response response = await _datasource.getVariants(avizId);
      if (response.statusCode == 200 && response.data['totalItems'] != 0) {
        List<Variant> variantList = response.data['items'][0]['fields'].map<Variant>((jsonObject) => Variant.fromMapJson(jsonObject)).toList();
        return DataSuccess(variantList);
      } else {
        return DataFailed('chap error by DataState');
      }
    } on ApiException catch (error) {
      return DataFailed(error.message!);
    }
  }

  @override
  Future<DataState<String>> getAvizAuthorInfo(String avizId) async {
    try {
      Response response = await _datasource.getAvizAuthorInfo(avizId);
      if (response.statusCode == 200) {
        String phoneNumber = response.data['expand']['user_id']['phoneNumber'];
        return DataSuccess(phoneNumber);
      } else {
        return DataFailed('chap error by DataState');
      }
    } on ApiException catch (error) {
      return DataFailed(error.message!);
    }
  }

  @override
  Future<DataState<bool>> isBookmarked(String avizId) async {
    try {
      bool response = await _datasource.isBookmarked(avizId);
      return DataSuccess(response);
    } on ApiException catch (ex) {
      return DataFailed(ex.message ?? 'خطا');
    }
  }
}
