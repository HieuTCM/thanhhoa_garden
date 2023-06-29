import 'package:thanhhoa_garden/models/bonsai/bonsaiImg.dart';

class FeedbackModel {
  late final name_creater;
  late final imgurl;
  late final create_date;
  late final description;
  late final rating;
  late List<PlantImage>? listImg;

  FeedbackModel(
      {this.create_date,
      this.description,
      this.listImg,
      this.rating,
      this.name_creater,
      this.imgurl});

  FeedbackModel.fromJson(
      Map<String, dynamic> json, List<PlantImage>? listImgage) {
    name_creater = json["name_creater"];
    create_date = json["create_date"];
    rating = json["rating"];
    description = json["description"];
    imgurl = json["imgurl"];
    listImg = listImgage;
  }
}

var feedbackList = [
  {
    "name_creater": "Nguyễn Văn A",
    "imgurl":
        "https://haycafe.vn/wp-content/uploads/2021/11/Anh-avatar-dep-chat-lam-hinh-dai-dien-600x600.jpg",
    "create_date": "2023-06-15 23:59:59",
    "rating": "5",
    "description":
        "Lần đầu mua online mà ưng nha. Tưởng phải chờ lâu hàng mới iao tới nhưng lẹ lắm. Còn cây này trồng khoẻ re, nào vui tưới nước còn buồn buồn thì thôi.",
    "listImg": [
      {
        "id": "65",
        "imgurl":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhGBCS9NCNjgwkm5AG3YdueTODZ31ngbpayw&usqp=CAU",
        "plant_id": "1"
      },
      {
        "id": "66",
        "imgurl":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKdofWcH2chdhzWYbnCuencDeZTWd4vYLymQ&usqp=CAU",
        "plant_id": "1"
      },
      {
        "id": "67",
        "imgurl":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRedLtTWJCXIKURdrMpExn8tjk4DfbjNU3CDA&usqp=CAU",
        "plant_id": "1"
      },
      {
        "id": "68",
        "imgurl":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6aZodFeLihM-q18vpDMlBV85bEpQZkY1cXQ&usqp=CAU",
        "plant_id": "1"
      },
      {
        "id": "68",
        "imgurl":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6aZodFeLihM-q18vpDMlBV85bEpQZkY1cXQ&usqp=CAU",
        "plant_id": "1"
      },
      {
        "id": "68",
        "imgurl":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6aZodFeLihM-q18vpDMlBV85bEpQZkY1cXQ&usqp=CAU",
        "plant_id": "1"
      },
      {
        "id": "68",
        "imgurl":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6aZodFeLihM-q18vpDMlBV85bEpQZkY1cXQ&usqp=CAU",
        "plant_id": "1"
      },
    ]
  },
  {
    "name_creater": "Nguyễn Văn B",
    "imgurl":
        "https://img.meta.com.vn/Data/image/2022/01/06/avatar-tiktok-19.jpg",
    "create_date": "2023-06-12 23:59:59",
    "rating": "1",
    "description":
        "Mọi thứ đều ổn. Nhưng cây của tui mấy mấy cái lá hơi xấu nên tui cho 4 sao thui.",
    "listImg": [
      {
        "id": "65",
        "imgurl":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhGBCS9NCNjgwkm5AG3YdueTODZ31ngbpayw&usqp=CAU",
        "plant_id": "1"
      },
      {
        "id": "68",
        "imgurl":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6aZodFeLihM-q18vpDMlBV85bEpQZkY1cXQ&usqp=CAU",
        "plant_id": "1"
      }
    ]
  },
  {
    "name_creater": "Nguyễn Văn C",
    "imgurl":
        "https://khoinguonsangtao.vn/wp-content/uploads/2022/07/avatar-hai-1.jpg",
    "create_date": "2023-06-22 23:59:59",
    "rating": "4",
    "description":
        "Cây thì ok nhưng ông giao hàng chở không cẩn thận làm gãy 2 cái lá. Xong thái độ xin lỗi tui thấy chưa chân thành. Hy vọng shop xem xét lại nhân viên.",
    "listImg": [
      {
        "id": "65",
        "imgurl":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhGBCS9NCNjgwkm5AG3YdueTODZ31ngbpayw&usqp=CAU",
        "plant_id": "1"
      },
      {
        "id": "68",
        "imgurl":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6aZodFeLihM-q18vpDMlBV85bEpQZkY1cXQ&usqp=CAU",
        "plant_id": "1"
      },
      {
        "id": "66",
        "imgurl":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKdofWcH2chdhzWYbnCuencDeZTWd4vYLymQ&usqp=CAU",
        "plant_id": "1"
      },
    ]
  },
];
