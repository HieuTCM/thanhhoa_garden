class OrderCart {
  late final id;
  late final plantID;
  late int? quantity;
  late final plantName;
  late final plantPriceID;
  late double? plantPrice;
  late final image;
  late double? shipPrice;

  OrderCart(
      {this.id,
      this.plantID,
      this.quantity,
      this.image,
      this.shipPrice,
      this.plantName,
      this.plantPriceID,
      this.plantPrice});

  OrderCart.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    plantID = json["plantID"];
    quantity = json["quantity"];
    plantName = json["plantName"];
    plantPriceID = json["plantPriceID"];
    plantPrice = json["plantPrice"];
    shipPrice = json["shipPrice"];
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["plantID"] = plantID;
    data["quantity"] = quantity;
    return data;
  }
}
