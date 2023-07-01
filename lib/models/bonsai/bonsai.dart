// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_plantIDentifier_names

import 'package:thanhhoa_garden/models/bonsaiImg.dart';
import 'package:thanhhoa_garden/models/bonsai/plantCategory.dart';
import 'package:thanhhoa_garden/models/bonsai/plantShipPrice.dart';

class Bonsai {
  late final plantID;
  late final careNote;
  late final description;
  late final height;
  late final name;
  late final price;
  late final status;
  late final withPot;
  late final totalPage;
  late PlantShipPrice? plantShipPrice;
  late List<PlantCategory>? listCate;
  late List<ImageURL>? listImg;

  Bonsai(
      {this.plantID,
      this.careNote,
      this.description,
      this.height,
      this.name,
      this.price,
      this.status,
      this.withPot,
      this.totalPage,
      this.plantShipPrice,
      this.listCate,
      this.listImg});

  Bonsai.fromJson(Map<String, dynamic> json, PlantShipPrice ShipPrice,
      List<PlantCategory> listCateory, List<ImageURL>? listImgage) {
    plantID = json["plantID"];
    careNote = json["careNote"];
    description = json["description"];
    height = json["height"];
    name = json["name"];
    price = json["showPlantPriceModel"]["price"];
    status = json["status"];
    withPot = json["withPot"];
    totalPage = json["totalPage"];
    plantShipPrice = ShipPrice;
    listCate = listCateory;
    listImg = listImgage;
  }
}
