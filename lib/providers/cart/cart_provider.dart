import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thanhhoa_garden/main.dart';
import 'package:thanhhoa_garden/models/bonsai/bonsai.dart';
import 'package:thanhhoa_garden/models/cart/cart.dart';
import 'package:thanhhoa_garden/utils/connection/utilsConnection.dart';
import 'package:thanhhoa_garden/utils/helper/shared_prefs.dart';
import 'package:http/http.dart' as http;

class CartProvider extends ChangeNotifier {
  List<OrderCart>? _list;
  List<OrderCart>? get list => _list;

  Future<bool> getCart() async {
    bool result = false;
    List<OrderCart> list = [];
    var header = getheader(getTokenAuthenFromSharedPrefs());
    try {
      final res = await http.get(Uri.parse(mainURL + CartURL), headers: header);
      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          var jsondata = json.decode(res.body);
          for (var data in jsondata) {
            OrderCart cart = OrderCart();
            cart = OrderCart.fromJson(data);
            list.add(cart);
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

  Future<bool> AddToCart(String? plantID, int? quantity) async {
    bool result = false;
    var header = getheader(getTokenAuthenFromSharedPrefs());
    Map<String, dynamic> param = ({});
    param['plantID'] = '${plantID}';
    param['quantity'] = quantity;
    var body = json.encode(param);
    try {
      final res = await http.post(Uri.parse(mainURL + CartURL),
          body: body, headers: header);
      if (res.statusCode == 200) {
        await getCart().then((value) {
          Fluttertoast.showToast(
              msg: "Thêm cây thành công",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          return result = true;
        });
      }

      notifyListeners();
    } on HttpException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    return result;
  }

  Future<bool> MinustoCart(String? cartID, int? quantity) async {
    bool result = false;
    var header = getheader(getTokenAuthenFromSharedPrefs());
    Map<String, dynamic> param = ({});
    param['cartID'] = '${cartID}';
    param['quantity'] = quantity;
    var body = json.encode(param);
    try {
      final res = await http.put(Uri.parse(mainURL + CartURL),
          body: body, headers: header);
      if (res.statusCode == 200) {
        await getCart().then((value) {
          Fluttertoast.showToast(
              msg: "Cập nhật cây thành công",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          return result = true;
        });
      }

      notifyListeners();
    } on HttpException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    return result;
  }
}
