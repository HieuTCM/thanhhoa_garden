import 'package:json_annotation/json_annotation.dart';
part 'working_date.g.dart';

@JsonSerializable()

class WorkingDate {
  String? id;
  String? workingDate;
  String? contractID;
  String? fullName;
  String? address;
  String? phone;
  String? email;
  String? contractDetailID;
  String? timeWorking;
  String? note;
  String? startDate;
  String? endDate;
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
  int? totalPage;

  WorkingDate(
      {this.id,
        this.workingDate,
        this.contractID,
        this.fullName,
        this.address,
        this.phone,
        this.email,
        this.contractDetailID,
        this.timeWorking,
        this.note,
        this.startDate,
        this.endDate,
        this.totalPrice,
        this.serviceID,
        this.serviceName,
        this.serviceTypeID,
        this.typeName,
        this.typePercentage,
        this.typeSize,
        this.typeApplyDate,
        this.servicePackID,
        this.packRange,
        this.packPercentage,
        this.packApplyDate,
        this.totalPage});

  factory WorkingDate.fromJson(Map<String, dynamic> json) => _$WorkingDateFromJson(json);

  Map<String, dynamic> toJson() => _$WorkingDateToJson(this);
}