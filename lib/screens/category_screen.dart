import 'package:aviz_app/bloc/authentication/auth_bloc.dart';
import 'package:aviz_app/bloc/naviagtion/navigation_bloc.dart';
import 'package:aviz_app/bloc/naviagtion/navigation_event.dart';
import 'package:aviz_app/bloc/naviagtion/navigation_state.dart';
import 'package:aviz_app/constants/custom_colors.dart';
import 'package:aviz_app/screens/add_aviz/category_items.dart';
import 'package:aviz_app/screens/add_aviz/finilize_items.dart';
import 'package:aviz_app/screens/add_aviz/location_items.dart';
import 'package:aviz_app/screens/add_aviz/property_items.dart';
import 'package:aviz_app/screens/add_aviz/sub_category_items.dart';
import 'package:aviz_app/screens/authentication/login_screen.dart';
import 'package:aviz_app/utils/auth_manager.dart';
import 'package:aviz_app/widgets/custom_widgets/appbar_buttom_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.isActive});
  final bool isActive;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

double _leanierProgressIndicator = 0;

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return CategoryContentContainer();
    // return ValueListenableBuilder(
    //   valueListenable: AuthManager.authChangeNotifier,
    //   builder: (context, value, child) {
    //     if (value == '' || value == null) {
    //       // return LoginScreen(shouldRedirect: false);
    //       return Scaffold(
    //         backgroundColor: Colors.white,
    //         body: SafeArea(
    //           child: Center(
    //             child: Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 16),
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Text(
    //                     'برای شروع و استفاده از این امکانات لازم است ابتدا وارد حساب کاربری خود شوید.',
    //                     textDirection: TextDirection.rtl,
    //                     style: TextStyle(
    //                       fontFamily: 'dana',
    //                       fontSize: 16,
    //                     ),
    //                   ),
    //                   SizedBox(height: 32),
    //                   SizedBox(
    //                     width: 159,
    //                     height: 40,
    //                     child: ElevatedButton(
    //                       style: ElevatedButton.styleFrom(
    //                           backgroundColor: Colors.white,
    //                           shape: RoundedRectangleBorder(
    //                               borderRadius: BorderRadius.circular(5),
    //                               side: BorderSide(width: 1, color: CustomColors.red))),
    //                       onPressed: () {
    //                         Navigator.of(context).pushReplacement(MaterialPageRoute(
    //                           builder: (context) => LoginScreen(shouldRedirect: true),
    //                         ));
    //                       },
    //                       child: Text(
    //                         'ورود',
    //                         style: TextStyle(
    //                           fontFamily: 'sb',
    //                           fontSize: 16,
    //                           color: CustomColors.red,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       );
    //     } else {
    //       return CategoryContentContainer();
    //     }
    //   },
    // );
  }
}

class CategoryContentContainer extends StatefulWidget {
  const CategoryContentContainer({super.key});

  @override
  State<CategoryContentContainer> createState() => _CategoryContentContainerState();
}

class _CategoryContentContainerState extends State<CategoryContentContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'دسته بندی آویز',
              style: TextStyle(
                fontFamily: 'sb',
                fontSize: 20,
                color: CustomColors.red,
              ),
            ),
          ],
        ),
        actions: [
          _leanierProgressIndicator != 0
              ? GestureDetector(
                  onTap: () {
                    context.read<NavigationBloc>().add(navigateToPreviousPageEvent());
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset('assets/images/icon-appbar-arrow-right.png'),
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox(),
        ],
        leading: _leanierProgressIndicator != 0
            ? GestureDetector(
                onTap: () {
                  context.read<NavigationBloc>().add(NavigationToCategoryEvent());
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: Image.asset('assets/images/icon-appbar-x.png'),
                      ),
                    ),
                  ],
                ),
              )
            : null,
        bottom: PreferredSize(
          preferredSize: Size(0, 10),
          child: AppbarBottomIndicator(
            leanierProgressIndicator: _leanierProgressIndicator,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: AuthManager.authChangeNotifier,
          builder: (context, value, child) {
            if (value == '' || value == null) {
              // return LoginScreen(shouldRedirect: false);
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'برای شروع و استفاده از این امکانات لازم است ابتدا وارد حساب کاربری خود شوید. اگر هنوز حساب کاربری نساخته اید لطفا یکی بسازید',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          height: 2,
                          fontFamily: 'dana',
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 32),
                      SizedBox(
                        width: 159,
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColors.red,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => AuthBloc(),
                                child: LoginScreen(shouldRedirect: true),
                              ),
                            ));
                          },
                          child: Text(
                            'ورود',
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
                ),
              );
            } else {
              return BlocConsumer<NavigationBloc, NavigationState>(
                listener: (context, state) {
                  if (state is NavigationIndicatorUpdateState) {
                    setState(() {
                      _leanierProgressIndicator = state.pageNumber;
                    });
                  }
                },
                builder: (context, state) {
                  if (state is NavigationInCategoryState) {
                    return CategoryItems();
                  } else if (state is NavigationInSubCategoryState) {
                    return SubCategoryItems();
                  } else if (state is NavigationInPropertyCategoryState) {
                    return PropertyItems();
                  } else if (state is NavigationInLocationSelectState) {
                    return LocationItems();
                  } else if (state is NavigationInFinilizeAdState) {
                    return FinilizeItems();
                  } else {
                    return SliverToBoxAdapter(
                      child: Text('خطا در دریافت اطلاعات'),
                    );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
