import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:thanhhoa_garden/models/bonsaiImg.dart';
import 'package:thanhhoa_garden/models/service/service.dart';
import 'package:http/http.dart' as http;
import 'package:thanhhoa_garden/utils/connection/utilsConnection.dart';
import 'package:thanhhoa_garden/utils/helper/shared_prefs.dart';

class ServiceProvider extends ChangeNotifier {
  Service? _service;
  List<Service>? _listSeriver;

  Service? get service => _service;

  List<Service>? get listService => _listSeriver;

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
            List<ImageURL> imglist = [];
            List<TypeService> typeList = [];
            var listImge = data['imgList'];
            for (var listdata in listImge) {
              imglist.add(ImageURL.fromJson(listdata));
            }
            var listType = data['typeList'];
            for (var data in listType) {
              typeList.add(TypeService.fromJson(data));
            }
            _service = Service.fromJson(data, typeList, imglist);
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
}
