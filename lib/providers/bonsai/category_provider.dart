import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:thanhhoa_garden/models/bonsai/plantCategory.dart';

class CategoryProvider extends ChangeNotifier {
  PlantCategory? _Category;
  List<PlantCategory>? _listCategory;

  PlantCategory? get Category => _Category;
  List<PlantCategory>? get listCategory => _listCategory;

  Future<bool> getAllCategory() async {
    bool result = false;
    List<PlantCategory> list = [];

    int status = 404;
    try {
      // Simulate an asynchronous API call
      await Future.delayed(const Duration(seconds: 2))
          .then((value) => {status = 200});
      if (status == 200) {
        if (plantCategoryJson.isNotEmpty) {
          PlantCategory cate = PlantCategory(id: 0, name: 'Tất Cả');
          list.add(cate);
          for (var data in plantCategoryJson) {
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
