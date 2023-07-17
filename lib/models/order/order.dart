import 'package:thanhhoa_garden/models/authentication/user.dart';
import 'package:thanhhoa_garden/models/cart/cart.dart';
import 'package:thanhhoa_garden/models/order/distance.dart';
import 'package:thanhhoa_garden/models/store/store.dart';

class OrderObject {
  late final id;
  late final fullName;
  late final email;
  late final phone;
  late final address;
  late final paymentMethod;
  late final progressStatus;
  late final reason;
  late final createdDate;
  late final packageDate;
  late final deliveryDate;
  late final receivedDate;
  late final approveDate;
  late final rejectDate;
  late final latLong;
  late final distance;
  late final totalShipCost;
  late final total;
  late final status;
  late final numOfPlant;
  late User? showStaffModel;
  late User? showCustomerModel;
  late Distance? showDistancePriceModel;
  late Store? showStoreModel;
  late OrderCart? showPlantModel;
  late final totalPage;

  OrderObject({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.address,
    this.paymentMethod,
    this.progressStatus,
    this.reason,
    this.createdDate,
    this.packageDate,
    this.deliveryDate,
    this.receivedDate,
    this.approveDate,
    this.rejectDate,
    this.latLong,
    this.distance,
    this.totalShipCost,
    this.total,
    this.status,
    this.showStaffModel,
    this.showCustomerModel,
    this.showDistancePriceModel,
    this.showStoreModel,
    this.showPlantModel,
    this.totalPage,
    this.numOfPlant,
  });

  OrderObject.fromJson(
    Map<String, dynamic> json,
    User? StaffModel,
    User? CustomerModel,
    Distance? DistancePriceModel,
    Store? StoreModel,
    OrderCart? PlantModel,
  ) {
    id = json["id"];
    fullName = json["fullName"];
    email = json["email"];
    phone = json["phone"];
    address = json["address"];
    paymentMethod = json["paymentMethod"];
    progressStatus = json["progressStatus"];
    reason = json["reason"];
    createdDate = json["createdDate"];
    packageDate = json["packageDate"];
    deliveryDate = json["deliveryDate"];
    receivedDate = json["receivedDate"];
    approveDate = json["approveDate"];
    rejectDate = json["rejectDate"];
    latLong = json["latLong"];
    distance = json["distance"];
    total = json["total"];
    status = json["status"];
    showStaffModel = StaffModel;
    showCustomerModel = CustomerModel;
    showDistancePriceModel = DistancePriceModel;
    showStoreModel = StoreModel;
    showPlantModel = PlantModel;
    totalPage = json["totalPage"];
    numOfPlant = json["numOfPlant"];
  }

  Map<String, dynamic> createOrder(List<Map<String, dynamic>> plant,
      String StoreID, String DistancePriceID) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['paymentMethod'] = paymentMethod;
    data['distance'] = distance;
    data['storeID'] = StoreID;
    data['distancePriceID'] = DistancePriceID;
    data['detailList'] = plant;
    return data;
  }
}
