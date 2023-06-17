// ignore_for_file: library_prefixes

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thanhhoa_garden/main.dart';
import 'package:thanhhoa_garden/models/authentication/role.dart';
import 'package:thanhhoa_garden/models/authentication/user.dart' as UserObj;

class AuthenticationProvider extends ChangeNotifier {
  UserObj.User? _loggedInUser;

  UserObj.User? get loggedInUser => _loggedInUser;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> login(String? username, String? password) async {
    // Simulate an asynchronous API call to validate the username and password
    await Future.delayed(const Duration(seconds: 2));

    // Check if the provided username and password match the expected values
    if (username == 'abc' && password == '123456') {
      // Create a User object with the provided information
      Role role = Role(id: 5, name: 'Customer');
      Map<String, dynamic> userJson = UserObj.User(role: role).loggedUser;
      _loggedInUser = UserObj.User.login(userJson, role);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> loginWithGG() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn
        .disconnect()
        .catchError((e) {})
        .onError((error, stackTrace) => null);
    googleSignIn.isSignedIn().then((value) async {
      await googleSignIn.signOut().onError((error, stackTrace) => null);
      await FirebaseAuth.instance.signOut();
    });
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    String? token1 = googleAuth?.idToken.toString().substring(0, 500);
    String? token2 = googleAuth?.idToken
        .toString()
        .substring(500, googleAuth.idToken!.length);
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: "$token1$token2",
    );
    var credent = await FirebaseAuth.instance.signInWithCredential(credential);
    if (credent.user?.uid != null) {
      var user = FirebaseAuth.instance.currentUser;
      _loggedInUser = UserObj.User(
          username: '',
          full_name: user?.displayName,
          email: user?.email,
          password: '',
          address: 'Quận 9, TP HCM',
          avatar: user?.photoURL,
          phone: user?.phoneNumber);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  void logout() {
    sharedPreferences.clear();
    // print(getTokenAuthenFromSharedPrefs());
    _loggedInUser = null;
    notifyListeners();
  }
}
