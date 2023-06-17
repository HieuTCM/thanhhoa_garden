// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thanhhoa_garden/blocs/authentication/auth_bloc.dart';
import 'package:thanhhoa_garden/blocs/authentication/auth_event.dart';
import 'package:thanhhoa_garden/blocs/authentication/auth_state.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:thanhhoa_garden/models/authentication/user.dart';
import 'package:thanhhoa_garden/screens/home/homePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

var _usernameController = TextEditingController();
var _passwordController = TextEditingController();
var _btnController = RoundedLoadingButtonController();

class _LoginPageState extends State<LoginPage> {
  late User? _user = User();
  late AuthBloc authBloc;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authBloc = Provider.of<AuthBloc>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.clear();
    _passwordController.clear();
    authBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // final authBloc = Provider.of<AuthBloc>(context, listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: const BoxDecoration(gradient: tabBackground),
          child: Stack(
            children: [
              Image(
                height: size.height * 0.57,
                width: size.width,
                image: const AssetImage('assets/Logo.png'),
                fit: BoxFit.cover,
              ),
              Container(
                padding: const EdgeInsets.only(left: 5, right: 5),
                constraints: BoxConstraints(minHeight: size.height),
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.5 + 15,
                    ),
                    _loginForm(authBloc),
                    const SizedBox(
                      height: 7,
                    ),
                    StreamBuilder<AuthState>(
                        stream: authBloc.authStateStream,
                        initialData: AuthInitial(),
                        builder: (context, snapshot) {
                          final state = snapshot.data;
                          if (state is AuthLoading) {
                            return Container();
                          } else if (state is AuthFailure) {
                            checkBtnLogin('Failed', _user);
                            // authBloc.authStateController.add(AuthInitial());
                            return Text(
                              state.errorMessage,
                              style: const TextStyle(color: ErorText),
                            );
                          } else if (state is AuthSuccess) {
                            _user = state.user;
                            checkBtnLogin('Success', _user);
                            return Container();
                          } else {
                            return Container();
                          }
                        }),
                    const SizedBox(
                      height: 5,
                    ),
                    _loginButton(authBloc),
                    const SizedBox(
                      height: 7,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    _LoginWithGGButton(authBloc),
                    const SizedBox(
                      height: 7,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Đăng ký tài khoản',
                          style: TextStyle(
                            color: darkText,
                            fontSize: 20,
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void checkBtnLogin(String value, User? user) {
    switch (value) {
      case "Failed":
        _btnController.error();
        Timer(const Duration(seconds: 2), () {
          _btnController.reset();
        });
        break;
      case "Success":
        _btnController.success();
        Timer(const Duration(seconds: 1), () {
          _btnController.reset();
          Fluttertoast.showToast(
              msg: "Logging success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => HomePage(
                    user: _user,
                  )));
        });
        break;
    }
  }

  Widget _loginForm(authBloc) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      width: size.width,
      child: Column(children: [
        TextFormField(
          onTap: () {
            authBloc.authStateController.add(AuthInitial());
          },
          controller: _usernameController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 3, color: Colors.black)),
            hintText: 'Tên tài khoản',
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          onTap: () {
            authBloc.authStateController.add(AuthInitial());
          },
          obscureText: true,
          controller: _passwordController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 3, color: Colors.black)),
            hintText: 'Mật khẩu',
          ),
        ),
      ]),
    );
  }

  Widget _loginButton(authBloc) {
    return RoundedLoadingButton(
        controller: _btnController,
        width: 150,
        height: 40,
        color: buttonColor,
        borderRadius: 10,
        onPressed: () {
          var username = _usernameController.text;
          var password = _passwordController.text;
          authBloc.send(LoginEvent(user: username, pass: password));
        },
        child: const Text(
          'Đăng Nhập',
          style: TextStyle(
              color: lightText, fontSize: 20, fontWeight: FontWeight.w600),
        ));
  }

  Widget _LoginWithGGButton(authBloc) {
    var size = MediaQuery.of(context).size;
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          side: const BorderSide(color: Colors.black, width: 0.8),
          minimumSize: Size(size.width - 30, 50),
          shadowColor: Colors.transparent,
          // shape:
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          foregroundColor: buttonColor,
          backgroundColor: Colors.transparent,
          maximumSize: const Size(double.infinity, 50)),
      icon: const FaIcon(
        FontAwesomeIcons.google,
        color: Colors.red,
      ),
      label: const Text(
        'Tiếp tục bằng tài khoản Google',
        style: TextStyle(
            color: darkText, fontSize: 20, fontWeight: FontWeight.w500),
      ),
      onPressed: () {
        authBloc.send(LoginWithGGEvent());
      },
    );
  }
}
