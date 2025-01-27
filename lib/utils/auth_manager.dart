import 'package:aviz_app/data/model/bookmark.dart';
import 'package:aviz_app/di.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static final ValueNotifier<String?> authChangeNotifier = ValueNotifier(null);
  static final SharedPreferences _sharedPreferences = locator.get();

  static void saveToken(String token) async {
    _sharedPreferences.setString('access_token', token);
    authChangeNotifier.value = token;
  }

  static String readAuth() {
    return _sharedPreferences.getString('access_token') ?? '';
  }

  static void saveId(String userId, String name, String phoneNumber) async {
    _sharedPreferences.setString('user_id', userId);
  }

  static void saveBookmarks(var bookmarkList) async {
    for (var bookmark in bookmarkList) {
      Hive.box<Bookmark>('BookmarkBox').add(Bookmark(bookmark['aviz_id']));
    }
  }

  static String getId() {
    return _sharedPreferences.getString('user_id') ?? '';
  }

  static void logout() {
    _sharedPreferences.remove('access_token');
    _sharedPreferences.remove('user_id');
    Hive.box<Bookmark>('BookmarkBox').clear();
    authChangeNotifier.value = null;
  }

  static bool isLogedIn() {
    String token = readAuth();
    authChangeNotifier.value = token;
    return token.isNotEmpty;
  }
}
