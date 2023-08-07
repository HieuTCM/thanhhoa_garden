import 'package:json_annotation/json_annotation.dart';
part 'schedule_today.g.dart';

@JsonSerializable()
class ScheduleToday {
  String? id;
  String? timeWorking;
  String? note;
  String? startDate;
  String? endDate;
  double? totalPrice;
  ShowContractModel? showContractModel;
  ShowServiceTypeModel? showServiceTypeModel;
  ShowServiceModel? showServiceModel;
  ShowServicePackModel? showServicePackModel;
  List<WorkingDateList>? workingDateList;

  ScheduleToday(
      {this.id,
        this.timeWorking,
        this.note,
        this.startDate,
        this.endDate,
        this.totalPrice,
        this.showContractModel,
        this.showServiceTypeModel,
        this.showServiceModel,
        this.showServicePackModel,
        this.workingDateList});

  factory ScheduleToday.fromJson(Map<String, dynamic> json) => _$ScheduleTodayFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleTodayToJson(this);
}

@JsonSerializable()
class ShowContractModel {
  String? id;
  String? title;
  String? fullName;
  String? email;
  String? phone;
  String? address;
  String? paymentMethod;
  String? reason;
  String? createdDate;
  String? startedDate;
  String? endedDate;
  String? approvedDate;
  String? rejectedDate;
  double? deposit;
  double? total;
  bool? isFeedback;
  bool? isSigned;
  String? status;
  List<ImgList>? imgList;
  String? showStaffModel;
  String? showCustomerModel;
  String? showStoreModel;
  String? showPaymentTypeModel;

  ShowContractModel(
      {this.id,
        this.title,
        this.fullName,
        this.email,
        this.phone,
        this.address,
        this.paymentMethod,
        this.reason,
        this.createdDate,
        this.startedDate,
        this.endedDate,
        this.approvedDate,
        this.rejectedDate,
        this.deposit,
        this.total,
        this.isFeedback,
        this.isSigned,
        this.status,
        this.imgList,
        this.showStaffModel,
        this.showCustomerModel,
        this.showStoreModel,
        this.showPaymentTypeModel});

  factory ShowContractModel.fromJson(Map<String, dynamic> json) => _$ShowContractModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShowContractModelToJson(this);
}

@JsonSerializable()
class ImgList {
  String? id;
  String? imgUrl;

  ImgList({this.id, this.imgUrl});
  factory ImgList.fromJson(Map<String, dynamic> json) => _$ImgListFromJson(json);

  Map<String, dynamic> toJson() => _$ImgListToJson(this);
}

@JsonSerializable()
class ShowServiceTypeModel {
  String? id;
  String? typeName;
  int? typePercentage;
  String? typeSize;
  String? typeApplyDate;

  ShowServiceTypeModel(
      {this.id,
        this.typeName,
        this.typePercentage,
        this.typeSize,
        this.typeApplyDate});

  factory ShowServiceTypeModel.fromJson(Map<String, dynamic> json) => _$ShowServiceTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShowServiceTypeModelToJson(this);
}

@JsonSerializable()
class ShowServiceModel {
  String? id;
  String? name;
  String? description;
  double? price;

  ShowServiceModel({this.id, this.name, this.description, this.price});

  factory ShowServiceModel.fromJson(Map<String, dynamic> json) => _$ShowServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShowServiceModelToJson(this);
}

@JsonSerializable()
class ShowServicePackModel {
  String? id;
  String? packRange;
  int? packPercentage;
  String? packApplyDate;

  ShowServicePackModel(
      {this.id, this.packRange, this.packPercentage, this.packApplyDate});

  factory ShowServicePackModel.fromJson(Map<String, dynamic> json) => _$ShowServicePackModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShowServicePackModelToJson(this);
}

@JsonSerializable()
class WorkingDateList {
  String? id;
  String? workingDate;

  WorkingDateList({this.id, this.workingDate});

  factory WorkingDateList.fromJson(Map<String, dynamic> json) => _$WorkingDateListFromJson(json);

  Map<String, dynamic> toJson() => _$WorkingDateListToJson(this);
}