// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'working_date.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkingDate _$WorkingDateFromJson(Map<String, dynamic> json) => WorkingDate(
      id: json['id'] as String?,
      workingDate: json['workingDate'] as String?,
      contractID: json['contractID'] as String?,
      fullName: json['fullName'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      contractDetailID: json['contractDetailID'] as String?,
      timeWorking: json['timeWorking'] as String?,
      note: json['note'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      serviceID: json['serviceID'] as String?,
      serviceName: json['serviceName'] as String?,
      serviceTypeID: json['serviceTypeID'] as String?,
      typeName: json['typeName'] as String?,
      typePercentage: json['typePercentage'] as int?,
      typeSize: json['typeSize'] as String?,
      typeApplyDate: json['typeApplyDate'] as String?,
      servicePackID: json['servicePackID'] as String?,
      packRange: json['packRange'] as String?,
      packPercentage: json['packPercentage'] as int?,
      packApplyDate: json['packApplyDate'] as String?,
      totalPage: json['totalPage'] as int?,
    );

Map<String, dynamic> _$WorkingDateToJson(WorkingDate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'workingDate': instance.workingDate,
      'contractID': instance.contractID,
      'fullName': instance.fullName,
      'address': instance.address,
      'phone': instance.phone,
      'email': instance.email,
      'contractDetailID': instance.contractDetailID,
      'timeWorking': instance.timeWorking,
      'note': instance.note,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'totalPrice': instance.totalPrice,
      'serviceID': instance.serviceID,
      'serviceName': instance.serviceName,
      'serviceTypeID': instance.serviceTypeID,
      'typeName': instance.typeName,
      'typePercentage': instance.typePercentage,
      'typeSize': instance.typeSize,
      'typeApplyDate': instance.typeApplyDate,
      'servicePackID': instance.servicePackID,
      'packRange': instance.packRange,
      'packPercentage': instance.packPercentage,
      'packApplyDate': instance.packApplyDate,
      'totalPage': instance.totalPage,
    };
