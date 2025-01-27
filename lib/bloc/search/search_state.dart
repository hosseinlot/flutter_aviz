import 'package:aviz_app/data/model/aviz.dart';

abstract class SearchState {}

class SearchInitState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadSuccess extends SearchState {
  List<Aviz> response;
  SearchLoadSuccess(this.response);
}

class SearchLoadFailed extends SearchState {
  final String errorMessage;
  SearchLoadFailed(this.errorMessage);
}
