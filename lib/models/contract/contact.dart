import 'package:thanhhoa_garden/models/service/service.dart';

class Contact {}

class ContactRequest {
  late final title;
  late final fullName;
  late final phone;
  late final address;
  late final storeID;
  late final email;
  List<ContactDetail>? detailModelList;

  ContactRequest(
      {this.title,
      this.fullName,
      this.phone,
      this.address,
      this.storeID,
      this.email,
      this.detailModelList});

  ContactRequest.fromJson(Map<String, dynamic> json) {
    List<ContactDetail> list = [];
    title = json["title"];
    fullName = json["fullName"];
    phone = json["phone"];
    address = json["address"];
    storeID = json["storeID"];
    email = json["email"];
    for (var data in json['detailModelList']) {
      list.add(ContactDetail.fromJson(data));
    }
    detailModelList = list;
  }
  Map<String, dynamic> toJson(ContactRequest contactRequest) {
    Map<String, dynamic> json = {};
    List<Map<String, dynamic>> listService = [];
    json["title"] = contactRequest.title;
    json["fullName"] = contactRequest.fullName;
    json["phone"] = contactRequest.phone;
    json["address"] = contactRequest.address;
    json["storeID"] = contactRequest.storeID;
    json["email"] = contactRequest.email;
    for (var data in contactRequest.detailModelList!) {
      listService.add(ContactDetail().toJsonRequest(data));
    }
    json["detailModelList"] = listService;

    return json;
  }
}
