import 'package:aviz_app/bloc/user/user_bloc.dart';
import 'package:aviz_app/bloc/user/user_event.dart';
import 'package:aviz_app/bloc/user/user_state.dart';
import 'package:aviz_app/constants/custom_colors.dart';
import 'package:aviz_app/screens/authentication/login_screen.dart';
import 'package:aviz_app/screens/profile/about_us_screen.dart';
import 'package:aviz_app/screens/profile/my_aviz_screen.dart';
import 'package:aviz_app/screens/profile/my_bookmark_screen.dart';
import 'package:aviz_app/screens/profile/my_payments_screen.dart';
import 'package:aviz_app/screens/profile/setting_screen.dart';
import 'package:aviz_app/utils/auth_manager.dart';
import 'package:aviz_app/utils/settings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.isActive});
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AuthManager.authChangeNotifier,
      builder: (context, value, child) {
        if (value == '' || value == null) {
          return LoginScreen(shouldRedirect: false);
        } else {
          return BlocProvider(
            create: (context) => UserBloc(),
            child: ProfileContentContainer(),
          );
        }
      },
    );
  }
}

class ProfileContentContainer extends StatefulWidget {
  const ProfileContentContainer({
    super.key,
  });

  @override
  State<ProfileContentContainer> createState() => _ProfileContentContainerState();
}

class _ProfileContentContainerState extends State<ProfileContentContainer> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(UserGetInfoEvent());
  }

  @override
  Widget build(BuildContext context) {
    final showPhoneNumber = SettingsManager.loadSettings()['showPhoneNumber'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'آویز من',
              style: TextStyle(
                fontFamily: 'sb',
                fontSize: 20,
                color: CustomColors.red,
              ),
            ),
            SizedBox(width: 6),
            SizedBox(
              width: 28,
              height: 28,
              child: Image.asset(
                'assets/images/aviz-logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserInfoLoading) {
            return Center(child: CircularProgressIndicator(color: CustomColors.red));
          } else if (state is UserInfoLoadSuccess) {
            var userInfo = state.userInfo;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'حساب کاربری',
                              style: TextStyle(
                                fontFamily: 'sb',
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 8),
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset('assets/images/icon-profile.png'),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Container(
                          width: double.infinity,
                          height: 94,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: CustomColors.grey300),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Image.asset('assets/images/icon-edit.png'),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    userInfo.name,
                                    style: TextStyle(
                                      fontFamily: 'sm',
                                      fontSize: 14,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 8),
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: CustomColors.red,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'تایید شده',
                                            style: TextStyle(
                                              fontFamily: 'sm',
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        // 'sad',
                                        showPhoneNumber ? userInfo.phoneNumber : '***********',
                                        style: TextStyle(
                                          fontFamily: 'sm',
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(width: 16),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox(
                                  width: 56,
                                  height: 56,
                                  child: Image.asset(
                                    'assets/images/profile-picture.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24),
                        Divider(
                          color: CustomColors.grey100,
                        ),
                        SizedBox(height: 24),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlocProvider(create: (context) => UserBloc(), child: MyAvizScreen())));
                            },
                            child: CustomRedButtonWithIcon(title: 'آگهی های من', imageUrl: 'assets/images/icon-myAviz.png')),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MyPaymentsScreen(),
                              ));
                            },
                            child: CustomRedButtonWithIcon(title: 'پرداخت های من', imageUrl: 'assets/images/icon-payment.png')),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => BlocProvider(create: (context) => UserBloc(), child: MyBookmarkScreen())),
                              );
                            },
                            child: CustomRedButtonWithIcon(title: 'نشان شده ها', imageUrl: 'assets/images/icon-saved.png')),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(
                                    MaterialPageRoute(builder: (context) => SettingScreen()),
                                  )
                                  .then((value) => setState(() {}));
                            },
                            child: CustomRedButtonWithIcon(title: 'تنظیمات', imageUrl: 'assets/images/icon-settings.png')),
                        CustomRedButtonWithIcon(title: 'پشتیبانی و قوانین', imageUrl: 'assets/images/icon-support.png'),
                        GestureDetector(
                            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AboutUsScreen())),
                            child: CustomRedButtonWithIcon(title: 'درباره آویز', imageUrl: 'assets/images/icon-info.png')),
                        GestureDetector(
                          onTap: () {
                            AuthManager.logout();
                            _showSuccessSnackbar('با موفقیت خارج شدید', context);
                          },
                          child: CustomRedButtonWithIcon(title: 'خروج از حساب کاربری', imageUrl: 'assets/images/icon-profile.png'),
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: [
                            Text('نسخه', style: TextStyle(fontFamily: 'sm', fontSize: 14, color: CustomColors.grey400)),
                            Text('۱.۵.۹', style: TextStyle(fontFamily: 'sm', fontSize: 14, color: CustomColors.grey400)),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is UserInfoLoadFailed) {
            var errorMessage = state.response;
            return Center(child: Text(errorMessage));
          } else {
            return Center(
              child: Text('eror'),
            );
          }
        },
      ),
    );
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

class CustomRedButtonWithIcon extends StatelessWidget {
  CustomRedButtonWithIcon({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  final String imageUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            'assets/images/icon-arrow-left.png',
            color: CustomColors.grey400,
          ),
          Spacer(),
          Text(
            title,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'sm',
            ),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 24,
            height: 24,
            child: Image.asset(imageUrl),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(width: 1, color: CustomColors.grey200),
      ),
    );
  }
}
