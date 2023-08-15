import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:thanhhoa_garden/blocs/order/orderEvent.dart';
import 'package:thanhhoa_garden/models/authentication/user.dart';
import 'package:thanhhoa_garden/models/cart/cart.dart';
import 'package:thanhhoa_garden/models/feedback/feedback.dart';
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

  OrderDetail? _orderDetail;
  OrderDetail? get orderDetail => _orderDetail;

  List<OrderDetail>? _detalList;
  List<OrderDetail>? get detalList => _detalList;

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

  Future<String> payment(Map<String, dynamic> map) async {
    String result = '';
    var header = getheader(getTokenAuthenFromSharedPrefs());
    var body = json.encode(map);
    try {
      final res = await http.post(Uri.parse('$mainURL$paymentURL'),
          body: body, headers: header);
      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          result = res.body;
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

  Future<bool> getOrderDetail(String OrderID) async {
    bool result = false;

    List<OrderDetail> list = [];

    var header = getheader(getTokenAuthenFromSharedPrefs());
    try {
      final res = await http.get(
          Uri.parse(mainURL + getOrderDetailURL + OrderID),
          headers: header);
      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          var jsondata = json.decode(res.body);
          for (var data in jsondata) {
            OrderCart plant = OrderCart();
            User showStaffModel = User();
            User showCustomerModel = User();
            Distance showDistancePriceModel = Distance();
            Store showStoreModel = Store();
            FeedbackModel feedback = FeedbackModel();
            plant = OrderCart.fromJson(data['showPlantModel']);
            showStaffModel = User.fetchInfo(data['showStaffModel']);
            showCustomerModel = User.fetchInfo(data['showCustomerModel']);
            showDistancePriceModel =
                Distance.fromJson(data['showDistancePriceModel']);
            showStoreModel = Store.fromJson(data['showStoreModel']);
            if (data['showOrderFeedbackModel'] != null) {
              feedback = FeedbackModel.fromJson(data['showOrderFeedbackModel']);
            }
            _order = OrderObject.fromJson(
                data['showOrderModel'],
                showStaffModel,
                showCustomerModel,
                showDistancePriceModel,
                showStoreModel,
                plant);

            _orderDetail = OrderDetail.fromJson(
                data,
                showStaffModel,
                showCustomerModel,
                showDistancePriceModel,
                showStoreModel,
                plant,
                feedback,
                _order);
            list.add(_orderDetail!);
          }
        }
        _detalList = list;
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

  Future<bool> cancelOrder(OrderEvent event) async {
    bool result = false;
    Map<String, dynamic> param = ({});
    param['orderID'] = '${event.orderID}';
    param['reason'] = '${event.reason}';
    if (event.status != null) param['status'] = event.status;
    String queryString = Uri(queryParameters: param).query;
    var header = getheader(getTokenAuthenFromSharedPrefs());
    try {
      final res = await http.put(
          Uri.parse(mainURL + cancelOrderURL + queryString),
          headers: header);
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

  Future<bool> getOrderDetailByFeedback(OrderEvent event) async {
    bool result = false;

    List<OrderDetail> list = [];
    Map<String, dynamic> param = ({});
    param['isFeedback'] = '${event.isFeedback}';
    param['pageNo'] = '${event.pageNo}';
    param['pageSize'] = '${event.pageSize}';
    param['sortBy'] = event.sortBy;
    param['sortAsc'] = '${event.sortAsc}';

    String queryString = Uri(queryParameters: param).query;
    var header = getheader(getTokenAuthenFromSharedPrefs());
    try {
      final res = await http.get(
          Uri.parse(mainURL + getOrderDetaiByFeedbackStatuslURL + queryString),
          headers: header);
      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          var jsondata = json.decode(res.body);
          for (var data in jsondata) {
            OrderCart plant = OrderCart();
            User showStaffModel = User();
            User showCustomerModel = User();
            Distance showDistancePriceModel = Distance();
            Store showStoreModel = Store();
            FeedbackModel feedback = FeedbackModel();
            plant = OrderCart.fromJson(data['showPlantModel']);
            showStaffModel = User.fetchInfo(data['showStaffModel']);
            showCustomerModel = User.fetchInfo(data['showCustomerModel']);
            showDistancePriceModel =
                Distance.fromJson(data['showDistancePriceModel']);
            showStoreModel = Store.fromJson(data['showStoreModel']);
            feedback = FeedbackModel.fromJson(data['showOrderFeedbackModel']);
            _order = OrderObject.fromJson(
                data['showOrderModel'],
                showStaffModel,
                showCustomerModel,
                showDistancePriceModel,
                showStoreModel,
                plant);

            _orderDetail = OrderDetail.fromJson(
                data,
                showStaffModel,
                showCustomerModel,
                showDistancePriceModel,
                showStoreModel,
                plant,
                feedback,
                _order);
            list.add(_orderDetail!);
          }
        }
        _detalList = list;
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
