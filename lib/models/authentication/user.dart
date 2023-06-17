// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:thanhhoa_garden/models/authentication/role.dart';

class User {
  late final address;
  late final avatar;
  late final email;
  late final full_name;
  late final gender;
  late final password;
  late final phone;
  late final status;
  late final username;
  late Role? role;

  User(
      {this.phone,
      this.status,
      this.username,
      this.address,
      this.password,
      this.avatar,
      this.email,
      this.full_name,
      this.gender,
      this.role});

  User.login(Map<String, dynamic> json, Role role) {
    address = json['address'];
    avatar = json['avatar'];
    email = json['email'];
    full_name = json['full_name'];
    gender = json['gender'];
    password = json['password'];
    phone = json['phone'];
    status = json['status'];
    username = json['username'];
    role = role;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['phone'] = phone;
    data['password'] = password;
    data['status'] = status;
    data['username'] = username;
    data['role'] = role;
    data['full_name'] = full_name;
    data['gender'] = gender;
    data['address'] = address;
    data['status'] = status;
    data['role'] = role;

    return data;
  }

  Map<String, dynamic> loggedUser = {
    "address": "Quận 9, TP HCM",
    "avatar":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRyOkI7jCSQ6X-zUxWna8V4C-r-pbprAMWCVQ&usqp=CAU",
    "email": "abc@gmail.com",
    "full_name": "Hieu Test 1",
    "gender": "True",
    "password": "123456789",
    "phone": "123456789",
    "status": "Active",
    "username": "testacc1",
    "role_id": "5",
  };
}
