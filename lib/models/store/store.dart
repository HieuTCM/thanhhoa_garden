class Store {
  late final id;
  late final storeName;
  late final address;
  late final phone;
  late final district;
  late final managerID;
  late final managerName;
  late final totalPage;

  Store(
      {this.id,
      this.storeName,
      this.address,
      this.phone,
      this.district,
      this.managerID,
      this.managerName,
      this.totalPage});

  Store.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    storeName = json["storeName"];
    address = json["address"];
    phone = json["phone"];
    district = json["district"];
    managerID = json["managerID"];
    managerName = json["managerName"];
    totalPage = json["totalPage"];
  }
}
