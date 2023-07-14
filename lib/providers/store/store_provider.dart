import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:thanhhoa_garden/models/store/store.dart';
import 'package:thanhhoa_garden/utils/connection/utilsConnection.dart';
import 'package:thanhhoa_garden/utils/helper/shared_prefs.dart';

class StoreProvider extends ChangeNotifier {
  List<Store>? _list;
  List<Store>? get list => _list;

  Future<bool> getStore() async {
    bool result = false;
    List<Store> list = [];
    var header = getheader(getTokenAuthenFromSharedPrefs());
    try {
      final res =
          await http.get(Uri.parse(mainURL + StoreURL), headers: header);
      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          var jsondata = json.decode(res.body);
          for (var data in jsondata) {
            Store store = Store();
            store = Store.fromJson(data);
            list.add(store);
          }
          result = true;
        }
      }
      _list = list;
      notifyListeners();
    } on HttpException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    return result;
  }
}
