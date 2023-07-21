// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thanhhoa_garden/blocs/bonsai/bonsai_event.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/bonsai/bonsai.dart';
import 'package:thanhhoa_garden/models/bonsaiImg.dart';
import 'package:thanhhoa_garden/models/bonsai/plantCategory.dart';
import 'package:thanhhoa_garden/models/bonsai/plantShipPrice.dart';
import 'package:thanhhoa_garden/utils/connection/utilsConnection.dart';
import 'package:thanhhoa_garden/utils/helper/shared_prefs.dart';
import 'package:http/http.dart' as http;

class BonsaiProvider extends ChangeNotifier {
  Bonsai? _bonsai;
  List<Bonsai>? _listBonsai;

  Bonsai? get bonsai => _bonsai;
  List<Bonsai>? get listBonsai => _listBonsai;

  Future<bool> fetchBonsaiList(BonsaiEvent event) async {
    bool result = false;
    List<Bonsai> list = [];

    Map<String, dynamic> param = ({});
    param['pageNo'] = '${event.pageNo}';
    param['pageSize'] = '${event.pageSize}';
    param['sortBy'] = event.sortBy;
    param['sortAsc'] = '${event.sortAsc}';
    if (event.plantName != null) param['plantName'] = event.plantName;
    if (event.categoryID != null && event.categoryID != '')
      param['categoryID'] = event.categoryID;
    if (event.min != null) param['min'] = '${event.min}';
    if (event.max != null) param['max'] = '${event.max}';

    String queryString = Uri(queryParameters: param).query;

    var header = getheader(getTokenAuthenFromSharedPrefs());
    try {
      final res = await http.get(
          Uri.parse(mainURL + getListPlantURL + queryString),
          headers: header);
      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          var jsondata = json.decode(res.body);

          for (var data in jsondata) {
            PlantShipPrice plantShipPrice = PlantShipPrice();
            List<PlantCategory> listCategory = [];
            List<ImageURL> listImg = [];
            plantShipPrice =
                PlantShipPrice.fromJson(data['showPlantShipPriceModel']);
            for (var category in data['plantCategoryList']) {
              listCategory.add(PlantCategory.fromJson(category));
            }
            var imgData = data['plantIMGList'];
            if (imgData is List) {
              if (imgData.isNotEmpty) {
                for (var img in data['plantIMGList']) {
                  listImg.add(ImageURL.fromJson(img));
                }
              } else {
                ImageURL img = ImageURL(url: NoIMG);
                listImg.add(img);
              }
            }

            _bonsai =
                Bonsai.fromJson(data, plantShipPrice, listCategory, listImg);
            list.add(_bonsai!);
          }
          // var shipPriceData = data["plant_ship_price"];
          // var categoryData = data["plant_category"];
          // var imgData = data["list_img"];
          // if (shipPriceData is Map) {
          //   plantShipPrice = PlantShipPrice.fromJson(shipPriceData);
          // }

          // if (categoryData is List) {
          //   for (var cataData in categoryData) {
          //     listCategory.add(PlantCategory.fromJson(cataData));
          //   }
          // }

          // if (imgData is List) {
          //   for (var img in imgData) {
          //     listImg.add(ImageURL.fromJson(img));
          //   }
          // }

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
        // if (bonsaiSearchJson.isNotEmpty) {
        //   for (var data in bonsaiSearchJson) {
        //     PlantShipPrice plantShipPrice = PlantShipPrice();
        //     List<PlantCategory> listCategory = [];
        //     List<ImageURL> listImg = [];
        //     var shipPriceData = data["plant_ship_price"];
        //     var categoryData = data["plant_category"];
        //     var imgData = data["list_img"];
        //     if (shipPriceData is Map) {
        //       plantShipPrice = PlantShipPrice.fromJson(shipPriceData);
        //     }

        //     if (categoryData is List) {
        //       for (var cataData in categoryData) {
        //         listCategory.add(PlantCategory.fromJson(cataData));
        //       }
        //     }

        //     if (imgData is List) {
        //       for (var img in imgData) {
        //         listImg.add(ImageURL.fromJson(img));
        //       }
        //     }

        //     _bonsai =
        //         Bonsai.fromJson(data, plantShipPrice, listCategory, listImg);
        //     list.add(_bonsai!);
        //   }
        // }
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
