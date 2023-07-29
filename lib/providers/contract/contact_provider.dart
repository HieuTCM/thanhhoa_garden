import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:thanhhoa_garden/utils/connection/utilsConnection.dart';
import 'package:thanhhoa_garden/utils/helper/shared_prefs.dart';
import 'package:http/http.dart' as http;

class ContactProvider extends ChangeNotifier {
  Future<bool> createContact(Map<String, dynamic> map) async {
    bool result = false;
    var body = json.encode(map);
    var header = getheader(getTokenAuthenFromSharedPrefs());
    try {
      final res = await http.post(Uri.parse(mainURL + createContactURL),
          headers: header, body: body);
      if (res.statusCode == 200) {
        result = true;
        notifyListeners();
      } else {
        result = false;
        notifyListeners();
      }
    } on HttpException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return result;
  }
}
