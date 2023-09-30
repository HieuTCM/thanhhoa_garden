import 'package:thanhhoa_garden/models/authentication/user.dart';
import 'package:thanhhoa_garden/models/service/service.dart';
import 'package:thanhhoa_garden/models/workingDate/working_date.dart';

class ReportModel {
  late final id;
  late final description;
  late final reason;
  late final status;
  late final createdDate;
  late final contractID;
  late final contractDetailID;
  late final timeWorking;
  WorkingDate? showWorkingDateModel;
  TypeService? showServiceTypeModel;
  Service? showServiceModel;
  User? showCustomerModel;
  User? showStaffModel;
  late final totalPage;

  ReportModel({
    this.id,
    this.description,
    this.reason,
    this.status,
    this.createdDate,
    this.contractID,
    this.contractDetailID,
    this.timeWorking,
    this.showWorkingDateModel,
    this.showServiceTypeModel,
    this.showServiceModel,
    this.showCustomerModel,
    this.showStaffModel,
    this.totalPage,
  });

  ReportModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    description = json["description"];
    reason = json["reason"];
    status = json["status"];
    createdDate = json["createdDate"];
    contractID = json["contractID"];
    contractDetailID = json["contractDetailID"];
    timeWorking = json["timeWorking"];
    showWorkingDateModel = WorkingDate.fromJson2(json["showWorkingDateModel"]);
    showServiceTypeModel = TypeService.fromJson2(json["showServiceTypeModel"]);
    showServiceModel = Service.fromJson2(json["showServiceModel"]);
    showCustomerModel = User.fetchInfo(json["showCustomerModel"]);
    showStaffModel = User.fetchInfo(json["showStaffModel"]);
    totalPage = json["totalPage"];
  }
}
