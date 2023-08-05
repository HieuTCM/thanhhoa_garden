import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:thanhhoa_garden/models/service/service.dart';
import 'package:http/http.dart' as http;
import 'package:thanhhoa_garden/utils/connection/utilsConnection.dart';
import 'package:thanhhoa_garden/utils/helper/shared_prefs.dart';

class ServiceProvider extends ChangeNotifier {
  Service? _service;
  ServicePack? _servicePack;
  List<Service>? _listSeriver;
  List<ServicePack>? _listSeriverPack;

  Service? get service => _service;
  ServicePack? get servicePack => _servicePack;
  List<Service>? get listService => _listSeriver;
  List<ServicePack>? get listSeriverPack => _listSeriverPack;

  Future<bool> getAllService() async {
    bool result = false;
    List<Service> list = [];
    var header = getheader(getTokenAuthenFromSharedPrefs());
    try {
      final res =
          await http.get(Uri.parse(mainURL + getServiceURL), headers: header);
      if (res.statusCode == 200) {
        //  var jsonData = json.decode(serviceJson);

        if (res.body.isNotEmpty) {
          var jsondata = json.decode(res.body);
          for (var data in jsondata) {
            _service = Service.fromJson(data);
            list.add(_service!);
          }
        }

        _listSeriver = list;
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

  Future<bool> getAllServicePack() async {
    bool result = false;
    List<ServicePack> list = [];
    var header = getheader(getTokenAuthenFromSharedPrefs());
    try {
      final res = await http.get(Uri.parse(mainURL + getServicePackURL),
          headers: header);
      if (res.statusCode == 200) {
        //  var jsonData = json.decode(serviceJson);

        if (res.body.isNotEmpty) {
          var jsondata = json.decode(res.body);
          for (var data in jsondata) {
            _servicePack = ServicePack.fromJson(data);
            list.add(_servicePack!);
          }
        }
        _listSeriverPack = list;
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
