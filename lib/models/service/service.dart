// ignore_for_file: prefer_typing_uninitialized_variables

var serviceJson = [
  {
    "id": "1",
    "description":
        "Chăm sóc cây tại nhà là dịch vụ cung cấp sự chăm sóc và bảo vệ cho cây trong môi trường nhà cửa. Đội ngũ chuyên gia sẽ tới tận nhà để kiểm tra, tưới nước, cắt tỉa và cung cấp các biện pháp chăm sóc cần thiết để đảm bảo cây luôn khỏe mạnh.",
    "name": "Chăm sóc cây tại nhà",
    "price": "2000000",
    "status": "active"
  },
  {
    "id": "2",
    "description":
        "Gửi cây đến vườn chăm sóc là dịch vụ vận chuyển cây từ nhà bạn đến vườn chăm sóc chuyên nghiệp. Chúng tôi đảm bảo cây được vận chuyển một cách an toàn và nhanh chóng để được chăm sóc và phục hồi sức khỏe tốt hơn.",
    "name": "Gửi cây đến vườn chăm sóc",
    "price": "5000000",
    "status": "active"
  },
  {
    "id": "3",
    "description":
        "Chăm sóc vườn là dịch vụ tận hưởng và bảo vệ vườn cây của bạn. Chúng tôi sẽ cung cấp các dịch vụ như tưới nước, cắt tỉa, bón phân và kiểm tra sự phát triển của cây trong vườn để đảm bảo vườn luôn xanh tươi và tràn đầy sức sống.",
    "name": "Chăm sóc vườn",
    "price": "10000000",
    "status": "active"
  }
];

class Service {
  late final id;
  late final description;
  late final name;
  late final price;
  late final status;

  Service({this.id, this.description, this.name, this.price, this.status});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    name = json['name'];
    price = json['price'];
    status = json['status'];
  }
}
