// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, file_names

class ImageURL {
  late final id;
  late final url;

  ImageURL({this.id, this.url});

  ImageURL.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    url = json["url"];
  }
  Map<String, dynamic> toJson(ImageURL imageURL) {
    Map<String, dynamic> json = {};
    json["id"] = imageURL.id;
    json["url"] = imageURL.url;
    return json;
  }
}
