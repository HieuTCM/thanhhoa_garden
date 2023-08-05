// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/authentication/user.dart' as UserObj;
import 'package:thanhhoa_garden/providers/authentication/authantication_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

var _usernameController = TextEditingController();
var _passwordController = TextEditingController();
var _conformPasswordController = TextEditingController();
var _phonedController = TextEditingController();
var _fullNameController = TextEditingController();
var _emailController = TextEditingController();
var _addressController = TextEditingController();
late Timer _timer;

class _RegisterPageState extends State<RegisterPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool gender = false;
  String? pin1;
  String? pin2;
  String? pin3;
  String? pin4;
  String? pin5;
  String? pin6;
  bool verifyOTP = false;
  bool register = false;
  int _start = 0;
  String _verificationId = '';
  loginByPhoneNumber(String phone) async {
    await auth.verifyPhoneNumber(
      phoneNumber: '+84$phone',
      timeout: const Duration(seconds: 90),
      codeSent: (String verificationId, int? resendToken) async {
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => verifyOTP(
        //           phone: phone,
        //           verificationId: verificationId,
        //         )));
        setState(() {
          verifyOTP = true;
          _start = 120;
          _verificationId = verificationId;
        });
        startTimer();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
      verificationFailed: (FirebaseAuthException e) {
        Fluttertoast.showToast(
            msg: 'Lỗi hệ thống vui lòng thử lại sau',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromARGB(255, 252, 2, 2),
            textColor: Colors.white,
            fontSize: 16.0);
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    _usernameController.clear();
    _passwordController.clear();
    _phonedController.clear();
    _fullNameController.clear();
    _emailController.clear();
    _addressController.clear();
    _conformPasswordController.clear();
    super.dispose();
  }

  String? errorphone;
  String? validatePhone(String value) {
    RegExp regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10}$)');
    if (value.isEmpty) {
      return 'Nhập số điện thoại';
    } else if (!regExp.hasMatch(value)) {
      return 'Số điện thoại không khả dụng';
    }
    return (regExp.hasMatch(value)) ? null : "Số điện thoại không khả dụng";
  }

  String? errorUsername;
  String? validateUserName(String value) {
    if (value.isEmpty) {
      return 'Nhập Username';
    }
    return null;
  }

  String? errorAddress;
  String? validateAddress(String value) {
    if (value.isEmpty) {
      return 'Nhập địa chỉ của bạn';
    }
    return null;
  }

  String? errorPassword;
  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Nhập mật khẩu';
    } else if (value.length < 8) {
      return 'Mật khậu phải từ 8 kí tự trở lên';
    }
    return null;
  }

  String? errorConformPass;
  String? validateConform(String value) {
    if (value.isEmpty) {
      return 'Nhập lại mật khẩu';
    } else if (value != _passwordController.text) {
      return 'Mật khẩu không trùng khớp';
    }
    return null;
  }

  String? errorName;
  String? validateName(String value) {
    RegExp regExp = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');
    bool check = regExp.hasMatch(value);
    if (value.isEmpty) {
      return 'Nhập tên';
    } else if (check) {
      return 'Tên không chứ kí tự đặc biệt';
    } else if (value.length < 3) {
      return 'Tên phải nhiều hơn 3 từ';
    } else if (value.length >= 50) {
      return 'Tên ít hơn 50 từ ';
    } else {
      return (!regExp.hasMatch(value)) ? null : 'Tên không chứ kí tự đặc biệt';
    }
  }

  String? errorEmail;
  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Enter your name';
    } else {
      return EmailValidator.validate(value) ? null : 'Email Invald';
    }
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return buttonColor;
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
                decoration: const BoxDecoration(gradient: tabBackground),
                child: Stack(children: [
                  Image(
                    height: size.height * 0.57,
                    width: size.width,
                    image: const AssetImage('assets/Logo.png'),
                    fit: BoxFit.cover,
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      constraints: BoxConstraints(minHeight: size.height),
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                      child: Column(children: [
                        register
                            ? SizedBox(
                                height: size.height * 0.45,
                              )
                            : verifyOTP
                                ? SizedBox(
                                    height: size.height * 0.5 + 20,
                                  )
                                : SizedBox(
                                    height: size.height * 0.45,
                                  ),
                        register
                            ? _InformationForm()
                            : verifyOTP
                                ? _OTPForm()
                                : _RegisterForm(),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Trở lại',
                              style: TextStyle(
                                color: darkText,
                                fontSize: 20,
                              ),
                            )),
                      ])),
                ]))));
  }

  Widget _RegisterForm() {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      width: size.width,
      child: Column(children: [
        TextFormField(
          onTap: () {},
          onChanged: (value) {
            setState(() {
              errorUsername = validateUserName(value);
            });
          },
          controller: _usernameController,
          decoration: InputDecoration(
            errorText: errorUsername,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 3, color: Colors.black)),
            hintText: 'Tên tài khoản',
            prefixIcon: const Icon(Icons.person, color: Colors.black),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          onTap: () {},
          onChanged: (value) {
            setState(() {
              errorPassword = validatePassword(value);
            });
          },
          obscureText: true,
          controller: _passwordController,
          decoration: InputDecoration(
              errorText: errorPassword,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 3, color: Colors.black)),
              hintText: 'Mật khẩu',
              prefixIcon: const Icon(Icons.security, color: Colors.black)),
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          onTap: () {},
          onChanged: (value) {
            setState(() {
              errorConformPass = validateConform(value);
            });
          },
          obscureText: true,
          controller: _conformPasswordController,
          decoration: InputDecoration(
              errorText: errorConformPass,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 3, color: Colors.black)),
              hintText: 'Nhập lại mật khẩu',
              prefixIcon: const Icon(Icons.security, color: Colors.black)),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          onTap: () {},
          onChanged: (value) {
            setState(() {
              errorphone = validatePhone(value);
            });
          },
          controller: _phonedController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            errorText: errorphone,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 3, color: Colors.black)),
            hintText: 'Số điện thoại',
            prefixIcon: const Icon(Icons.phone, color: Colors.black),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: 150,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: buttonColor),
          child: InkWell(
            onTap: () {
              _usernameController.text.isEmpty
                  ? setState(() {
                      errorUsername =
                          validateUserName(_usernameController.text);
                    })
                  : _passwordController.text.isEmpty || errorPassword != null
                      ? setState(() {
                          errorPassword =
                              validatePassword(_passwordController.text);
                        })
                      : _conformPasswordController.text.isEmpty ||
                              errorConformPass != null
                          ? setState(() {
                              errorConformPass = validateConform(
                                  _conformPasswordController.text);
                            })
                          : _phonedController.text.isEmpty || errorphone != null
                              ? setState(() {
                                  errorphone =
                                      validatePhone(_phonedController.text);
                                })
                              : loginByPhoneNumber(_phonedController.text
                                  .substring(1, _phonedController.text.length));
            },
            child: const Text(
              'Tiếp tục',
              style: TextStyle(
                  color: lightText, fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _InformationForm() {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      width: size.width,
      child: Column(children: [
        TextFormField(
          onTap: () {},
          onChanged: (value) {
            setState(() {
              errorName = validateName(value);
            });
          },
          controller: _fullNameController,
          decoration: InputDecoration(
            errorText: errorName,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 3, color: Colors.black)),
            hintText: 'Họ và Tên',
            prefixIcon: const Icon(Icons.person, color: Colors.black),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          onTap: () {},
          onChanged: (value) {
            setState(() {
              errorEmail = validateEmail(value);
            });
          },
          controller: _emailController,
          decoration: InputDecoration(
              errorText: errorEmail,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 3, color: Colors.black)),
              hintText: 'Email',
              prefixIcon: const Icon(Icons.mail, color: Colors.black)),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          onTap: () {},
          onChanged: (value) {
            setState(() {
              errorAddress = validateAddress(value);
            });
          },
          controller: _addressController,
          decoration: InputDecoration(
              errorText: errorAddress,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 3, color: Colors.black)),
              hintText: 'Địa chỉ',
              prefixIcon: const Icon(Icons.home, color: Colors.black)),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Giới tính: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 20,
              ),
              const Text(
                "Nam: ",
                style: TextStyle(fontSize: 15),
              ),
              Expanded(
                  child: Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: gender,
                      onChanged: (bool? value) {
                        setState(() {
                          gender = value!;
                        });
                      })),
              const Text(
                "Nữ: ",
                style: TextStyle(fontSize: 15),
              ),
              Expanded(
                  child: Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: !gender,
                      onChanged: (bool? value) {
                        setState(() {
                          gender = !value!;
                        });
                      }))
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: 170,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: buttonColor),
          child: InkWell(
            onTap: () async {
              UserObj.User user = UserObj.User();
              _fullNameController.text.isEmpty || errorName != null
                  ? setState(() {
                      errorName = validateName(_fullNameController.text);
                    })
                  : _emailController.text.isEmpty || errorEmail != null
                      ? setState(() {
                          errorEmail = validateEmail(_emailController.text);
                        })
                      : _addressController.text.isEmpty || errorAddress != null
                          ? setState(() {
                              errorAddress =
                                  validateAddress(_addressController.text);
                            })
                          : {
                              user = UserObj.User(
                                  username: _usernameController.text,
                                  password: _passwordController.text,
                                  phone: _phonedController.text,
                                  email: _emailController.text,
                                  fullName: _fullNameController.text,
                                  address: _addressController.text,
                                  gender: !gender,
                                  avatar:
                                      'https://img.meta.com.vn/Data/image/2022/01/05/avatar-tet-8.jpg'),
                              await AuthenticationProvider()
                                  .register(user)
                                  .then((value) {
                                String result = value;
                                switch (result) {
                                  case "Email đã tồn tại.":
                                    {
                                      setState(() {
                                        errorEmail = result;
                                      });
                                      break;
                                    }
                                  case "Phone đã tồn tại.":
                                    {
                                      setState(() {
                                        errorphone = result;
                                        verifyOTP = false;
                                        register = false;
                                      });
                                      break;
                                    }
                                  case "Username đã tồn tại.":
                                    {
                                      setState(() {
                                        errorUsername = result;
                                        verifyOTP = false;
                                        register = false;
                                      });
                                      break;
                                    }
                                  case "faild":
                                    {
                                      Fluttertoast.showToast(
                                          msg: "Đăng kí thất bại",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: buttonColor,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      break;
                                    }

                                  case "Success":
                                    {
                                      Fluttertoast.showToast(
                                          msg: "Đăng kí thành công",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: buttonColor,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      break;
                                    }
                                }
                              })
                            };
            },
            child: const Text(
              'Hoàn tất đăng kí',
              style: TextStyle(
                  color: lightText, fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _OTPForm() {
    return Form(
        child: Column(children: [
      const SizedBox(
        height: 50,
      ),
      Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          const Text(
            'Phone:',
            style: TextStyle(
              color: darkText,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            _phonedController.text,
            style: const TextStyle(
              color: darkText,
              fontSize: 17,
            ),
          )
        ],
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
          height: 55,
          width: 55,
          child: TextFormField(
            onChanged: ((value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
              if (value.isEmpty) {
                FocusScope.of(context).previousFocus();
              }
              setState(() {
                pin1 = value;
              });
            }),
            style: Theme.of(context).textTheme.headline6,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
        SizedBox(
          height: 55,
          width: 55,
          child: TextFormField(
            onChanged: ((value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
              if (value.isEmpty) {
                FocusScope.of(context).previousFocus();
              }
              setState(() {
                pin2 = value;
              });
            }),
            style: Theme.of(context).textTheme.headline6,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
        SizedBox(
          height: 55,
          width: 55,
          child: TextFormField(
            onChanged: ((value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
              if (value.isEmpty) {
                FocusScope.of(context).previousFocus();
              }
              setState(() {
                pin3 = value;
              });
            }),
            style: Theme.of(context).textTheme.headline6,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
        SizedBox(
          height: 55,
          width: 55,
          child: TextFormField(
            onChanged: ((value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
              if (value.isEmpty) {
                FocusScope.of(context).previousFocus();
              }
              setState(() {
                pin4 = value;
              });
            }),
            style: Theme.of(context).textTheme.headline6,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
        SizedBox(
          height: 55,
          width: 55,
          child: TextFormField(
            onChanged: ((value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
              if (value.isEmpty) {
                FocusScope.of(context).previousFocus();
              }
              setState(() {
                pin5 = value;
              });
            }),
            style: Theme.of(context).textTheme.headline6,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
        SizedBox(
          height: 55,
          width: 55,
          child: TextFormField(
            onChanged: ((value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
              if (value.isEmpty) {
                FocusScope.of(context).previousFocus();
              }
              setState(() {
                pin6 = value;
              });
            }),
            style: Theme.of(context).textTheme.headline6,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
      ]),
      const SizedBox(
        height: 10,
      ),
      (_start != 0)
          ? Text(
              '$_start s',
              style: const TextStyle(color: Colors.red, fontSize: 18),
            )
          : GestureDetector(
              onTap: (() {
                loginByPhoneNumber(_phonedController.text
                    .substring(1, _phonedController.text.length));
              }),
              child: const Text(
                'Gửi lại OTP',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
      const SizedBox(
        height: 10,
      ),
      Container(
        width: 150,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: buttonColor),
        child: InkWell(
          onTap: () async {
            String otp = '$pin1$pin2$pin3$pin4$pin5$pin6';
            // Create a PhoneAuthCredential with the code
            PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: _verificationId, smsCode: otp);
            // Sign the user in (or link) with the credential
            await auth.signInWithCredential(credential).then((valueSignIn) {
              setState(() {
                register = true;
              });
            }).catchError((e) {
              Fluttertoast.showToast(
                  msg: e.code,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: const Color.fromARGB(255, 252, 2, 2),
                  textColor: Colors.white,
                  fontSize: 16.0);
            });
            ;
            // loginByPhoneNumber(_phonedController.text
            //     .substring(1, _phonedController.text.length));
          },
          child: const Text(
            'Xác nhận OPT',
            style: TextStyle(
                color: lightText, fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    ]));
  }
}
