// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, file_names

class PlantCategory {
  late final categoryID;
  late final categoryName;

  PlantCategory({this.categoryID, this.categoryName});

  PlantCategory.fromJson(Map<String, dynamic> json) {
    categoryID = json["categoryID"];
    categoryName = json["categoryName"];
  }
}
