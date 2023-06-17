abstract class AuthEvent {
  String? _username;
  String? _password;

  String? get user => _username;
  String? get pass => _password;
}

class LoginEvent extends AuthEvent {
  @override
  String? user;
  @override
  String? pass;
  LoginEvent({this.user, this.pass}) : super();
}

class LoginWithGGEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
