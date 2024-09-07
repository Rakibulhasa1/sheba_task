abstract class AuthEvent {}

class AuthLogin extends AuthEvent {
  final String email;
  final String password;
  AuthLogin(this.email, this.password);
}

class AuthLogout extends AuthEvent {}
