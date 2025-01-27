import 'package:dio/dio.dart';

class ApiException {
  int? code;
  String? message;
  Response<dynamic>? response;
  ApiException(this.code, this.message, {this.response}) {
    // if (response == null) {
    //   message = 'خطا در برقراری ارتباط با سرور، دوباره تلاش کنید';
    // }

    if (code != 400) {
      return;
    }

    if (message == 'Failed to authenticate.') {
      message = 'نام کاربری و یا رمز عبور اشتباه است';
    }

    if (message == 'Failed to create record.') {
      if (response?.data['data']['username'] != null) {
        if (response?.data['data']['username']['message'] == 'The username is invalid or already in use.') {
          message = 'نام کاربری نامعتبر و یا قبلا استفاده شده است';
        }
      }
    }

    if (message == 'Failed to load the submitted data due to invalid formatting.' ||
        message == 'Failed to create record.') {
      message = 'از پر بودن تمامی فیلد ها اطمینان حاصل نمایید!';
    }
  }
}
