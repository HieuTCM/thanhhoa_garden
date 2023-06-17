// ignore_for_file: prefer_typing_uninitialized_variables

class Role {
  late final id;
  late final name;

  Role({this.id, this.name});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
