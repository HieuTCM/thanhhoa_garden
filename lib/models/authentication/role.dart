// ignore_for_file: prefer_typing_uninitialized_variables

class Role {
  late final roleID;
  late final roleName;

  Role({this.roleID, this.roleName});

  Role.fromJson(Map<String, dynamic> json) {
    roleID = json['roleID'];
    roleName = json['roleName'];
  }
}
