// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/bonsaiImg.dart';

class Service {
  late final serviceID;
  late final description;
  late final name;
  late final price;
  late final status;
  late final atHome;
  late final priceID;
  List<ImageURL>? imgList;
  List<TypeService>? typeList;

  Service(
      {this.serviceID,
      this.description,
      this.name,
      this.price,
      this.status,
      this.imgList,
      this.atHome,
      this.priceID,
      this.typeList});

  Service.fromJson(Map<String, dynamic> json) {
    List<ImageURL> Img = [];
    List<TypeService> Type = [];
    serviceID = json['serviceID'];
    description = json['description'];
    name = json['name'];
    price = json['price'];
    status = json['status'];
    atHome = json['atHome'];
    priceID = json['priceID'];
    for (var data in json['imgList']) {
      if (!data["url"].toString().contains(RegExp(r'SIMG'))) {
        Img.add(ImageURL.fromJson(data));
      }
    }
    if (json['imgList'] == null) {
      Img.add(ImageURL(url: NoIMG, id: 0));
    }
    imgList = Img;
    for (var data in json['typeList']) {
      Type.add(TypeService.fromJson(data));
    }
    typeList = Type;
  }
  Service.fromJson2(Map<String, dynamic> json) {
    serviceID = json['id'];
    name = json['name'];
    description = json['description'];
    priceID = json['priceID'];
    price = json['price'];
    atHome = json['atHome'];
  }
  Map<String, dynamic> toJson(Service service) {
    Map<String, dynamic> json = {};
    List<Map<String, dynamic>> listImg = [];
    List<Map<String, dynamic>> listType = [];
    json["serviceID"] = service.serviceID;
    json["description"] = service.description;
    json["name"] = service.name;
    json["price"] = service.price;
    json["status"] = service.status;
    json["atHome"] = service.atHome;
    json["priceID"] = service.priceID;
    for (var data in service.imgList!) {
      listImg.add(ImageURL().toJson(data));
    }
    json["imgList"] = listImg;
    for (var data in service.typeList!) {
      listType.add(TypeService().toJson(data));
    }
    json["typeList"] = listType;
    return json;
  }
}

class TypeService {
  late final id;
  late final name;
  late final size;
  late final unit;
  late final percentage;
  late final applyDate;
  late final serviceID;
  TypeService(
      {this.id,
      this.name,
      this.size,
      this.unit,
      this.applyDate,
      this.serviceID,
      this.percentage});

  TypeService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    size = json['size'];
    unit = json['unit'];
    percentage = json['percentage'];
    applyDate = json['applyDate'];
    serviceID = json['serviceID'];
  }
  TypeService.fromJson2(Map<String, dynamic> json) {
    id = json['id'];
    name = json['typeName'];
    size = json['typeSize'];
    unit = json['typeUnit'];
    percentage = json['typePercentage'];
    applyDate = json['typeApplyDate'];
  }
  Map<String, dynamic> toJson(TypeService typeService) {
    Map<String, dynamic> json = {};
    json['id'] = typeService.id;
    json['name'] = typeService.name;
    json['size'] = typeService.size;
    json['unit'] = typeService.unit;
    json['percentage'] = typeService.percentage;
    json['applyDate'] = typeService.applyDate;
    json['serviceID'] = typeService.serviceID;
    return json;
  }
}

class ServicePack {
  late final id;
  late final range;
  late final unit;
  late final percentage;
  late final applyDate;
  late final status;

  ServicePack(
      {this.id,
      this.status,
      this.range,
      this.unit,
      this.percentage,
      this.applyDate});

  ServicePack.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    range = json['range'];
    unit = json['unit'];
    percentage = json['percentage'];
    applyDate = json['applyDate'];
    status = json['status'];
  }
  ServicePack.fromJsonModel(Map<String, dynamic> json) {
    id = json['id'];
    range = json['packRange'];
    unit = json['packUnit'];
    percentage = json['packPercentage'];
    applyDate = json['packApplyDate'];
  }
  Map<String, dynamic> toJson(ServicePack servicePack) {
    Map<String, dynamic> json = {};
    json['id'] = servicePack.id;
    json['range'] = servicePack.range;
    json['unit'] = servicePack.unit;
    json['percentage'] = servicePack.percentage;
    json['applyDate'] = servicePack.applyDate;
    json['status'] = servicePack.status;
    return json;
  }
}
