import 'package:aviz_app/data/model/aviz.dart';
import 'package:aviz_app/data/model/user.dart';

abstract class UserState {}

class UserInitState extends UserState {}

class UserInfoLoading extends UserState {}

class UserInfoLoadSuccess extends UserState {
  User userInfo;
  UserInfoLoadSuccess(this.userInfo);
}

class UserInfoLoadFailed extends UserState {
  String response;
  UserInfoLoadFailed(this.response);
}

class UserAvizListLoading extends UserState {}

class UserAvizListLoadSuccess extends UserState {
  List<Aviz> avizList;
  UserAvizListLoadSuccess(this.avizList);
}

class UserAvizListLoadFailed extends UserState {
  String response;
  UserAvizListLoadFailed(this.response);
}

final class BookmarkInitial extends UserState {}

class UserBookmarkListLoading extends UserState {}

class UserBookmarkListLoadSuccess extends UserState {
  final List<Aviz> bookmarkList;
  UserBookmarkListLoadSuccess(this.bookmarkList);
}

class UserBookmarkListLoadFailed extends UserState {
  final String errorMessage;
  UserBookmarkListLoadFailed(this.errorMessage);
}
