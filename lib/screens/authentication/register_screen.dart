import 'package:another_flushbar/flushbar.dart';
import 'package:aviz_app/bloc/authentication/auth_bloc.dart';
import 'package:aviz_app/bloc/authentication/auth_event.dart';
import 'package:aviz_app/bloc/authentication/auth_state.dart';
import 'package:aviz_app/constants/custom_colors.dart';
import 'package:aviz_app/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController(); //text: 'hossein1'
  final TextEditingController _passwordController = TextEditingController(); //text: '123456'
  final TextEditingController _confirmPasswordController = TextEditingController(); //text: '123456'

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
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => DashboardScreen(),
                    ));
                  } else if (state is AuthFailedState) {
                    _showFlashBar(state.errorMessage, context);
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
                    'خوش اومدی به ',
                    style: TextStyle(
                      fontFamily: 'sb',
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'این فوق العادست که آویزو برای آگهی هات انتخاب کردی!',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: 'sm',
                  fontSize: 14,
                  color: CustomColors.grey500,
                ),
              ),
              SizedBox(height: 32),
              Container(
                padding: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  controller: _usernameController,
                  textAlign: TextAlign.right,
                  style: TextStyle(fontFamily: 'sm', fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'نام کاربری',
                    hintStyle: TextStyle(fontFamily: 'sb', fontSize: 16, color: Colors.grey[400]),
                    border: InputBorder.none,
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
                child: TextField(
                  controller: _passwordController,
                  textAlign: TextAlign.right,
                  style: TextStyle(fontFamily: 'sm', fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'رمز عبور',
                    hintStyle: TextStyle(fontFamily: 'sb', fontSize: 16, color: Colors.grey[400]),
                    border: InputBorder.none,
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
                child: TextField(
                  controller: _confirmPasswordController,
                  textAlign: TextAlign.right,
                  style: TextStyle(fontFamily: 'sm', fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'تکرار رمز عبور',
                    hintStyle: TextStyle(fontFamily: 'sb', fontSize: 16, color: Colors.grey[400]),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'رمز عبور باید بیشتر از 5 کاراکتر باشد  ',
                style: TextStyle(
                  fontFamily: 'Dana',
                  color: CustomColors.grey500,
                  fontSize: 14,
                ),
              ),
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
                        context.read<AuthBloc>().add(AuthRegisterRequest(_usernameController.text, _passwordController.text, _confirmPasswordController.text));
                      },
                      child: widget,
                    ),
                  );
                },
              ),
              SizedBox(height: 42)
            ],
          ),
        ),
      ),
    );
  }

  Flushbar<dynamic> _showFlashBar(String message, BuildContext context) {
    return Flushbar(
      backgroundColor: Colors.black,
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 80),
      borderRadius: BorderRadius.circular(5),
      duration: Duration(seconds: 2),
      messageText: Text(message, textDirection: TextDirection.rtl, style: TextStyle(fontFamily: 'sb', fontSize: 12, color: Colors.white)),
      icon: Icon(Icons.info_outline, size: 28.0, color: Colors.white),
      shouldIconPulse: false,
    )..show(context);
  }
}
