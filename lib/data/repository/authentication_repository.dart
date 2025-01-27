import 'package:aviz_app/constants/data_state.dart';
import 'package:aviz_app/data/datasource/authentication_datasource.dart';
import 'package:aviz_app/di.dart';
import 'package:aviz_app/utils/api_exception.dart';
import 'package:aviz_app/utils/auth_manager.dart';
import 'package:dio/dio.dart';

abstract class IAuthRepository {
  Future<DataState<String>> register(String username, String password, String confirmPassword);
  Future<DataState<String>> login(String username, String password);
}

class AuthenticationRepository extends IAuthRepository {
  final IAuthDatasource _datasoue = locator.get();

  @override
  Future<DataState<String>> register(String username, String password, String confirmPassword) async {
    try {
      Response response = await _datasoue.register(username, password, confirmPassword);
      if (response.statusCode == 200) {
        login(username, password);
        return DataSuccess('ثبت نام موفق آمیز بود');
      } else {
        return DataFailed('حطایی در ثبت نام پیش آمد');
      }
    } on ApiException catch (error) {
      return DataFailed(error.message ?? 'خطا محتوا ندارد');
    }
  }

  @override
  Future<DataState<String>> login(String username, String password) async {
    try {
      Response response = await _datasoue.login(username, password);
      Response bookmarkResponse = await _datasoue.getBookmarks(response);
      var bookmarkList = bookmarkResponse.data['items'];

      if (response.statusCode == 200) {
        AuthManager.saveId(response.data['record']['id'], response.data['record']['name'], response.data['record']['phoneNumber']);
        AuthManager.saveToken(response.data?['token']);
        AuthManager.saveBookmarks(bookmarkList);

        return DataSuccess('با موفقیت به حساب کاربری ورود کردید');
      }
      return DataFailed('در ورود به حساب مشکلی پیش آمد');
    } on ApiException catch (error) {
      return DataFailed(error.message ?? 'خطا محتوا ندارد');
    }
  }
}
