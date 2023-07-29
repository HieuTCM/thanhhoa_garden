// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/bonsaiImg.dart';

class Service {
  late final serviceID;
  late final description;
  late final name;
  late final price;
  late final status;
  List<ImageURL>? imgList;
  List<TypeService>? typeList;

  Service(
      {this.serviceID,
      this.description,
      this.name,
      this.price,
      this.status,
      this.imgList,
      this.typeList});

  Service.fromJson(Map<String, dynamic> json) {
    List<ImageURL> Img = [];
    List<TypeService> Type = [];
    serviceID = json['serviceID'];
    description = json['description'];
    name = json['name'];
    price = json['price'];
    status = json['status'];
    for (var data in json['imgList']) {
      Img.add(ImageURL.fromJson(data));
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
  Map<String, dynamic> toJson(Service service) {
    Map<String, dynamic> json = {};
    List<Map<String, dynamic>> listImg = [];
    List<Map<String, dynamic>> listType = [];
    json["serviceID"] = service.serviceID;
    json["description"] = service.description;
    json["name"] = service.name;
    json["price"] = service.price;
    json["status"] = service.status;
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
  Map<String, dynamic> toJson(TypeService typeService) {
    Map<String, dynamic> json = {};
    json['id'] = typeService.id;
    json['name'] = typeService.name;
    json['size'] = typeService.size;
    json['percentage'] = typeService.percentage;
    json['applyDate'] = typeService.applyDate;
    json['serviceID'] = typeService.serviceID;
    return json;
  }
}

class ServicePack {
  late final id;
  late final range;
  late final percentage;
  late final applyDate;
  late final status;

  ServicePack(
      {this.id, this.status, this.range, this.percentage, this.applyDate});

  ServicePack.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    range = json['range'];
    percentage = json['percentage'];
    applyDate = json['applyDate'];
    status = json['status'];
  }
  Map<String, dynamic> toJson(ServicePack servicePack) {
    Map<String, dynamic> json = {};
    json['id'] = servicePack.id;
    json['range'] = servicePack.range;
    json['percentage'] = servicePack.percentage;
    json['applyDate'] = servicePack.applyDate;
    json['status'] = servicePack.status;
    return json;
  }
}

class ContactDetail {
  late final note;
  late final timeWorking;
  late final totalPrice;
  late final servicePackID;
  late final serviceTypeID;
  late final startDate;
  late final endDate;
  late Service? serviceModel;
  late TypeService? serviceTypeModel;
  late ServicePack? servicePackModel;

  ContactDetail(
      {this.endDate,
      this.startDate,
      this.note,
      this.servicePackID,
      this.serviceTypeID,
      this.timeWorking,
      this.totalPrice,
      this.serviceModel,
      this.serviceTypeModel,
      this.servicePackModel});

  ContactDetail.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    timeWorking = json['timeWorking'];
    totalPrice = json['totalPrice'];
    servicePackID = json['servicePackID'];
    serviceTypeID = json['serviceTypeID'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    serviceModel = Service.fromJson(json['serviceModel']);
    serviceTypeModel = TypeService.fromJson(json['serviceTypeModel']);
    servicePackModel = ServicePack.fromJson(json['servicePackModel']);
  }

  Map<String, dynamic> toJson(ContactDetail contactDetail) {
    Map<String, dynamic> json = {};
    json['note'] = contactDetail.note;
    json['timeWorking'] = contactDetail.timeWorking;
    json['totalPrice'] = contactDetail.totalPrice;
    json['servicePackID'] = contactDetail.servicePackID;
    json['serviceTypeID'] = contactDetail.serviceTypeID;
    json['startDate'] = contactDetail.startDate;
    json['endDate'] = contactDetail.endDate;
    json['serviceModel'] = Service().toJson(contactDetail.serviceModel!);
    json['serviceTypeModel'] =
        TypeService().toJson(contactDetail.serviceTypeModel!);
    json['servicePackModel'] =
        ServicePack().toJson(contactDetail.servicePackModel!);
    return json;
  }

  Map<String, dynamic> toJsonRequest(ContactDetail contactDetail) {
    Map<String, dynamic> json = {};
    json['note'] = contactDetail.note;
    json['timeWorking'] = contactDetail.timeWorking;
    json['totalPrice'] = contactDetail.totalPrice;
    json['servicePackID'] = contactDetail.servicePackID;
    json['serviceTypeID'] = contactDetail.serviceTypeID;
    json['startDate'] = contactDetail.startDate;
    json['endDate'] = contactDetail.endDate;
    return json;
  }
}
