abstract class AuthEvent {}

class AuthLoginRequest extends AuthEvent {
  AuthLoginRequest(this.username, this.password);

  String username;
  String password;
}

class AuthRegisterRequest extends AuthEvent {
  AuthRegisterRequest(this.username, this.password, this.passwordConfirm);

  String username;
  String password;
  String passwordConfirm;
}
