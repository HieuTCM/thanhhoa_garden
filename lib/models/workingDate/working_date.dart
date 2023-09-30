import 'package:json_annotation/json_annotation.dart';
import 'package:thanhhoa_garden/models/authentication/user.dart';
part 'working_date.g.dart';

@JsonSerializable()
class WorkingDate {
  String? id;
  String? workingDate;
  String? startWorking;
  String? endWorking;
  String? startWorkingIMG;
  String? endWorkingIMG;
  String? status;
  String? contractID;
  String? title;
  String? fullName;
  String? address;
  String? phone;
  String? email;
  String? contractDetailID;
  String? timeWorking;
  String? note;
  String? startDate;
  String? endDate;
  String? expectedEndDate;
  String? typeUnit;
  double? totalPrice;
  String? serviceID;
  String? serviceName;
  String? serviceTypeID;
  String? typeName;
  int? typePercentage;
  String? typeSize;
  String? typeApplyDate;
  String? servicePackID;
  String? packRange;
  int? packPercentage;
  String? packApplyDate;
  String? packUnit;
  User? showStaffModel;
  bool? isReported;
  int? totalPage;

  WorkingDate(
      {this.id,
      this.workingDate,
      this.startWorking,
      this.endWorking,
      this.startWorkingIMG,
      this.endWorkingIMG,
      this.status,
      this.contractID,
      this.title,
      this.fullName,
      this.address,
      this.phone,
      this.email,
      this.isReported,
      this.contractDetailID,
      this.timeWorking,
      this.note,
      this.startDate,
      this.endDate,
      this.expectedEndDate,
      this.totalPrice,
      this.serviceID,
      this.serviceName,
      this.serviceTypeID,
      this.typeName,
      this.typePercentage,
      this.typeSize,
      this.typeApplyDate,
      this.packUnit,
      this.typeUnit,
      this.servicePackID,
      this.packRange,
      this.packPercentage,
      this.packApplyDate,
      this.showStaffModel,
      this.totalPage});

  WorkingDate.fromJson2(Map<String, dynamic> json) {
    id = json["id"];
    workingDate = json["workingDate"];
    startWorking = json["startWorking"];
    endWorking = json["endWorking"];
    startWorkingIMG = json["startWorkingIMG"];
    endWorkingIMG = json["endWorkingIMG"];
    status = json["status"];
    contractID = json["contractID"];
    title = json["title"];
    fullName = json["fullName"];
    address = json["address"];
    phone = json["phone"];
    email = json["email"];
    contractDetailID = json["contractDetailID"];
    timeWorking = json["timeWorking"];
    note = json["note"];
    startDate = json["startDate"];
    endDate = json["endDate"];
    expectedEndDate = json["expectedEndDate"];
    totalPrice = json["totalPrice"];
    serviceID = json["serviceID"];
    serviceName = json["serviceName"];
    serviceTypeID = json["serviceTypeID"];
    typeName = json["typeName"];
    typePercentage = json["typePercentage"];
    typeSize = json["typeSize"];
    typeUnit = json["typeUnit"];
    typeApplyDate = json["typeApplyDate"];
    servicePackID = json["servicePackID"];
    packRange = json["packRange"];
    packPercentage = json["packPercentage"];
    packApplyDate = json["packApplyDate"];
    isReported = json["isReported"];
    packUnit = json["packUnit"];
    showStaffModel = json["showStaffModel"] == null
        ? json["showStaffModel"]
        : User.fetchInfo(json["showStaffModel"]);
    totalPage = json["totalPage"];
  }
  factory WorkingDate.fromJson(Map<String, dynamic> json) =>
      _$WorkingDateFromJson(json);

  Map<String, dynamic> toJson() => _$WorkingDateToJson(this);
}
