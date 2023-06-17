import 'dart:async';
import 'dart:convert';

import 'package:thanhhoa_garden/main.dart';
import 'package:thanhhoa_garden/models/authentication/user.dart';
import 'package:thanhhoa_garden/providers/authentication/authantication_provider.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc {
  final AuthenticationProvider _authProvider;
  final StreamController<AuthState> _authStateController =
      StreamController<AuthState>();

  Stream<AuthState> get authStateStream => _authStateController.stream;
  StreamController<AuthState> get authStateController => _authStateController;

  AuthBloc({required AuthenticationProvider authProvider})
      : _authProvider = authProvider {
    _authStateController.add(AuthInitial());
  }
  // FirebaseAuth auth = FirebaseAuth.instance;
  void send(AuthEvent event) async {
    switch (event.runtimeType) {
      case LoginEvent:
        {
          _authStateController.add(AuthLoading());
          await _authProvider.login(event.user, event.pass).then((success) {
            if (success) {
              final user = _authProvider.loggedInUser;
              _authStateController.add(AuthSuccess(user: user));
              sharedPreferences.setString('Token', 'This is authen token');
            } else {
              _authStateController.add(
                  AuthFailure(errorMessage: 'Invalid username or password.'));
            }
          });
        }
        break;
      case LoginWithGGEvent:
        {
          _authStateController.add(AuthLoading());
          await _authProvider.loginWithGG().then((value) {
            if (value) {
              final user = _authProvider.loggedInUser;
              _authStateController.add(AuthSuccess(user: user));
              sharedPreferences.setString('Token', 'This is authen token');
            } else {
              _authStateController.add(
                  AuthFailure(errorMessage: 'Invalid username or password.'));
            }
          });
        }
        break;
      case LogoutEvent:
        {
          _authProvider.logout();
          _authStateController.add(AuthInitial());
        }
        break;
    }
  }

  void dispose() {
    _authStateController.close();
  }
}
