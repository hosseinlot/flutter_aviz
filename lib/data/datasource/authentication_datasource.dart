import 'package:aviz_app/di.dart';
import 'package:aviz_app/utils/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IAuthDatasource {
  Future<dynamic> register(String username, String password, String passwordConfirm);
  Future<dynamic> login(String username, String password);
  Future<dynamic> getBookmarks(dynamic response);
}

class AuthenticationRemote extends IAuthDatasource {
  final Dio _dio = locator.get();

  @override
  Future<dynamic> register(String username, String password, String passwordConfirm) async {
    try {
      final response = await _dio.post('collections/users/records', data: {
        'username': username,
        'password': password,
        'passwordConfirm': passwordConfirm,
      });
      return response;

      // auto login after register
    } on DioException catch (error) {
      throw ApiException(error.response?.statusCode, error.response?.data['message'], response: error.response);
    } catch (error) {
      throw ApiException(0, 'unknow error');
    }
  }

  @override
  Future<dynamic> login(String username, String password) async {
    try {
      final response = await _dio.post('collections/users/auth-with-password', data: {
        'identity': username,
        'password': password,
      });

      return response;
    } on DioException catch (error) {
      throw ApiException(error.response?.statusCode, error.response?.data['message']);
    } catch (error) {
      throw ApiException(0, 'unknow error');
    }
  }

  @override
  Future<dynamic> getBookmarks(dynamic response) async {
    try {
      Map<String, dynamic> qParams = {
        'filter': 'user_id="${response.data['record']['id']}"',
        'sort': '-created',
      };
      return await _dio.get('collections/bookmarks/records', queryParameters: qParams);
    } on DioException catch (error) {
      throw ApiException(error.response?.statusCode, error.response?.data['message']);
    } catch (error) {
      throw ApiException(0, 'unknow error');
    }
  }
}
