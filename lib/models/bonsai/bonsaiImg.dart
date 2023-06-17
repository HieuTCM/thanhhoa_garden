// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, file_names

class PlantImage {
  late final id;
  late final imgurl;
  late final plant_id;

  PlantImage({this.id, this.imgurl, this.plant_id});

  PlantImage.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    imgurl = json["imgurl"];
    plant_id = json["plant_id"];
  }
}
