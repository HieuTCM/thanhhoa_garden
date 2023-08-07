// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_today.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleToday _$ScheduleTodayFromJson(Map<String, dynamic> json) =>
    ScheduleToday(
      id: json['id'] as String?,
      timeWorking: json['timeWorking'] as String?,
      note: json['note'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      showContractModel: json['showContractModel'] == null
          ? null
          : ShowContractModel.fromJson(
              json['showContractModel'] as Map<String, dynamic>),
      showServiceTypeModel: json['showServiceTypeModel'] == null
          ? null
          : ShowServiceTypeModel.fromJson(
              json['showServiceTypeModel'] as Map<String, dynamic>),
      showServiceModel: json['showServiceModel'] == null
          ? null
          : ShowServiceModel.fromJson(
              json['showServiceModel'] as Map<String, dynamic>),
      showServicePackModel: json['showServicePackModel'] == null
          ? null
          : ShowServicePackModel.fromJson(
              json['showServicePackModel'] as Map<String, dynamic>),
      workingDateList: (json['workingDateList'] as List<dynamic>?)
          ?.map((e) => WorkingDateList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScheduleTodayToJson(ScheduleToday instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timeWorking': instance.timeWorking,
      'note': instance.note,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'totalPrice': instance.totalPrice,
      'showContractModel': instance.showContractModel,
      'showServiceTypeModel': instance.showServiceTypeModel,
      'showServiceModel': instance.showServiceModel,
      'showServicePackModel': instance.showServicePackModel,
      'workingDateList': instance.workingDateList,
    };

ShowContractModel _$ShowContractModelFromJson(Map<String, dynamic> json) =>
    ShowContractModel(
      id: json['id'] as String?,
      title: json['title'] as String?,
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      reason: json['reason'] as String?,
      createdDate: json['createdDate'] as String?,
      startedDate: json['startedDate'] as String?,
      endedDate: json['endedDate'] as String?,
      approvedDate: json['approvedDate'] as String?,
      rejectedDate: json['rejectedDate'] as String?,
      deposit: (json['deposit'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
      isFeedback: json['isFeedback'] as bool?,
      isSigned: json['isSigned'] as bool?,
      status: json['status'] as String?,
      imgList: (json['imgList'] as List<dynamic>?)
          ?.map((e) => ImgList.fromJson(e as Map<String, dynamic>))
          .toList(),
      showStaffModel: json['showStaffModel'] as String?,
      showCustomerModel: json['showCustomerModel'] as String?,
      showStoreModel: json['showStoreModel'] as String?,
      showPaymentTypeModel: json['showPaymentTypeModel'] as String?,
    );

Map<String, dynamic> _$ShowContractModelToJson(ShowContractModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'fullName': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'paymentMethod': instance.paymentMethod,
      'reason': instance.reason,
      'createdDate': instance.createdDate,
      'startedDate': instance.startedDate,
      'endedDate': instance.endedDate,
      'approvedDate': instance.approvedDate,
      'rejectedDate': instance.rejectedDate,
      'deposit': instance.deposit,
      'total': instance.total,
      'isFeedback': instance.isFeedback,
      'isSigned': instance.isSigned,
      'status': instance.status,
      'imgList': instance.imgList,
      'showStaffModel': instance.showStaffModel,
      'showCustomerModel': instance.showCustomerModel,
      'showStoreModel': instance.showStoreModel,
      'showPaymentTypeModel': instance.showPaymentTypeModel,
    };

ImgList _$ImgListFromJson(Map<String, dynamic> json) => ImgList(
      id: json['id'] as String?,
      imgUrl: json['imgUrl'] as String?,
    );

Map<String, dynamic> _$ImgListToJson(ImgList instance) => <String, dynamic>{
      'id': instance.id,
      'imgUrl': instance.imgUrl,
    };

ShowServiceTypeModel _$ShowServiceTypeModelFromJson(
        Map<String, dynamic> json) =>
    ShowServiceTypeModel(
      id: json['id'] as String?,
      typeName: json['typeName'] as String?,
      typePercentage: json['typePercentage'] as int?,
      typeSize: json['typeSize'] as String?,
      typeApplyDate: json['typeApplyDate'] as String?,
    );

Map<String, dynamic> _$ShowServiceTypeModelToJson(
        ShowServiceTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typeName': instance.typeName,
      'typePercentage': instance.typePercentage,
      'typeSize': instance.typeSize,
      'typeApplyDate': instance.typeApplyDate,
    };

ShowServiceModel _$ShowServiceModelFromJson(Map<String, dynamic> json) =>
    ShowServiceModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ShowServiceModelToJson(ShowServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
    };

ShowServicePackModel _$ShowServicePackModelFromJson(
        Map<String, dynamic> json) =>
    ShowServicePackModel(
      id: json['id'] as String?,
      packRange: json['packRange'] as String?,
      packPercentage: json['packPercentage'] as int?,
      packApplyDate: json['packApplyDate'] as String?,
    );

Map<String, dynamic> _$ShowServicePackModelToJson(
        ShowServicePackModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'packRange': instance.packRange,
      'packPercentage': instance.packPercentage,
      'packApplyDate': instance.packApplyDate,
    };

WorkingDateList _$WorkingDateListFromJson(Map<String, dynamic> json) =>
    WorkingDateList(
      id: json['id'] as String?,
      workingDate: json['workingDate'] as String?,
    );

Map<String, dynamic> _$WorkingDateListToJson(WorkingDateList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'workingDate': instance.workingDate,
    };
