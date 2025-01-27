import 'package:aviz_app/data/model/bookmark.dart';
import 'package:aviz_app/data/model/field.dart';
import 'package:aviz_app/di.dart';
import 'package:aviz_app/utils/api_exception.dart';
import 'package:aviz_app/utils/auth_manager.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IAvizDatasource {
  Future<dynamic> getHotAviz();
  Future<dynamic> getNormalAviz(int pageNumber);
  Future<dynamic> getAllAviz(int pageNumber);
  Future<dynamic> searchAviz(String enteredText);
  Future<dynamic> addAviz(String title, String category, String subCategory, MultipartFile? selectedThumbnail, List<Field> fields);
  Future<void> toggleBookmark(String aviz_id);
}

class AvizRemoteDatasource extends IAvizDatasource {
  final Dio _dio = locator.get();
  String user_id = AuthManager.getId();
  var BookmarkBox = Hive.box<Bookmark>('BookmarkBox');

  @override
  Future<dynamic> getHotAviz() async {
    try {
      Map<String, dynamic> qParams = {
        'filter': 'isHot=true',
        'sort': '-created',
      };
      var response = await _dio.get('collections/aviz/records', queryParameters: qParams);
      return response;
    } on DioException catch (error) {
      throw ApiException(error.response?.statusCode, error.response?.data['message']);
    } catch (error) {
      throw ApiException(0, 'unknow error');
    }
  }

  @override
  Future<dynamic> getNormalAviz(int pageNumber) async {
    try {
      Map<String, dynamic> qParams = {
        'filter': 'isHot=false',
        'perPage': '5',
        'page': pageNumber,
        'sort': '-created',
      };
      var response = await _dio.get('collections/aviz/records', queryParameters: qParams);
      return response;
    } on DioException catch (error) {
      print(error);
      throw ApiException(error.response?.statusCode, error.response?.data['message']);
    } catch (error) {
      print(error);
      throw ApiException(0, 'unknow error');
    }
  }

  @override
  Future<dynamic> searchAviz(String enteredText) async {
    try {
      Map<String, dynamic> qParams = {
        'filter': 'title~"${enteredText}"',
        'sort': '-created',
      };
      var response = await _dio.get('collections/aviz/records', queryParameters: qParams);
      return response;
    } on DioException catch (error) {
      throw ApiException(error.response?.statusCode, error.response?.data['message']);
    } catch (error) {
      throw ApiException(0, 'unknow error');
    }
  }

  @override
  Future<dynamic> addAviz(String title, String category, String subCategory, MultipartFile? selectedThumbnail, List<Field> fields) async {
    FormData formData = FormData.fromMap({
      'user_id': user_id,
      'title': title,
      'category': category,
      'subCategory': subCategory,
      if (selectedThumbnail != null) 'thumbnail': selectedThumbnail,
    });

    try {
      var response = await _dio.post('collections/aviz/records', data: formData);
      var created_aviz_id = response.data['id'];
      await _dio.post('collections/variants/records', data: {
        'fields': fields,
        'aviz_id': created_aviz_id,
      });

      return response;
    } on DioException catch (error) {
      throw ApiException(error.response?.statusCode, error.response?.data['message']);
    } catch (error) {
      print(error);
      throw ApiException(0, 'unknow error');
    }
  }

  @override
  Future<void> toggleBookmark(String aviz_id) async {
    var existingIndex = BookmarkBox.values.toList().indexWhere((existing) => existing.aviz_id == aviz_id);

    if (existingIndex == -1) {
      BookmarkBox.add(Bookmark(aviz_id));
      try {
        await _dio.post('collections/bookmarks/records', data: {
          'aviz_id': aviz_id,
          'user_id': user_id,
        });
      } on DioException catch (error) {
        throw ApiException(error.response?.statusCode, error.response?.data['message']);
      } catch (error) {
        throw ApiException(0, 'unknow error');
      }
    } else {
      BookmarkBox.deleteAt(existingIndex);

      try {
        Map<String, dynamic> qParams = {
          'filter': 'aviz_id="${aviz_id}"&&user_id="${user_id}"',
        };
        var response = await _dio.get('collections/bookmarks/records', queryParameters: qParams);
        var existBookmarkId = response.data['items'][0]['id'];
        await _dio.delete('collections/bookmarks/records/${existBookmarkId}');
      } on DioException catch (error) {
        throw ApiException(error.response?.statusCode, error.response?.data['message']);
      } catch (error) {
        throw ApiException(0, 'unknow error');
      }
    }
  }

  @override
  Future getAllAviz(int pageNumber) async {
    try {
      Map<String, dynamic> qParams = {
        'perPage': '5',
        'page': pageNumber,
        'sort': '-created',
      };
      var response = await _dio.get('collections/aviz/records', queryParameters: qParams);
      return response;
    } on DioException catch (error) {
      print(error);
      throw ApiException(error.response?.statusCode, error.response?.data['message']);
    } catch (error) {
      print(error);
      throw ApiException(0, 'unknow error');
    }
  }
}
