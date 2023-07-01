// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:thanhhoa_garden/models/bonsaiImg.dart';

class Service {
  late final serviceID;
  late final description;
  late final name;
  late final price;
  late final status;
  List<ImageURL>? listImg;
  List<TypeService>? typeList;

  Service(
      {this.serviceID,
      this.description,
      this.name,
      this.price,
      this.status,
      this.listImg,
      this.typeList});

  Service.fromJson(Map<String, dynamic> json, List<TypeService>? listtype,
      List<ImageURL>? listImage) {
    serviceID = json['serviceID'];
    description = json['description'];
    name = json['name'];
    price = json['price'];
    status = json['status'];
    listImg = listImage;
    typeList = listtype;
  }
}

class TypeService {
  late final id;
  late final name;
  late final size;
  late final percentage;
  late final applyDate;
  late final serviceID;
  TypeService(
      {this.id,
      this.name,
      this.size,
      this.applyDate,
      this.serviceID,
      this.percentage});

  TypeService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    size = json['size'];
    percentage = json['percentage'];
    applyDate = json['applyDate'];
    serviceID = json['serviceID'];
  }
}
