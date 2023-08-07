import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/authentication/user.dart';
import 'package:thanhhoa_garden/models/bonsaiImg.dart';
import 'package:thanhhoa_garden/models/service/service.dart';
import 'package:thanhhoa_garden/models/store/store.dart';

class Contact {
  late final id;
  late final title;
  late final fullName;
  late final email;
  late final phone;
  late final address;
  late final paymentMethod;
  late final reason;
  late final createdDate;
  late final startedDate;
  late final endedDate;
  late final approvedDate;
  late final rejectedDate;
  late final deposit;
  late final total;
  late final isFeedback;
  late final isSigned;
  late final status;
  late final isPaid;
  late final totalPage;
  List<ImageURL2>? imgList;
  User? showStaffModel;
  User? showCustomerModel;
  Store? showStoreModel;
  PaymentType? showPaymentTypeModel;

  Contact(
      {this.id,
      this.title,
      this.fullName,
      this.email,
      this.phone,
      this.address,
      this.approvedDate,
      this.createdDate,
      this.deposit,
      this.endedDate,
      this.imgList,
      this.isFeedback,
      this.isPaid,
      this.isSigned,
      this.paymentMethod,
      this.reason,
      this.rejectedDate,
      this.showCustomerModel,
      this.showPaymentTypeModel,
      this.showStaffModel,
      this.showStoreModel,
      this.startedDate,
      this.status,
      this.total,
      this.totalPage});

  Contact.fromJson(Map<String, dynamic> json) {
    List<ImageURL2> Img = [];
    id = json["id"];
    title = json["title"];
    fullName = json["fullName"];
    email = json["email"];
    phone = json["phone"];
    address = json["address"];
    approvedDate = json["approvedDate"];
    createdDate = json["createdDate"];
    deposit = json["deposit"];
    endedDate = json["endedDate"];
    isFeedback = json['isFeedback'];
    isPaid = json['isPaid'];
    isSigned = json['isSigned'];
    paymentMethod = json['paymentMethod'];
    reason = json['reason'];
    rejectedDate = json['rejectedDate'];
    startedDate = json['startedDate'];
    status = json['status'];
    total = json['total'];
    totalPage = json['totalPage'];

    for (var data in json['imgList']) {
      Img.add(ImageURL2.fromJson(data));
    }
    if (json['imgList'] == null) {
      Img.add(ImageURL2(url: NoIMG, id: 0));
    }
    imgList = Img;
    showCustomerModel = User.fetchInfo(json['showCustomerModel']);
    showStaffModel = User.fetchInfo(json['showStaffModel']);
    showPaymentTypeModel = PaymentType.fromJson(json['showPaymentTypeModel']);
    showStoreModel = Store.fromJson(json['showStoreModel']);
  }
}

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

class PaymentType {
  late final id;
  late final name;
  late final value;

  PaymentType({this.id, this.name, this.value});

  PaymentType.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    value = json["value"];
  }
}

class ContactDetail {
  late final id;
  late final note;
  late final timeWorking;
  late final totalPrice;
  late final servicePackID;
  late final serviceTypeID;
  late final startDate;
  late final endDate;
  late final totalPage;
  late Service? serviceModel;
  late TypeService? serviceTypeModel;
  late ServicePack? servicePackModel;
  late Contact? contactModel;

  ContactDetail(
      {this.id,
      this.endDate,
      this.startDate,
      this.note,
      this.servicePackID,
      this.serviceTypeID,
      this.timeWorking,
      this.totalPrice,
      this.totalPage,
      this.serviceModel,
      this.serviceTypeModel,
      this.contactModel,
      this.servicePackModel});

  ContactDetail.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    id = json['id'];
    timeWorking = json['timeWorking'];
    totalPrice = json['totalPrice'];
    servicePackID = json['servicePackID'];
    serviceTypeID = json['serviceTypeID'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    totalPage = json['totalPage'];
    serviceModel = Service.fromJson(json['serviceModel']);
    serviceTypeModel = TypeService.fromJson(json['serviceTypeModel']);
    servicePackModel = ServicePack.fromJson(json['servicePackModel']);
  }
  ContactDetail.fromJson2(Map<String, dynamic> json) {
    id = json['id'];
    note = json['note'];
    timeWorking = json['timeWorking'];
    totalPrice = json['totalPrice'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    totalPage = json['totalPage'];
    serviceModel = Service.fromJson2(json['showServiceModel']);
    serviceTypeModel = TypeService.fromJson2(json['showServiceTypeModel']);
    servicePackModel = ServicePack.fromJsonModel(json['showServicePackModel']);
    contactModel = Contact.fromJson(json['showContractModel']);
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
    json['totalPage'] = contactDetail.totalPage;
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
