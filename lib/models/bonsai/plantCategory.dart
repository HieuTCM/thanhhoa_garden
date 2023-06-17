// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, file_names

class PlantCategory {
  late final id;
  late final name;

  PlantCategory({this.id, this.name});

  PlantCategory.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }
}

var plantCategoryJson = [
  {"id": "1", "name": "Cây cảnh trong nhà"},
  {"id": "2", "name": "Cây cảnh sân vườn"},
  {"id": "3", "name": "Cây cảnh phong thủy"},
  {"id": "4", "name": "Cây cảnh để bàn"},
  {"id": "5", "name": "Cây cảnh văn phòng"},
  {"id": "6", "name": "Cây cảnh thủy canh"},
  {"id": "7", "name": "Cây cảnh treo tường"},
  {"id": "8", "name": "Cây cảnh trang trí"},
  {"id": "9", "name": "Cây cảnh đặc biệt"}
];
