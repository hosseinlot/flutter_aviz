import 'package:aviz_app/bloc/user/user_bloc.dart';
import 'package:aviz_app/data/model/bookmark.dart';
import 'package:aviz_app/di.dart';
import 'package:aviz_app/screens/authentication/welcome_screen.dart';
import 'package:aviz_app/screens/aviz_detail_screen.dart';
import 'package:aviz_app/screens/dashboard_screen.dart';
import 'package:aviz_app/utils/auth_manager.dart';
import 'package:aviz_app/utils/settings_manager.dart';
import 'package:aviz_app/utils/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // init shared_preferences
  WidgetsFlutterBinding.ensureInitialized();

  // setup Hive
  await Hive.initFlutter();
  Hive.registerAdapter(BookmarkAdapter());
  await Hive.openBox<Bookmark>('BookmarkBox');

  // setup locator
  await getItInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AuthManager.isLogedIn();
    final isFirstRun = SettingsManager.isFirstRun();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeManager.appTheme(context),
      initialRoute: '/',
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => DashboardScreen(),
        );
      },
      routes: {
        '/': (context) => (isFirstRun) ? WelcomeScreen() : DashboardScreen(),
        '/aviz': (context) => BlocProvider(
              create: (context) => UserBloc(),
              child: AvizDetailScreen(avizId: ModalRoute.of(context)!.settings.arguments as String),
            ),
      },
    );
  }
}
