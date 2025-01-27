import 'package:aviz_app/data/datasource/authentication_datasource.dart';
import 'package:aviz_app/data/datasource/aviz_datasource.dart';
import 'package:aviz_app/data/datasource/aviz_detail_datasource.dart';
import 'package:aviz_app/data/datasource/category_datasource.dart';
import 'package:aviz_app/data/datasource/profile_datasource.dart';
import 'package:aviz_app/data/repository/authentication_repository.dart';
import 'package:aviz_app/data/repository/aviz_detail_repository.dart';
import 'package:aviz_app/data/repository/aviz_repository.dart';
import 'package:aviz_app/data/repository/category_repository.dart';
import 'package:aviz_app/data/repository/profile_repository.dart';
import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;

Future<void> getItInit() async {
  await _initComponents();
  _initDatasources();
  _initRepositories();
}

Future<void> _initComponents() async {
  locator.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());
  locator.registerSingleton<Dio>(Dio(BaseOptions(baseUrl: 'https://aviz-app.pockethost.io/api/')));
}

void _initRepositories() {
  locator.registerFactory<IAuthRepository>(() => AuthenticationRepository());
  locator.registerFactory<ICategoryRepository>(() => CategoryRepository());
  locator.registerFactory<IAvizRepository>(() => AvizRepository());
  locator.registerFactory<IAvizDetailRepository>(() => AvizDetailRepository());
  locator.registerFactory<IProfileRepository>(() => ProfileRepository());
}

void _initDatasources() {
  locator.registerFactory<IAuthDatasource>(() => AuthenticationRemote());
  locator.registerFactory<ICategoryDatasource>(() => CategoryLocalDatasource());
  locator.registerFactory<IAvizDatasource>(() => AvizRemoteDatasource());
  locator.registerFactory<IAvizDetailDatasource>(() => AvizDetailDatasource());
  locator.registerFactory<IProfileDatasource>(() => ProfileDatasource());
}
