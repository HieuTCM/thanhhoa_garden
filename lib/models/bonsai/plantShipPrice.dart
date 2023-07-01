// ignore_for_file: file_names, prefer_typing_uninitialized_variables, non_constant_identifier_names

class PlantShipPrice {
  late final id;
  late final potSize;
  late final pricePerPlant;

  PlantShipPrice({this.id, this.potSize, this.pricePerPlant});

  PlantShipPrice.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"];
    potSize = json["potSize"];
    pricePerPlant = json["pricePerPlant"];
  }
}
