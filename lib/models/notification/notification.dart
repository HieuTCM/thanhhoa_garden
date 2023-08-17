class NotificationModel {
  late final id;
  late final title;
  late final link;
  late final description;
  late final isRead;
  late final date;

  NotificationModel(
      {this.id,
      this.title,
      this.link,
      this.description,
      this.isRead,
      this.date});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    link = json["link"];
    description = json["description"];
    isRead = json["isRead"];
    date = json["date"];
  }
}
