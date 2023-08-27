import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thanhhoa_garden/models/notification/notification.dart';
import 'package:thanhhoa_garden/utils/connection/utilsConnection.dart';
import 'package:thanhhoa_garden/utils/helper/shared_prefs.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationModel? _notification;
  List<NotificationModel>? _listNotification = [];

  NotificationModel? get notification => _notification;
  List<NotificationModel>? get list => _listNotification;

  int? _countNotRead = 0;
  int? get countNotRead => _countNotRead;

  Future<bool> getAllNotification() async {
    bool result = false;
    List<NotificationModel> list = [];

    var header = getheader(getTokenAuthenFromSharedPrefs());
    try {
      final res =
          await http.get(Uri.parse(mainURL + getNotiURL), headers: header);
      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          var jsondata = json.decode(res.body);
          for (var data in jsondata) {
            _notification = NotificationModel.fromJson(data);
            list.add(_notification!);
          }
        }
        _listNotification = list;
        _countNotRead = list.where((element) => element.isRead == false).length;
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

  Future<bool> checkAllNotification() async {
    bool result = false;
    var header = getheader(getTokenAuthenFromSharedPrefs());
    try {
      final res =
          await http.put(Uri.parse(mainURL + setIsReadAllURL), headers: header);
      if (res.statusCode == 200) {
        await getAllNotification();
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
