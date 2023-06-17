// ignore_for_file: file_names

import 'package:thanhhoa_garden/utils/helper/shared_prefs.dart';

String token = getTokenAuthenFromSharedPrefs();

final Map<String, String> header = {
  'Content-Type': 'application/json; charset=UTF-8',
  'Accept': 'application/json',
  'Accept-Charset': 'UTF-8',
  "Authorization": 'Bearer $token'
};
final Map<String, String> headerLogin = {
  'Content-Type': 'application/json; charset=UTF-8',
  'Accept': 'application/json',
  'Accept-Charset': 'UTF-8',
};

//Main URL API
const mainURL = 'https://thanhhoagarden.herokuapp.com';

//User
const login = '/user/login?';
const loginWithGGorPhone = '/user/loginWithEmailOrPhone?';
const register = '/user/register';
const updatefcmToken = '/user/createFcmToken';

//Bonsai
const getPlant = '/plant?';
const getPlantByID = '/plant/';
const searchPlant = '/plant/plantFilter?';
