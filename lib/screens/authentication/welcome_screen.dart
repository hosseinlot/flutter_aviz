import 'package:aviz_app/bloc/authentication/auth_bloc.dart';
import 'package:aviz_app/constants/custom_colors.dart';
import 'package:aviz_app/screens/authentication/login_screen.dart';
import 'package:aviz_app/screens/authentication/register_screen.dart';
import 'package:aviz_app/screens/dashboard_screen.dart';
import 'package:aviz_app/utils/settings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    SettingsManager.generateInitSettings();
  }

  final _slideController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 36),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => DashboardScreen(),
                      ));
                    },
                    child: Text(
                      'رد کردن',
                      style: TextStyle(fontFamily: 'Dana', fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              height: 500,
              child: PageView.builder(
                controller: _slideController,
                itemCount: 3,
                itemBuilder: (_, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          SizedBox(
                            height: 224,
                            child: Image.asset(
                              'assets/images/3d-home-background.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              width: 226,
                              height: 224,
                              child: Image.asset('assets/images/3d-home.png'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'آگهی شماست',
                            style: TextStyle(fontFamily: 'sb', fontSize: 16),
                          ),
                          SizedBox(width: 8),
                          SizedBox(width: 64, height: 26, child: Image.asset('assets/images/aviz-logo.png')),
                          SizedBox(width: 8),
                          Text(
                            'اینجا محل',
                            style: TextStyle(fontFamily: 'sb', fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 48),
                        child: Text(
                          'در آویز ملک خود را برای فروش،اجاره و رهن آگهی کنید و یا اگر دنبال ملک با مشخصات دلخواه خود هستید آویز ها را ببینید',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'sm',
                            fontSize: 14,
                            color: CustomColors.grey500,
                            height: 1.8,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Spacer(),
            SmoothPageIndicator(
              effect: ExpandingDotsEffect(
                dotWidth: 8,
                dotHeight: 8,
                activeDotColor: CustomColors.red,
                dotColor: CustomColors.grey300,
              ),
              controller: _slideController,
              count: 3,
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 159,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(width: 1, color: CustomColors.red))),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => AuthBloc(),
                              child: LoginScreen(shouldRedirect: true),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'ورود',
                        style: TextStyle(
                          fontFamily: 'sb',
                          fontSize: 16,
                          color: CustomColors.red,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 159,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => AuthBloc(),
                            child: RegisterScreen(),
                          ),
                        ));
                      },
                      child: Text(
                        'ثبت نام',
                        style: TextStyle(
                          fontFamily: 'sb',
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
