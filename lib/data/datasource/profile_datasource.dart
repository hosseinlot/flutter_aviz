import 'package:aviz_app/data/model/bookmark.dart';
import 'package:aviz_app/di.dart';
import 'package:aviz_app/utils/api_exception.dart';
import 'package:aviz_app/utils/auth_manager.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IProfileDatasource {
  Future<dynamic> getUserInfo();
  Future<dynamic> getUserAviz();
  Future<dynamic>? getUserBookmarks();
}

class ProfileDatasource extends IProfileDatasource {
  final Dio _dio = locator.get();
  String user_id = AuthManager.getId();
  var BookmarkBox = Hive.box<Bookmark>('BookmarkBox');

  @override
  Future<dynamic> getUserInfo() async {
    try {
      var response = await _dio.get('collections/users/records/${user_id}');
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
  Future<dynamic> getUserAviz() async {
    try {
      Map<String, dynamic> qParams = {
        'filter': 'user_id="${user_id}"',
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
  Future<dynamic>? getUserBookmarks() async {
    try {
      var bookmarkList = BookmarkBox.values.toList();
      var filterString = "";

      if (bookmarkList.isNotEmpty) {
        for (var i = 0; i < bookmarkList.length; i++) {
          filterString += 'id="${bookmarkList[i].aviz_id}"';
          if (i < bookmarkList.length - 1) {
            filterString += "||";
          }
        }
        Map<String, dynamic> qNewParams = {
          'filter': '${filterString}',
        };
        var response = await _dio.get('collections/aviz/records/', queryParameters: qNewParams);
        return response;
      }
      return null;
    } on DioException catch (error) {
      print(error);
      throw ApiException(error.response?.statusCode, error.response?.data['message']);
    } catch (error) {
      print(error);
      throw ApiException(0, 'unknow error');
    }
  }
}
