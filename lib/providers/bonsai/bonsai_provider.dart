// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:thanhhoa_garden/models/bonsai/bonsai.dart';
import 'package:thanhhoa_garden/models/bonsai/bonsaiImg.dart';
import 'package:thanhhoa_garden/models/bonsai/plantCategory.dart';
import 'package:thanhhoa_garden/models/bonsai/plantShipPrice.dart';

class BonsaiProvider extends ChangeNotifier {
  Bonsai? _bonsai;
  List<Bonsai>? _listBonsai;

  Bonsai? get bonsai => _bonsai;
  List<Bonsai>? get listBonsai => _listBonsai;

  Future<bool> getAllBonsai() async {
    bool result = false;
    List<Bonsai> list = [];
    // Simulate an asynchronous API call
    int status = 404;
    try {
      await Future.delayed(const Duration(seconds: 2))
          .then((value) => {status = 200});
      if (status == 200) {
        if (bonsaiJson.isNotEmpty) {
          for (var data in bonsaiJson) {
            PlantShipPrice plantShipPrice = PlantShipPrice();
            List<PlantCategory> listCategory = [];
            List<PlantImage> listImg = [];
            var shipPriceData = data["plant_ship_price"];
            var categoryData = data["plant_category"];
            var imgData = data["list_img"];
            if (shipPriceData is Map) {
              plantShipPrice = PlantShipPrice.fromJson(shipPriceData);
            }

            if (categoryData is List) {
              for (var cataData in categoryData) {
                listCategory.add(PlantCategory.fromJson(cataData));
              }
            }

            if (imgData is List) {
              for (var img in imgData) {
                listImg.add(PlantImage.fromJson(img));
              }
            }

            _bonsai =
                Bonsai.fromJson(data, plantShipPrice, listCategory, listImg);
            list.add(_bonsai!);
          }
        }
        _listBonsai = list;
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

  Future<bool> searchBonsai() async {
    bool result = false;
    List<Bonsai> list = [];
    // Simulate an asynchronous API call
    int status = 404;
    try {
      await Future.delayed(const Duration(seconds: 2))
          .then((value) => {status = 200});
      if (status == 200) {
        if (bonsaiSearchJson.isNotEmpty) {
          for (var data in bonsaiSearchJson) {
            PlantShipPrice plantShipPrice = PlantShipPrice();
            List<PlantCategory> listCategory = [];
            List<PlantImage> listImg = [];
            var shipPriceData = data["plant_ship_price"];
            var categoryData = data["plant_category"];
            var imgData = data["list_img"];
            if (shipPriceData is Map) {
              plantShipPrice = PlantShipPrice.fromJson(shipPriceData);
            }

            if (categoryData is List) {
              for (var cataData in categoryData) {
                listCategory.add(PlantCategory.fromJson(cataData));
              }
            }

            if (imgData is List) {
              for (var img in imgData) {
                listImg.add(PlantImage.fromJson(img));
              }
            }

            _bonsai =
                Bonsai.fromJson(data, plantShipPrice, listCategory, listImg);
            list.add(_bonsai!);
          }
        }
        _listBonsai = list;
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
