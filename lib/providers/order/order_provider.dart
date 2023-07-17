import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:thanhhoa_garden/blocs/order/orderEvent.dart';
import 'package:thanhhoa_garden/models/authentication/user.dart';
import 'package:thanhhoa_garden/models/cart/cart.dart';
import 'package:thanhhoa_garden/models/order/distance.dart';
import 'package:thanhhoa_garden/models/order/order.dart';
import 'package:thanhhoa_garden/models/store/store.dart';
import 'package:thanhhoa_garden/utils/connection/utilsConnection.dart';
import 'package:thanhhoa_garden/utils/helper/shared_prefs.dart';
import 'package:http/http.dart' as http;

class OrderProvider extends ChangeNotifier {
  Distance? _distancePrice;
  Distance? get distancePrice => _distancePrice;

  List<String>? _enumStatus;
  List<String>? get enumStatus => _enumStatus;

  OrderObject? _order;
  OrderObject? get order => _order;

  List<OrderObject>? _list;
  List<OrderObject>? get list => _list;

  Future<bool> getOrderList(OrderEvent event) async {
    bool result = false;
    List<OrderObject> list = [];
    Map<String, dynamic> param = ({});
    param['pageNo'] = '${event.pageNo}';
    param['pageSize'] = '${event.pageSize}';
    param['sortBy'] = event.sortBy;
    param['sortAsc'] = '${event.sortAsc}';
    if (event.status != null) param['status'] = event.status;
    String queryString = Uri(queryParameters: param).query;
    var header = getheader(getTokenAuthenFromSharedPrefs());
    try {
      final res = await http.get(Uri.parse(mainURL + getOrderURL + queryString),
          headers: header);
      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          var jsondata = json.decode(res.body);
          for (var data in jsondata) {
            User staff = User();
            User customer = User();
            Distance distance = Distance();
            Store store = Store();
            OrderCart plant = OrderCart();
            staff = User.fetchInfo(data['showStaffModel']);
            customer = User.fetchInfo(data['showCustomerModel']);
            distance = Distance.fromJson(data['showDistancePriceModel']);
            store = Store.fromJson(data['showStoreModel']);
            plant = OrderCart.fromJson(data['showPlantModel'][0]);

            _order = OrderObject.fromJson(
                data, staff, customer, distance, store, plant);
            list.add(_order!);
          }
        }
        _list = list;
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

  Future<bool> getDistancePrice() async {
    bool result = false;
    var header = getheader(getTokenAuthenFromSharedPrefs());
    try {
      final res =
          await http.get(Uri.parse(mainURL + distanceURL), headers: header);
      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          var jsondata = json.decode(res.body);
          _distancePrice = Distance.fromJson(jsondata);
          result = true;
          notifyListeners();
        }
      }
      notifyListeners();
    } on HttpException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    return result;
  }

  Future<bool> createOrder(order) async {
    bool result = false;
    var body = json.encode(order);
    var header = getheader(getTokenAuthenFromSharedPrefs());
    try {
      final res = await http.post(Uri.parse(mainURL + orderURL),
          headers: header, body: body);
      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          result = true;

          notifyListeners();
        }
      }
      notifyListeners();
    } on HttpException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    return result;
  }

  Future<bool> getOrderStatus() async {
    bool result = false;
    List<String> enumStatus = [];
    var header = getheader(getTokenAuthenFromSharedPrefs());
    try {
      final res =
          await http.get(Uri.parse(mainURL + orderStatus), headers: header);
      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          var jsondata = json.decode(res.body);
          enumStatus.add('ALL');
          for (var data in jsondata) {
            enumStatus.add(data);
          }
          _enumStatus = enumStatus;
          result = true;
          notifyListeners();
        }
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