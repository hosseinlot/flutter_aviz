abstract class AuthState {}

class AuthInitiateState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  String response;
  AuthSuccessState(this.response);
}

class AuthFailedState extends AuthState {
  final String errorMessage;
  AuthFailedState(this.errorMessage);
}
