import 'package:thanhhoa_garden/models/authentication/user.dart';

abstract class AuthEvent {
  String? _username;
  String? _password;
  User? _userObj;
  String? get user => _username;
  String? get pass => _password;
  User? get userObj => _userObj;
}

class LoginEvent extends AuthEvent {
  @override
  String? user;
  @override
  String? pass;
  LoginEvent({this.user, this.pass}) : super();
}

class LoginWithGGEvent extends AuthEvent {}

// class RegisterEvent extends AuthEvent {
//   @override
//   User userObj;
//   RegisterEvent({required this.userObj}) : super();
// }

class LogoutEvent extends AuthEvent {}
