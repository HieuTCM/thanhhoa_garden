// ignore_for_file: library_prefixes

import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thanhhoa_garden/main.dart';
import 'package:thanhhoa_garden/models/authentication/role.dart';
import 'package:thanhhoa_garden/models/authentication/user.dart' as UserObj;
import 'package:thanhhoa_garden/utils/connection/utilsConnection.dart';
import 'package:http/http.dart' as http;
import 'package:thanhhoa_garden/utils/helper/shared_prefs.dart';

class AuthenticationProvider extends ChangeNotifier {
  UserObj.User? _loggedInUser;

  UserObj.User? get loggedInUser => _loggedInUser;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> login(Map<String, String?> param) async {
    bool result = false;
    var body = json.encode(param);
    // String queryString = Uri(queryParameters: param).query;
    try {
      final res = await http.post(
          Uri.parse(mainURL + loginWithUsernamePasswordURL),
          headers: headerLogin,
          body: body);
      if (res.statusCode == 200) {
        var jsondata = json.decode(res.body);
        sharedPreferences.setString('Token', jsondata['token']);
        notifyListeners();
        result = true;
      } else {
        Fluttertoast.showToast(
            msg: "Đăng nhập thất bại",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } on HttpException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    return result;
  }

  Future<bool> loginWithGGorPhone(Map<String, String?> param) async {
    bool result = false;
    String queryString = Uri(queryParameters: param).query;
    try {
      final res = await http.post(
          Uri.parse(mainURL + loginWithGGorPhoneURL + queryString),
          headers: headerLogin);
      if (res.statusCode == 200) {
        var jsondata = json.decode(res.body);
        sharedPreferences.setString('Token', jsondata['token']);
        notifyListeners();
        result = true;
      } else {
        Fluttertoast.showToast(
            msg: "Đăng nhập thất bại",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } on HttpException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    return result;
  }

  Future<bool> getUserInfor() async {
    bool result = false;
    try {
      // print('Token user: ' + getTokenAuthenFromSharedPrefs());
      var header = getheader(getTokenAuthenFromSharedPrefs());
      final res =
          await http.get(Uri.parse(mainURL + getUserInfoURL), headers: header);
      if (res.statusCode == 200) {
        var jsondata = json.decode(res.body);
        Role role = Role.fromJson(jsondata);
        _loggedInUser = UserObj.User.login(jsondata, role);
        notifyListeners();
        result = true;
      } else {
        Fluttertoast.showToast(
            msg: "Đăng nhập thất bại",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } on HttpException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return result;
  }

  Future<String?> loginWithGG() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn
        .disconnect()
        .catchError((e) {})
        .onError((error, stackTrace) => null);
    googleSignIn.isSignedIn().then((value) async {
      if (value) {
        await googleSignIn.signOut().onError((error, stackTrace) {});

        await FirebaseAuth.instance.signOut();
      }
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
      return user?.email;
    } else {
      return null;
    }
  }

  Future<String> register(UserObj.User user) async {
    String result = 'faild';
    var data = user.toJson();
    var body = json.encode(data);
    try {
      final res = await http.post(Uri.parse(mainURL + registerURL),
          headers: headerLogin, body: body);
      if (res.statusCode == 200) {
        return result = 'Success';
      } else if (res.statusCode == 400) {
        return result = res.body;
      } else {
        return result = 'faild';
      }
    } on HttpException catch (e) {
      print(e.toString());
    }

    return result;
  }

  void logout() async {
    sharedPreferences.clear();
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn
        .disconnect()
        .catchError((e) {})
        .onError((error, stackTrace) => null);
    googleSignIn.isSignedIn().then((value) async {
      await googleSignIn.signOut().onError((error, stackTrace) => null);
      await FirebaseAuth.instance.signOut();
    });

    _loggedInUser = null;
    notifyListeners();
  }
}
