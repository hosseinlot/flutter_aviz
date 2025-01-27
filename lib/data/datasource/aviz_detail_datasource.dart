import 'package:aviz_app/data/model/bookmark.dart';
import 'package:aviz_app/di.dart';
import 'package:aviz_app/utils/api_exception.dart';
import 'package:aviz_app/utils/auth_manager.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IAvizDetailDatasource {
  Future<dynamic> getAvizDetail(String avizId);
  Future<dynamic> getVariants(String avizId);
  Future<dynamic> getAvizAuthorInfo(String avizId);
  Future<bool> isBookmarked(String aviz_id);
}

class AvizDetailDatasource extends IAvizDetailDatasource {
  final Dio _dio = locator.get();
  String user_id = AuthManager.getId();
  var BookmarkBox = Hive.box<Bookmark>('BookmarkBox');

  @override
  Future<dynamic> getAvizDetail(String avizId) async {
    try {
      var response = await _dio.get('collections/aviz/records/${avizId}');
      return response;
    } on DioException catch (error) {
      throw ApiException(error.response?.statusCode, error.response?.data['message']);
    } catch (error) {
      throw ApiException(0, 'unknow error');
    }
  }

  @override
  Future<dynamic> getVariants(String avizId) async {
    try {
      Map<String, String> qParams = {
        'filter': 'aviz_id="${avizId}"',
      };
      var response = await _dio.get('collections/variants/records', queryParameters: qParams);
      return response;
    } on DioException catch (error) {
      throw ApiException(error.response?.statusCode, error.response?.data['message']);
    } catch (error) {
      throw ApiException(0, 'unknow error');
    }
  }

  @override
  Future<dynamic> getAvizAuthorInfo(String avizId) async {
    try {
      var response = await _dio.get('collections/aviz/records/${avizId}?expand=user_id');
      return response;
    } on DioException catch (error) {
      throw ApiException(error.response?.statusCode, error.response?.data['message']);
    } catch (error) {
      throw ApiException(0, 'unknow error');
    }
  }

  @override
  Future<bool> isBookmarked(String aviz_id) async {
    var existingIndex = BookmarkBox.values.toList().indexWhere((existing) => existing.aviz_id == aviz_id);

    if (existingIndex == -1) {
      return false;
    } else {
      return true;
    }
  }
}
