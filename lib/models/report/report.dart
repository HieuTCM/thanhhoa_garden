class ReportModel {
  late final id;
  late final description;
  late final reason;
  late final status;
  late final createdDate;
  late final contractDetailID;
  late final serviceTypeID;
  late final serviceTypeName;
  late final serviceID;
  late final serviceName;
  late final customerID;
  late final fullName;
  late final phone;
  late final email;
  late final staffID;
  late final staffName;
  late final contractID;
  late final timeWorking;
  late final totalPage;

  ReportModel(
      {this.id,
      this.description,
      this.reason,
      this.contractDetailID,
      this.timeWorking,
      this.totalPage,
      this.contractID,
      this.createdDate,
      this.customerID,
      this.email,
      this.fullName,
      this.phone,
      this.serviceID,
      this.serviceName,
      this.serviceTypeID,
      this.serviceTypeName,
      this.staffID,
      this.staffName,
      this.status});

  ReportModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    description = json["description"];
    reason = json["reason"];
    contractDetailID = json["contractDetailID"];
    timeWorking = json["timeWorking"];
    totalPage = json["totalPage"];
    contractID = json["contractID"];
    createdDate = json["createdDate"];
    customerID = json["customerID"];
    email = json["email"];
    fullName = json["fullName"];
    phone = json["phone"];
    serviceID = json["serviceID"];
    serviceName = json["serviceName"];
    serviceTypeID = json["serviceTypeID"];
    serviceTypeName = json["serviceTypeName"];
    staffID = json["staffID"];
    staffName = json["staffName"];
    status = json["status"];
  }
}
