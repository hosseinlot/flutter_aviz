import 'package:another_flushbar/flushbar.dart';
import 'package:aviz_app/bloc/authentication/auth_bloc.dart';
import 'package:aviz_app/bloc/authentication/auth_event.dart';
import 'package:aviz_app/bloc/authentication/auth_state.dart';
import 'package:aviz_app/constants/custom_colors.dart';
import 'package:aviz_app/screens/authentication/register_screen.dart';
import 'package:aviz_app/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key, required this.shouldRedirect});

  final bool shouldRedirect;
  final GlobalKey<FormState> _authenticationFormKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController(); //text: 'hossein1'
  final TextEditingController passwordController = TextEditingController(); //text: '123456'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BlocListener<AuthBloc, AuthState>(
                child: Container(),
                listener: (context, state) {
                  if (state is AuthSuccessState) {
                    String successReponse = state.response;
                    if (shouldRedirect) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => DashboardScreen(),
                        ),
                        (Route<dynamic> route) => route is LoginScreen,
                      );
                    }
                    _showSuccessSnackbar(successReponse, context);
                  }

                  if (state is AuthFailedState) {
                    String errorResponse = state.errorMessage;
                    _showErrorSnackbar(errorResponse, context);
                  }
                },
              ),
              // SizedBox(height: 76),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 64, height: 26, child: Image.asset('assets/images/aviz-logo.png')),
                  SizedBox(width: 8),
                  Text(
                    'ورود به ',
                    style: TextStyle(fontFamily: 'sb', fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'خوشحالیم که مجددا آویز رو برای آگهی انتخاب کردی!',
                textDirection: TextDirection.rtl,
                style: TextStyle(fontFamily: 'sm', fontSize: 14, color: CustomColors.grey500),
              ),
              Form(
                  key: _authenticationFormKey,
                  child: Column(
                    children: [
                      SizedBox(height: 32),
                      Container(
                        padding: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          controller: usernameController,
                          validator: (value) => value == '' ? '' : null,
                          textAlign: TextAlign.right,
                          style: TextStyle(fontFamily: 'sm', fontSize: 16),
                          decoration: InputDecoration(
                            hintText: 'نام کاربری',
                            hintStyle: TextStyle(fontFamily: 'sb', fontSize: 16, color: Colors.grey[400]),
                            border: InputBorder.none,
                            errorStyle: TextStyle(
                              color: Colors.transparent,
                              fontSize: 0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
                      Container(
                        padding: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          validator: (value) => value == '' ? '' : null,
                          textAlign: TextAlign.right,
                          style: TextStyle(fontFamily: 'sm', fontSize: 16),
                          decoration: InputDecoration(
                            hintText: 'رمز عبور',
                            hintStyle: TextStyle(fontFamily: 'sb', fontSize: 16, color: Colors.grey[400]),
                            border: InputBorder.none,
                            errorStyle: TextStyle(
                              color: Colors.transparent,
                              fontSize: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Spacer(),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  Widget widget;
                  if (state is AuthLoadingState) {
                    widget = SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white));
                  } else {
                    widget = Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/icon-arrow-left.png'),
                        SizedBox(width: 16),
                        Text(
                          'مرحله بعد',
                          style: TextStyle(fontFamily: 'sb', fontSize: 16, color: Colors.white),
                        ),
                      ],
                    );
                  }
                  return Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                      onPressed: () {
                        if (_authenticationFormKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(AuthLoginRequest(usernameController.text, passwordController.text));
                        } else {
                          _showFlashBar(context);
                        }
                      },
                      child: widget,
                    ),
                  );
                },
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => AuthBloc(),
                      child: RegisterScreen(),
                    ),
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ثبت نام',
                        style: TextStyle(
                          fontFamily: 'sb',
                          fontSize: 14,
                          color: CustomColors.red,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        'تاحالا ثبت نام نکردی؟ ',
                        style: TextStyle(
                          fontFamily: 'sb',
                          fontSize: 14,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Flushbar<dynamic> _showFlashBar(BuildContext context) {
    return Flushbar(
      backgroundColor: Colors.black,
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 80),
      borderRadius: BorderRadius.circular(5),
      duration: Duration(seconds: 2),
      messageText: Text('لطفا تمامی فیلد ها را پر کنید !', textDirection: TextDirection.rtl, style: TextStyle(fontFamily: 'sb', fontSize: 12, color: Colors.white)),
      icon: Icon(Icons.info_outline, size: 28.0, color: Colors.white),
      shouldIconPulse: false,
    )..show(context);
  }

  Flushbar<dynamic> _showErrorSnackbar(String errorResponse, BuildContext context) {
    return Flushbar(
      backgroundColor: Colors.black,
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 80),
      borderRadius: BorderRadius.circular(5),
      duration: Duration(seconds: 3),
      messageText: Text(errorResponse, textDirection: TextDirection.rtl, style: TextStyle(fontFamily: 'sb', fontSize: 12, color: Colors.white)),
      icon: Icon(Icons.info_outline, size: 28.0, color: Colors.white),
      shouldIconPulse: false,
    )..show(context);
  }

  _showSuccessSnackbar(String successReponse, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
            successReponse,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'sb', fontSize: 12, color: Colors.black54),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.greenAccent),
    );
  }
}
