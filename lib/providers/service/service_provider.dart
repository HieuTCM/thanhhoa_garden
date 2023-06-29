import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:thanhhoa_garden/models/bonsai/bonsaiImg.dart';
import 'package:thanhhoa_garden/models/service/service.dart';

class ServiceProvider extends ChangeNotifier {
  Service? _service;
  List<Service>? _listSeriver;

  Service? get service => _service;

  List<Service>? get listService => _listSeriver;

  Future<bool> getAllService() async {
    bool result = false;
    List<Service> list = [];
    // Simulate an asynchronous API call
    int status = 404;
    try {
      await Future.delayed(const Duration(seconds: 2))
          .then((value) => {status = 200});
      if (status == 200) {
        //  var jsonData = json.decode(serviceJson);
        for (var data in serviceJson) {
          List<PlantImage> listImg = [];
          var imgData = data["list_img"];
          if (imgData is List) {
            for (var img in imgData) {
              listImg.add(PlantImage.fromJson(img));
            }
          }

          _service = Service.fromJson(data, listImg);
          list.add(_service!);
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
