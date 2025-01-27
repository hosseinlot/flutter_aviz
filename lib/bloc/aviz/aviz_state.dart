abstract class AvizState {}

class AvizInitState extends AvizState {}

class AvizAddLoading extends AvizState {}

class AvizAddSuccess extends AvizState {
  String response;
  AvizAddSuccess(this.response);
}

class AvizAddFailed extends AvizState {
  final String errorMessage;
  AvizAddFailed(this.errorMessage);
}
