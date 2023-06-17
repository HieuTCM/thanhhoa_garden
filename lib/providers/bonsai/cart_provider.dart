import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CartProvider extends ChangeNotifier {
  int? _count;
  int? get count => _count;

  Future<bool> addtoCart(int? value) async {
    bool result = false;
    int status = 404;
    try {
      value ??= 0;
      value++;
      _count = value;
      notifyListeners();
    } on HttpException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    return result;
  }
}
