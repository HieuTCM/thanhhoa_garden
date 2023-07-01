import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:thanhhoa_garden/models/bonsai/plantCategory.dart';
import 'package:http/http.dart' as http;
import 'package:thanhhoa_garden/utils/connection/utilsConnection.dart';
import 'package:thanhhoa_garden/utils/helper/shared_prefs.dart';

class CategoryProvider extends ChangeNotifier {
  PlantCategory? _Category;
  List<PlantCategory>? _listCategory;

  PlantCategory? get Category => _Category;
  List<PlantCategory>? get listCategory => _listCategory;

  Future<bool> getAllCategory() async {
    bool result = false;
    List<PlantCategory> list = [];

    try {
      var header = getheader(getTokenAuthenFromSharedPrefs());
      final res = await http.get(Uri.parse(mainURL + getAllCategoryURL),
          headers: header);
      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          var jsondata = json.decode(res.body);
          PlantCategory cate =
              PlantCategory(categoryID: '', categoryName: 'Tất Cả');
          list.add(cate);
          for (var data in jsondata) {
            _Category = PlantCategory.fromJson(data);
            list.add(_Category!);
          }
        }
        _listCategory = list;
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
