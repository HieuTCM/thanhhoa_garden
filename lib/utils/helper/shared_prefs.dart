import 'package:thanhhoa_garden/main.dart';

String getTokenAuthenFromSharedPrefs() {
  if (sharedPreferences.getString('Token') == null) {
    return '';
  }
  return sharedPreferences.getString('Token')!;
}

int getCuctomerIDFromSharedPrefs() {
  return sharedPreferences.getInt('User')!;
}
