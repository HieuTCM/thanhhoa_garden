// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/authentication/role.dart';

class User {
  late final id;
  late final address;
  late final avatar;
  late final email;
  late final fullName;
  late final gender;
  late final password;
  late final phone;
  late final status;
  late final username;
  late Role? role;

  User(
      {this.id,
      this.phone,
      this.status,
      this.username,
      this.address,
      this.password,
      this.avatar,
      this.email,
      this.fullName,
      this.gender,
      this.role});

  User.login(Map<String, dynamic> json, Role role) {
    id = json['id'];
    address = json['address'];
    avatar = json['avatar'];
    email = json['email'];
    fullName = json['fullName'];
    gender = json['gender'];
    password = json['password'];
    phone = json['phone'];
    status = json['status'];
    username = json['username'];
    role = role;
  }
  User.fetchInfo(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    email = json['email'];
    fullName = json['fullName'];
    phone = json['phone'];
    avatar = json['avatar'] ?? NoIMG;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phone'] = phone;
    data['password'] = password;
    data['username'] = username;
    data['fullName'] = fullName;
    data['gender'] = gender;
    data['address'] = address;
    data['avatar'] = avatar;
    data['email'] = email;

    return data;
  }
}
