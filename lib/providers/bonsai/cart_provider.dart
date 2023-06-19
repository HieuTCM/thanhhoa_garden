import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:thanhhoa_garden/main.dart';
import 'package:thanhhoa_garden/models/bonsai/bonsai.dart';

class CartProvider extends ChangeNotifier {
  List<Bonsai>? _list;
  List<Bonsai>? get lits => _list;

  Future<bool> addtoCart(Bonsai bonsai) async {
    bool result = false;
    int status = 404;
    try {
      Listincart.add(bonsai);
      _list = Listincart;
      notifyListeners();
    } on HttpException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    return result;
  }
}
