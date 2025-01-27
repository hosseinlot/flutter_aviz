import 'package:aviz_app/data/model/aviz.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeRequestSuccess extends HomeState {
  List<Aviz> hotAvizList;
  List<Aviz> normalAvizList;
  HomeRequestSuccess(this.hotAvizList, this.normalAvizList);
}

class HomeRequestFailed extends HomeState {
  String response;
  HomeRequestFailed(this.response);
}

class HomeNextPageLoadingState extends HomeState {}

class HomeNextPageSuccess extends HomeState {
  List<Aviz> normalAvizList;
  HomeNextPageSuccess(this.normalAvizList);
}

class HomeNextPageFailed extends HomeState {
  final String errorMessage;
  HomeNextPageFailed(this.errorMessage);
}

class HomeAllAvizLoadingState extends HomeState {}

class HomeAllAvizSuccess extends HomeState {
  List<Aviz> allAvizList;
  HomeAllAvizSuccess(this.allAvizList);
}

class HomeAllAvizFailed extends HomeState {
  final String errorMessage;
  HomeAllAvizFailed(this.errorMessage);
}
