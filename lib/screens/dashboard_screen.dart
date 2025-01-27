import 'package:app_links/app_links.dart';
import 'package:aviz_app/bloc/authentication/auth_bloc.dart';
import 'package:aviz_app/bloc/aviz/aviz_bloc.dart';
import 'package:aviz_app/bloc/category/category_bloc.dart';
import 'package:aviz_app/bloc/home/home_bloc.dart';
import 'package:aviz_app/bloc/home/home_event.dart';
import 'package:aviz_app/bloc/naviagtion/navigation_bloc.dart';
import 'package:aviz_app/bloc/naviagtion/navigation_state.dart';
import 'package:aviz_app/bloc/search/search_bloc.dart';
import 'package:aviz_app/constants/custom_colors.dart';
import 'package:aviz_app/screens/category_screen.dart';
import 'package:aviz_app/screens/home_screen.dart';
import 'package:aviz_app/screens/profile_screen.dart';
import 'package:aviz_app/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    final _appLinks = AppLinks();
    _appLinks.uriLinkStream.listen((uri) {
      var routeName = uri.pathSegments.first;
      var productId = uri.pathSegments.last;
      Navigator.pushNamed(context, '/${routeName}', arguments: productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: DashboardScreenContent(),
    );
  }
}

class DashboardScreenContent extends StatefulWidget {
  const DashboardScreenContent({super.key});

  @override
  State<DashboardScreenContent> createState() => _DashboardScreenContentState();
}

class _DashboardScreenContentState extends State<DashboardScreenContent> {
  int _selectedBottomNavigationIndex = 3;
  bool _isNavbarShown = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<NavigationBloc, NavigationState>(
        listener: (context, state) {
          if (state is NavigationbarVisibilityState) {
            setState(() {
              _isNavbarShown = state.visibility;
            });
          }
        },
        builder: (context, state) {
          return IndexedStack(
            index: _selectedBottomNavigationIndex,
            children: getScreens(),
          );
        },
      ),
      bottomNavigationBar: Visibility(
        visible: _isNavbarShown,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: CustomColors.grey100,
          selectedItemColor: CustomColors.red,
          unselectedItemColor: CustomColors.grey400,
          selectedLabelStyle: TextStyle(fontFamily: 'sb', fontSize: 14),
          unselectedLabelStyle: TextStyle(fontFamily: 'sb', fontSize: 14),
          currentIndex: _selectedBottomNavigationIndex,
          onTap: (int index) {
            setState(() {
              _selectedBottomNavigationIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Image.asset('assets/images/bottom-navigation-profile.png'),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Container(
                  child: Image.asset('assets/images/bottom-navigation-profile-active.png'),
                ),
              ),
              label: 'آویز من',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Image.asset('assets/images/bottom-navigation-add.png'),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Container(
                  child: Image.asset('assets/images/bottom-navigation-add-active.png'),
                ),
              ),
              label: 'افزودن آویز',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Image.asset('assets/images/bottom-navigation-search.png'),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Container(
                  child: Image.asset('assets/images/bottom-navigation-search-active.png'),
                ),
              ),
              label: 'جستجو',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Image.asset('assets/images/bottom-navigation-home.png'),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Container(
                  child: Image.asset('assets/images/bottom-navigation-home-active.png'),
                ),
              ),
              label: 'اگهی ها',
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getScreens() {
    return [
      BlocProvider(
        create: (context) => AuthBloc(),
        child: ProfileScreen(isActive: _selectedBottomNavigationIndex == 0),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CategoryBloc(),
          ),
          BlocProvider(
            create: (context) => AvizBloc(),
          ),
        ],
        child: CategoryScreen(isActive: _selectedBottomNavigationIndex == 1),
      ),
      BlocProvider(
        create: (context) => SearchBloc(),
        child: SearchScreen(isActive: _selectedBottomNavigationIndex == 2),
      ),
      BlocProvider(
        create: (context) {
          var bloc = HomeBloc();
          bloc.add(HomeGetInitializeDataEvent());
          return bloc;
        },
        child: HomeScreen(isActive: _selectedBottomNavigationIndex == 3),
      ),
    ];
  }
}
