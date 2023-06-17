// ignore_for_file: file_names, prefer_typing_uninitialized_variables, non_constant_identifier_names

class PlantShipPrice {
  late final id;
  late final pot_size;
  late final price_per_plant;

  PlantShipPrice({this.id, this.pot_size, this.price_per_plant});

  PlantShipPrice.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"];
    pot_size = json["pot_size"];
    price_per_plant = json["price_per_plant"];
  }
}
