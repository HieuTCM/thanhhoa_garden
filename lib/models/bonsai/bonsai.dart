// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:thanhhoa_garden/models/bonsai/bonsaiImg.dart';
import 'package:thanhhoa_garden/models/bonsai/plantCategory.dart';
import 'package:thanhhoa_garden/models/bonsai/plantShipPrice.dart';

class Bonsai {
  late final id;
  late final care_note;
  late final description;
  late final height;
  late final name;
  late final price;
  late final status;
  late final with_pot;
  late final plant_ship_price_id;
  late PlantShipPrice? plantShipPrice;
  late List<PlantCategory>? listCate;
  late List<PlantImage>? listImg;

  Bonsai(
      {this.id,
      this.care_note,
      this.description,
      this.height,
      this.name,
      this.price,
      this.status,
      this.with_pot,
      this.plant_ship_price_id,
      this.plantShipPrice,
      this.listCate,
      this.listImg});

  Bonsai.fromJson(Map<String, dynamic> json, PlantShipPrice ShipPrice,
      List<PlantCategory> listCateory, List<PlantImage>? listImgage) {
    id = json["id"];
    care_note = json["care_note"];
    description = json["description"];
    height = json["height"];
    name = json["name"];
    price = json["price"];
    status = json["status"];
    with_pot = json["with_pot"];
    plant_ship_price_id = json["plant_ship_price_"];
    plantShipPrice = ShipPrice;
    listCate = listCateory;
    listImg = listImgage;
  }
}

var bonsaiJson = [
  {
    "id": "1",
    "care_note":
        "-Thích hợp trồng trên nhiều loại đất miễn là đủ ẩm và không quá khô hạn.\n-Thích hợp khí hậu Việt Nam, không cần thường xuyên tưới nước. \n-Tốc độ sinh trưởng của cây chậm, mất 20 năm thìcây mới cao được khoảng 2m",
    "description":
        "Cây Cau Lùn có tên khoa học là Areca catechu, thuộc họ thực vât Arecaceae (họ Cau Dừa).Trên thị trường cũng đã có rất nhiều loài cau như cây cau bẹ trắng, cau sâm banh, cau vua, cau đỏ, cau đuôi chồn,…và Cau Lùn là một trong số những cây thuộc họ cau dừa được sử dụng nhiều.",
    "height": "30",
    "name": "Cây Cau Lùn",
    "price": "500000",
    "status": "On Sale",
    "with_pot": "True",
    "plant_ship_price_id": "1",
    "plant_ship_price": {
      "id": "1",
      "pot_size": "0 - 30 cm",
      "price_per_plant": "5000"
    },
    "plant_category": [
      {"id": "7", "name": "Cây cảnh treo tường", "plant_id": "1"},
      {"id": "8", "name": "Cây cảnh trang trí", "plant_id": "1"},
      {"id": "2", "name": "Cây cảnh sân vườn", "plant_id": "1"},
      {"id": "4", "name": "Cây cảnh để bàn", "plant_id": "1"},
      {"id": "5", "name": "Cây cảnh văn phòng", "plant_id": "1"},
      {"id": "1", "name": "Cây cảnh trong nhà", "plant_id": "1"}
    ],
    "list_img": [
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
        "id": "67",
        "imgurl":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRedLtTWJCXIKURdrMpExn8tjk4DfbjNU3CDA&usqp=CAU",
        "plant_id": "1"
      },
      {
        "id": "67",
        "imgurl":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRedLtTWJCXIKURdrMpExn8tjk4DfbjNU3CDA&usqp=CAU",
        "plant_id": "1"
      },
      {
        "id": "67",
        "imgurl":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRedLtTWJCXIKURdrMpExn8tjk4DfbjNU3CDA&usqp=CAU",
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
      }
    ]
  },
  {
    "id": "1",
    "care_note":
        "-Thích hợp trồng trên nhiều loại đất miễn là đủ ẩm và không quá khô hạn.\n-Thích hợp khí hậu Việt Nam, không cần thường xuyên tưới nước. \n-Tốc độ sinh trưởng của cây chậm, mất 20 năm thìcây mới cao được khoảng 2m",
    "description":
        "Cây Cau Lùn có tên khoa học là Areca catechu, thuộc họ thực vât Arecaceae (họ Cau Dừa).Trên thị trường cũng đã có rất nhiều loài cau như cây cau bẹ trắng, cau sâm banh, cau vua, cau đỏ, cau đuôi chồn,…và Cau Lùn là một trong số những cây thuộc họ cau dừa được sử dụng nhiều.",
    "height": "30",
    "name": "Cây Cau Lùn",
    "price": "500000",
    "status": "On Sale",
    "with_pot": "True",
    "plant_ship_price_id": "1",
    "plant_ship_price": {
      "id": "1",
      "pot_size": "0 - 30 cm",
      "price_per_plant": "5000"
    },
    "plant_category": [
      {"id": "7", "name": "Cây cảnh treo tường", "plant_id": "1"},
      {"id": "8", "name": "Cây cảnh trang trí", "plant_id": "1"},
      {"id": "2", "name": "Cây cảnh sân vườn", "plant_id": "1"},
      {"id": "4", "name": "Cây cảnh để bàn", "plant_id": "1"},
      {"id": "5", "name": "Cây cảnh văn phòng", "plant_id": "1"},
      {"id": "1", "name": "Cây cảnh trong nhà", "plant_id": "1"}
    ],
    "list_img": [
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
      }
    ]
  },
  {
    "id": "1",
    "care_note":
        "-Thích hợp trồng trên nhiều loại đất miễn là đủ ẩm và không quá khô hạn.\n-Thích hợp khí hậu Việt Nam, không cần thường xuyên tưới nước. \n-Tốc độ sinh trưởng của cây chậm, mất 20 năm thìcây mới cao được khoảng 2m",
    "description":
        "Cây Cau Lùn có tên khoa học là Areca catechu, thuộc họ thực vât Arecaceae (họ Cau Dừa).Trên thị trường cũng đã có rất nhiều loài cau như cây cau bẹ trắng, cau sâm banh, cau vua, cau đỏ, cau đuôi chồn,…và Cau Lùn là một trong số những cây thuộc họ cau dừa được sử dụng nhiều.",
    "height": "30",
    "name": "Cây Cau Lùn",
    "price": "500000",
    "status": "On Sale",
    "with_pot": "True",
    "plant_ship_price_id": "1",
    "plant_ship_price": {
      "id": "1",
      "pot_size": "0 - 30 cm",
      "price_per_plant": "5000"
    },
    "plant_category": [
      {"id": "7", "name": "Cây cảnh treo tường", "plant_id": "1"},
      {"id": "8", "name": "Cây cảnh trang trí", "plant_id": "1"},
      {"id": "2", "name": "Cây cảnh sân vườn", "plant_id": "1"},
      {"id": "4", "name": "Cây cảnh để bàn", "plant_id": "1"},
      {"id": "5", "name": "Cây cảnh văn phòng", "plant_id": "1"},
      {"id": "1", "name": "Cây cảnh trong nhà", "plant_id": "1"}
    ],
    "list_img": [
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
      }
    ]
  }
];

var bonsaiSearchJson = [
  {
    "id": "1",
    "care_note":
        "-Thích hợp trồng trên nhiều loại đất miễn là đủ ẩm và không quá khô hạn.\n-Thích hợp khí hậu Việt Nam, không cần thường xuyên tưới nước. \n-Tốc độ sinh trưởng của cây chậm, mất 20 năm thìcây mới cao được khoảng 2m",
    "description":
        "Cây Cau Lùn có tên khoa học là Areca catechu, thuộc họ thực vât Arecaceae (họ Cau Dừa).Trên thị trường cũng đã có rất nhiều loài cau như cây cau bẹ trắng, cau sâm banh, cau vua, cau đỏ, cau đuôi chồn,…và Cau Lùn là một trong số những cây thuộc họ cau dừa được sử dụng nhiều.",
    "height": "30",
    "name": "Cây Cau Lùn",
    "price": "500000",
    "status": "On Sale",
    "with_pot": "True",
    "plant_ship_price_id": "1",
    "plant_ship_price": {
      "id": "1",
      "pot_size": "0 - 30 cm",
      "price_per_plant": "5000"
    },
    "plant_category": [
      {"id": "7", "name": "Cây cảnh treo tường", "plant_id": "1"},
      {"id": "8", "name": "Cây cảnh trang trí", "plant_id": "1"},
      {"id": "2", "name": "Cây cảnh sân vườn", "plant_id": "1"},
      {"id": "4", "name": "Cây cảnh để bàn", "plant_id": "1"},
      {"id": "5", "name": "Cây cảnh văn phòng", "plant_id": "1"},
      {"id": "1", "name": "Cây cảnh trong nhà", "plant_id": "1"}
    ],
    "list_img": [
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
      }
    ]
  },
  {
    "id": "1",
    "care_note":
        "-Thích hợp trồng trên nhiều loại đất miễn là đủ ẩm và không quá khô hạn.\n-Thích hợp khí hậu Việt Nam, không cần thường xuyên tưới nước. \n-Tốc độ sinh trưởng của cây chậm, mất 20 năm thìcây mới cao được khoảng 2m",
    "description":
        "Cây Cau Lùn có tên khoa học là Areca catechu, thuộc họ thực vât Arecaceae (họ Cau Dừa).Trên thị trường cũng đã có rất nhiều loài cau như cây cau bẹ trắng, cau sâm banh, cau vua, cau đỏ, cau đuôi chồn,…và Cau Lùn là một trong số những cây thuộc họ cau dừa được sử dụng nhiều.",
    "height": "30",
    "name": "Cây Cau Lùn",
    "price": "500000",
    "status": "On Sale",
    "with_pot": "True",
    "plant_ship_price_id": "1",
    "plant_ship_price": {
      "id": "1",
      "pot_size": "0 - 30 cm",
      "price_per_plant": "5000"
    },
    "plant_category": [
      {"id": "7", "name": "Cây cảnh treo tường", "plant_id": "1"},
      {"id": "8", "name": "Cây cảnh trang trí", "plant_id": "1"},
      {"id": "2", "name": "Cây cảnh sân vườn", "plant_id": "1"},
      {"id": "4", "name": "Cây cảnh để bàn", "plant_id": "1"},
      {"id": "5", "name": "Cây cảnh văn phòng", "plant_id": "1"},
      {"id": "1", "name": "Cây cảnh trong nhà", "plant_id": "1"}
    ],
    "list_img": [
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
      }
    ]
  },
  {
    "id": "1",
    "care_note":
        "-Thích hợp trồng trên nhiều loại đất miễn là đủ ẩm và không quá khô hạn.\n-Thích hợp khí hậu Việt Nam, không cần thường xuyên tưới nước. \n-Tốc độ sinh trưởng của cây chậm, mất 20 năm thìcây mới cao được khoảng 2m",
    "description":
        "Cây Cau Lùn có tên khoa học là Areca catechu, thuộc họ thực vât Arecaceae (họ Cau Dừa).Trên thị trường cũng đã có rất nhiều loài cau như cây cau bẹ trắng, cau sâm banh, cau vua, cau đỏ, cau đuôi chồn,…và Cau Lùn là một trong số những cây thuộc họ cau dừa được sử dụng nhiều.",
    "height": "30",
    "name": "Cây Cau Lùn",
    "price": "500000",
    "status": "On Sale",
    "with_pot": "True",
    "plant_ship_price_id": "1",
    "plant_ship_price": {
      "id": "1",
      "pot_size": "0 - 30 cm",
      "price_per_plant": "5000"
    },
    "plant_category": [
      {"id": "7", "name": "Cây cảnh treo tường", "plant_id": "1"},
      {"id": "8", "name": "Cây cảnh trang trí", "plant_id": "1"},
      {"id": "2", "name": "Cây cảnh sân vườn", "plant_id": "1"},
      {"id": "4", "name": "Cây cảnh để bàn", "plant_id": "1"},
      {"id": "5", "name": "Cây cảnh văn phòng", "plant_id": "1"},
      {"id": "1", "name": "Cây cảnh trong nhà", "plant_id": "1"}
    ],
    "list_img": [
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
      }
    ]
  },
  {
    "id": "1",
    "care_note":
        "-Thích hợp trồng trên nhiều loại đất miễn là đủ ẩm và không quá khô hạn.\n-Thích hợp khí hậu Việt Nam, không cần thường xuyên tưới nước. \n-Tốc độ sinh trưởng của cây chậm, mất 20 năm thìcây mới cao được khoảng 2m",
    "description":
        "Cây Cau Lùn có tên khoa học là Areca catechu, thuộc họ thực vât Arecaceae (họ Cau Dừa).Trên thị trường cũng đã có rất nhiều loài cau như cây cau bẹ trắng, cau sâm banh, cau vua, cau đỏ, cau đuôi chồn,…và Cau Lùn là một trong số những cây thuộc họ cau dừa được sử dụng nhiều.",
    "height": "30",
    "name": "Cây Cau Lùn",
    "price": "500000",
    "status": "On Sale",
    "with_pot": "True",
    "plant_ship_price_id": "1",
    "plant_ship_price": {
      "id": "1",
      "pot_size": "0 - 30 cm",
      "price_per_plant": "5000"
    },
    "plant_category": [
      {"id": "7", "name": "Cây cảnh treo tường", "plant_id": "1"},
      {"id": "8", "name": "Cây cảnh trang trí", "plant_id": "1"},
      {"id": "2", "name": "Cây cảnh sân vườn", "plant_id": "1"},
      {"id": "4", "name": "Cây cảnh để bàn", "plant_id": "1"},
      {"id": "5", "name": "Cây cảnh văn phòng", "plant_id": "1"},
      {"id": "1", "name": "Cây cảnh trong nhà", "plant_id": "1"}
    ],
    "list_img": [
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
      }
    ]
  },
  {
    "id": "1",
    "care_note":
        "-Thích hợp trồng trên nhiều loại đất miễn là đủ ẩm và không quá khô hạn.\n-Thích hợp khí hậu Việt Nam, không cần thường xuyên tưới nước. \n-Tốc độ sinh trưởng của cây chậm, mất 20 năm thìcây mới cao được khoảng 2m",
    "description":
        "Cây Cau Lùn có tên khoa học là Areca catechu, thuộc họ thực vât Arecaceae (họ Cau Dừa).Trên thị trường cũng đã có rất nhiều loài cau như cây cau bẹ trắng, cau sâm banh, cau vua, cau đỏ, cau đuôi chồn,…và Cau Lùn là một trong số những cây thuộc họ cau dừa được sử dụng nhiều.",
    "height": "30",
    "name": "Cây Cau Lùn",
    "price": "500000",
    "status": "On Sale",
    "with_pot": "True",
    "plant_ship_price_id": "1",
    "plant_ship_price": {
      "id": "1",
      "pot_size": "0 - 30 cm",
      "price_per_plant": "5000"
    },
    "plant_category": [
      {"id": "7", "name": "Cây cảnh treo tường", "plant_id": "1"},
      {"id": "8", "name": "Cây cảnh trang trí", "plant_id": "1"},
      {"id": "2", "name": "Cây cảnh sân vườn", "plant_id": "1"},
      {"id": "4", "name": "Cây cảnh để bàn", "plant_id": "1"},
      {"id": "5", "name": "Cây cảnh văn phòng", "plant_id": "1"},
      {"id": "1", "name": "Cây cảnh trong nhà", "plant_id": "1"}
    ],
    "list_img": [
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
      }
    ]
  },
  {
    "id": "1",
    "care_note":
        "-Thích hợp trồng trên nhiều loại đất miễn là đủ ẩm và không quá khô hạn.\n-Thích hợp khí hậu Việt Nam, không cần thường xuyên tưới nước. \n-Tốc độ sinh trưởng của cây chậm, mất 20 năm thìcây mới cao được khoảng 2m",
    "description":
        "Cây Cau Lùn có tên khoa học là Areca catechu, thuộc họ thực vât Arecaceae (họ Cau Dừa).Trên thị trường cũng đã có rất nhiều loài cau như cây cau bẹ trắng, cau sâm banh, cau vua, cau đỏ, cau đuôi chồn,…và Cau Lùn là một trong số những cây thuộc họ cau dừa được sử dụng nhiều.",
    "height": "30",
    "name": "Cây Cau Lùn",
    "price": "500000",
    "status": "On Sale",
    "with_pot": "True",
    "plant_ship_price_id": "1",
    "plant_ship_price": {
      "id": "1",
      "pot_size": "0 - 30 cm",
      "price_per_plant": "5000"
    },
    "plant_category": [
      {"id": "7", "name": "Cây cảnh treo tường", "plant_id": "1"},
      {"id": "8", "name": "Cây cảnh trang trí", "plant_id": "1"},
      {"id": "2", "name": "Cây cảnh sân vườn", "plant_id": "1"},
      {"id": "4", "name": "Cây cảnh để bàn", "plant_id": "1"},
      {"id": "5", "name": "Cây cảnh văn phòng", "plant_id": "1"},
      {"id": "1", "name": "Cây cảnh trong nhà", "plant_id": "1"}
    ],
    "list_img": [
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
      }
    ]
  },
  {
    "id": "1",
    "care_note":
        "-Thích hợp trồng trên nhiều loại đất miễn là đủ ẩm và không quá khô hạn.\n-Thích hợp khí hậu Việt Nam, không cần thường xuyên tưới nước. \n-Tốc độ sinh trưởng của cây chậm, mất 20 năm thìcây mới cao được khoảng 2m",
    "description":
        "Cây Cau Lùn có tên khoa học là Areca catechu, thuộc họ thực vât Arecaceae (họ Cau Dừa).Trên thị trường cũng đã có rất nhiều loài cau như cây cau bẹ trắng, cau sâm banh, cau vua, cau đỏ, cau đuôi chồn,…và Cau Lùn là một trong số những cây thuộc họ cau dừa được sử dụng nhiều.",
    "height": "30",
    "name": "Cây Cau Lùn",
    "price": "500000",
    "status": "On Sale",
    "with_pot": "True",
    "plant_ship_price_id": "1",
    "plant_ship_price": {
      "id": "1",
      "pot_size": "0 - 30 cm",
      "price_per_plant": "5000"
    },
    "plant_category": [
      {"id": "7", "name": "Cây cảnh treo tường", "plant_id": "1"},
      {"id": "8", "name": "Cây cảnh trang trí", "plant_id": "1"},
      {"id": "2", "name": "Cây cảnh sân vườn", "plant_id": "1"},
      {"id": "4", "name": "Cây cảnh để bàn", "plant_id": "1"},
      {"id": "5", "name": "Cây cảnh văn phòng", "plant_id": "1"},
      {"id": "1", "name": "Cây cảnh trong nhà", "plant_id": "1"}
    ],
    "list_img": [
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
      }
    ]
  },
  {
    "id": "1",
    "care_note":
        "-Thích hợp trồng trên nhiều loại đất miễn là đủ ẩm và không quá khô hạn.\n-Thích hợp khí hậu Việt Nam, không cần thường xuyên tưới nước. \n-Tốc độ sinh trưởng của cây chậm, mất 20 năm thìcây mới cao được khoảng 2m",
    "description":
        "Cây Cau Lùn có tên khoa học là Areca catechu, thuộc họ thực vât Arecaceae (họ Cau Dừa).Trên thị trường cũng đã có rất nhiều loài cau như cây cau bẹ trắng, cau sâm banh, cau vua, cau đỏ, cau đuôi chồn,…và Cau Lùn là một trong số những cây thuộc họ cau dừa được sử dụng nhiều.",
    "height": "30",
    "name": "Cây Cau Lùn",
    "price": "500000",
    "status": "On Sale",
    "with_pot": "True",
    "plant_ship_price_id": "1",
    "plant_ship_price": {
      "id": "1",
      "pot_size": "0 - 30 cm",
      "price_per_plant": "5000"
    },
    "plant_category": [
      {"id": "7", "name": "Cây cảnh treo tường", "plant_id": "1"},
      {"id": "8", "name": "Cây cảnh trang trí", "plant_id": "1"},
      {"id": "2", "name": "Cây cảnh sân vườn", "plant_id": "1"},
      {"id": "4", "name": "Cây cảnh để bàn", "plant_id": "1"},
      {"id": "5", "name": "Cây cảnh văn phòng", "plant_id": "1"},
      {"id": "1", "name": "Cây cảnh trong nhà", "plant_id": "1"}
    ],
    "list_img": [
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
      }
    ]
  },
  {
    "id": "1",
    "care_note":
        "-Thích hợp trồng trên nhiều loại đất miễn là đủ ẩm và không quá khô hạn.\n-Thích hợp khí hậu Việt Nam, không cần thường xuyên tưới nước. \n-Tốc độ sinh trưởng của cây chậm, mất 20 năm thìcây mới cao được khoảng 2m",
    "description":
        "Cây Cau Lùn có tên khoa học là Areca catechu, thuộc họ thực vât Arecaceae (họ Cau Dừa).Trên thị trường cũng đã có rất nhiều loài cau như cây cau bẹ trắng, cau sâm banh, cau vua, cau đỏ, cau đuôi chồn,…và Cau Lùn là một trong số những cây thuộc họ cau dừa được sử dụng nhiều.",
    "height": "30",
    "name": "Cây Cau Lùn",
    "price": "500000",
    "status": "On Sale",
    "with_pot": "True",
    "plant_ship_price_id": "1",
    "plant_ship_price": {
      "id": "1",
      "pot_size": "0 - 30 cm",
      "price_per_plant": "5000"
    },
    "plant_category": [
      {"id": "7", "name": "Cây cảnh treo tường", "plant_id": "1"},
      {"id": "8", "name": "Cây cảnh trang trí", "plant_id": "1"},
      {"id": "2", "name": "Cây cảnh sân vườn", "plant_id": "1"},
      {"id": "4", "name": "Cây cảnh để bàn", "plant_id": "1"},
      {"id": "5", "name": "Cây cảnh văn phòng", "plant_id": "1"},
      {"id": "1", "name": "Cây cảnh trong nhà", "plant_id": "1"}
    ],
    "list_img": [
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
      }
    ]
  },
  {
    "id": "1",
    "care_note":
        "-Thích hợp trồng trên nhiều loại đất miễn là đủ ẩm và không quá khô hạn.\n-Thích hợp khí hậu Việt Nam, không cần thường xuyên tưới nước. \n-Tốc độ sinh trưởng của cây chậm, mất 20 năm thìcây mới cao được khoảng 2m",
    "description":
        "Cây Cau Lùn có tên khoa học là Areca catechu, thuộc họ thực vât Arecaceae (họ Cau Dừa).Trên thị trường cũng đã có rất nhiều loài cau như cây cau bẹ trắng, cau sâm banh, cau vua, cau đỏ, cau đuôi chồn,…và Cau Lùn là một trong số những cây thuộc họ cau dừa được sử dụng nhiều.",
    "height": "30",
    "name": "Cây Cau Lùn",
    "price": "500000",
    "status": "On Sale",
    "with_pot": "True",
    "plant_ship_price_id": "1",
    "plant_ship_price": {
      "id": "1",
      "pot_size": "0 - 30 cm",
      "price_per_plant": "5000"
    },
    "plant_category": [
      {"id": "7", "name": "Cây cảnh treo tường", "plant_id": "1"},
      {"id": "8", "name": "Cây cảnh trang trí", "plant_id": "1"},
      {"id": "2", "name": "Cây cảnh sân vườn", "plant_id": "1"},
      {"id": "4", "name": "Cây cảnh để bàn", "plant_id": "1"},
      {"id": "5", "name": "Cây cảnh văn phòng", "plant_id": "1"},
      {"id": "1", "name": "Cây cảnh trong nhà", "plant_id": "1"}
    ],
    "list_img": [
      {
        "id": "65",
        "imgurl":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhGBCS9NCNjgwkm5AG3YdueTODZ31ngbpayw&usqp=CAU",
        "plant_id,": "1"
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
      }
    ]
  },
  {
    "id": "1",
    "care_note":
        "-Thích hợp trồng trên nhiều loại đất miễn là đủ ẩm và không quá khô hạn.\n-Thích hợp khí hậu Việt Nam, không cần thường xuyên tưới nước. \n-Tốc độ sinh trưởng của cây chậm, mất 20 năm thìcây mới cao được khoảng 2m",
    "description":
        "Cây Cau Lùn có tên khoa học là Areca catechu, thuộc họ thực vât Arecaceae (họ Cau Dừa).Trên thị trường cũng đã có rất nhiều loài cau như cây cau bẹ trắng, cau sâm banh, cau vua, cau đỏ, cau đuôi chồn,…và Cau Lùn là một trong số những cây thuộc họ cau dừa được sử dụng nhiều.",
    "height": "30",
    "name": "Cây Cau Lùn",
    "price": "500000",
    "status": "On Sale",
    "with_pot": "True",
    "plant_ship_price_id": "1",
    "plant_ship_price": {
      "id": "1",
      "pot_size": "0 - 30 cm",
      "price_per_plant": "5000"
    },
    "plant_category": [
      {"id": "7", "name": "Cây cảnh treo tường", "plant_id": "1"},
      {"id": "8", "name": "Cây cảnh trang trí", "plant_id": "1"},
      {"id": "2", "name": "Cây cảnh sân vườn", "plant_id": "1"},
      {"id": "4", "name": "Cây cảnh để bàn", "plant_id": "1"},
      {"id": "5", "name": "Cây cảnh văn phòng", "plant_id": "1"},
      {"id": "1", "name": "Cây cảnh trong nhà", "plant_id": "1"}
    ],
    "list_img": [
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
      }
    ]
  },
  {
    "id": "1",
    "care_note":
        "-Thích hợp trồng trên nhiều loại đất miễn là đủ ẩm và không quá khô hạn.\n-Thích hợp khí hậu Việt Nam, không cần thường xuyên tưới nước. \n-Tốc độ sinh trưởng của cây chậm, mất 20 năm thìcây mới cao được khoảng 2m",
    "description":
        "Cây Cau Lùn có tên khoa học là Areca catechu, thuộc họ thực vât Arecaceae (họ Cau Dừa).Trên thị trường cũng đã có rất nhiều loài cau như cây cau bẹ trắng, cau sâm banh, cau vua, cau đỏ, cau đuôi chồn,…và Cau Lùn là một trong số những cây thuộc họ cau dừa được sử dụng nhiều.",
    "height": "30",
    "name": "Cây Cau Lùn",
    "price": "500000",
    "status": "On Sale",
    "with_pot": "True",
    "plant_ship_price_id": "1",
    "plant_ship_price": {
      "id": "1",
      "pot_size": "0 - 30 cm",
      "price_per_plant": "5000"
    },
    "plant_category": [
      {"id": "7", "name": "Cây cảnh treo tường", "plant_id": "1"},
      {"id": "8", "name": "Cây cảnh trang trí", "plant_id": "1"},
      {"id": "2", "name": "Cây cảnh sân vườn", "plant_id": "1"},
      {"id": "4", "name": "Cây cảnh để bàn", "plant_id": "1"},
      {"id": "5", "name": "Cây cảnh văn phòng", "plant_id": "1"},
      {"id": "1", "name": "Cây cảnh trong nhà", "plant_id": "1"}
    ],
    "list_img": [
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
      }
    ]
  },
  {
    "id": "1",
    "care_note":
        "-Thích hợp trồng trên nhiều loại đất miễn là đủ ẩm và không quá khô hạn.\n-Thích hợp khí hậu Việt Nam, không cần thường xuyên tưới nước. \n-Tốc độ sinh trưởng của cây chậm, mất 20 năm thìcây mới cao được khoảng 2m",
    "description":
        "Cây Cau Lùn có tên khoa học là Areca catechu, thuộc họ thực vât Arecaceae (họ Cau Dừa).Trên thị trường cũng đã có rất nhiều loài cau như cây cau bẹ trắng, cau sâm banh, cau vua, cau đỏ, cau đuôi chồn,…và Cau Lùn là một trong số những cây thuộc họ cau dừa được sử dụng nhiều.",
    "height": "30",
    "name": "Cây Cau Lùn",
    "price": "500000",
    "status": "On Sale",
    "with_pot": "True",
    "plant_ship_price_id": "1",
    "plant_ship_price": {
      "id": "1",
      "pot_size": "0 - 30 cm",
      "price_per_plant": "5000"
    },
    "plant_category": [
      {"id": "7", "name": "Cây cảnh treo tường", "plant_id": "1"},
      {"id": "8", "name": "Cây cảnh trang trí", "plant_id": "1"},
      {"id": "2", "name": "Cây cảnh sân vườn", "plant_id": "1"},
      {"id": "4", "name": "Cây cảnh để bàn", "plant_id": "1"},
      {"id": "5", "name": "Cây cảnh văn phòng", "plant_id": "1"},
      {"id": "1", "name": "Cây cảnh trong nhà", "plant_id": "1"}
    ],
    "list_img": [
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
      }
    ]
  },
  {
    "id": "1",
    "care_note":
        "-Thích hợp trồng trên nhiều loại đất miễn là đủ ẩm và không quá khô hạn.\n-Thích hợp khí hậu Việt Nam, không cần thường xuyên tưới nước. \n-Tốc độ sinh trưởng của cây chậm, mất 20 năm thìcây mới cao được khoảng 2m",
    "description":
        "Cây Cau Lùn có tên khoa học là Areca catechu, thuộc họ thực vât Arecaceae (họ Cau Dừa).Trên thị trường cũng đã có rất nhiều loài cau như cây cau bẹ trắng, cau sâm banh, cau vua, cau đỏ, cau đuôi chồn,…và Cau Lùn là một trong số những cây thuộc họ cau dừa được sử dụng nhiều.",
    "height": "30",
    "name": "Cây Cau Lùn",
    "price": "500000",
    "status": "On Sale",
    "with_pot": "True",
    "plant_ship_price_id": "1",
    "plant_ship_price": {
      "id": "1",
      "pot_size": "0 - 30 cm",
      "price_per_plant": "5000"
    },
    "plant_category": [
      {"id": "7", "name": "Cây cảnh treo tường", "plant_id": "1"},
      {"id": "8", "name": "Cây cảnh trang trí", "plant_id": "1"},
      {"id": "2", "name": "Cây cảnh sân vườn", "plant_id": "1"},
      {"id": "4", "name": "Cây cảnh để bàn", "plant_id": "1"},
      {"id": "5", "name": "Cây cảnh văn phòng", "plant_id": "1"},
      {"id": "1", "name": "Cây cảnh trong nhà", "plant_id": "1"}
    ],
    "list_img": [
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
      }
    ]
  },
  {
    "id": "1",
    "care_note":
        "-Thích hợp trồng trên nhiều loại đất miễn là đủ ẩm và không quá khô hạn.\n-Thích hợp khí hậu Việt Nam, không cần thường xuyên tưới nước. \n-Tốc độ sinh trưởng của cây chậm, mất 20 năm thìcây mới cao được khoảng 2m",
    "description":
        "Cây Cau Lùn có tên khoa học là Areca catechu, thuộc họ thực vât Arecaceae (họ Cau Dừa).Trên thị trường cũng đã có rất nhiều loài cau như cây cau bẹ trắng, cau sâm banh, cau vua, cau đỏ, cau đuôi chồn,…và Cau Lùn là một trong số những cây thuộc họ cau dừa được sử dụng nhiều.",
    "height": "30",
    "name": "Cây Cau Lùn",
    "price": "500000",
    "status": "On Sale",
    "with_pot": "True",
    "plant_ship_price_id": "1",
    "plant_ship_price": {
      "id": "1",
      "pot_size": "0 - 30 cm",
      "price_per_plant": "5000"
    },
    "plant_category": [
      {"id": "7", "name": "Cây cảnh treo tường", "plant_id": "1"},
      {"id": "8", "name": "Cây cảnh trang trí", "plant_id": "1"},
      {"id": "2", "name": "Cây cảnh sân vườn", "plant_id": "1"},
      {"id": "4", "name": "Cây cảnh để bàn", "plant_id": "1"},
      {"id": "5", "name": "Cây cảnh văn phòng", "plant_id": "1"},
      {"id": "1", "name": "Cây cảnh trong nhà", "plant_id": "1"}
    ],
    "list_img": [
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
      }
    ]
  },
  {
    "id": "1",
    "care_note":
        "-Thích hợp trồng trên nhiều loại đất miễn là đủ ẩm và không quá khô hạn.\n-Thích hợp khí hậu Việt Nam, không cần thường xuyên tưới nước. \n-Tốc độ sinh trưởng của cây chậm, mất 20 năm thìcây mới cao được khoảng 2m",
    "description":
        "Cây Cau Lùn có tên khoa học là Areca catechu, thuộc họ thực vât Arecaceae (họ Cau Dừa).Trên thị trường cũng đã có rất nhiều loài cau như cây cau bẹ trắng, cau sâm banh, cau vua, cau đỏ, cau đuôi chồn,…và Cau Lùn là một trong số những cây thuộc họ cau dừa được sử dụng nhiều.",
    "height": "30",
    "name": "Cây Cau Lùn",
    "price": "500000",
    "status": "On Sale",
    "with_pot": "True",
    "plant_ship_price_id": "1",
    "plant_ship_price": {
      "id": "1",
      "pot_size": "0 - 30 cm",
      "price_per_plant": "5000"
    },
    "plant_category": [
      {"id": "7", "name": "Cây cảnh treo tường", "plant_id": "1"},
      {"id": "8", "name": "Cây cảnh trang trí", "plant_id": "1"},
      {"id": "2", "name": "Cây cảnh sân vườn", "plant_id": "1"},
      {"id": "4", "name": "Cây cảnh để bàn", "plant_id": "1"},
      {"id": "5", "name": "Cây cảnh văn phòng", "plant_id": "1"},
      {"id": "1", "name": "Cây cảnh trong nhà", "plant_id": "1"}
    ],
    "list_img": [
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
      }
    ]
  },
  {
    "id": "1",
    "care_note":
        "-Thích hợp trồng trên nhiều loại đất miễn là đủ ẩm và không quá khô hạn.\n-Thích hợp khí hậu Việt Nam, không cần thường xuyên tưới nước. \n-Tốc độ sinh trưởng của cây chậm, mất 20 năm thìcây mới cao được khoảng 2m",
    "description":
        "Cây Cau Lùn có tên khoa học là Areca catechu, thuộc họ thực vât Arecaceae (họ Cau Dừa).Trên thị trường cũng đã có rất nhiều loài cau như cây cau bẹ trắng, cau sâm banh, cau vua, cau đỏ, cau đuôi chồn,…và Cau Lùn là một trong số những cây thuộc họ cau dừa được sử dụng nhiều.",
    "height": "30",
    "name": "Cây Cau Lùn",
    "price": "500000",
    "status": "On Sale",
    "with_pot": "True",
    "plant_ship_price_id": "1",
    "plant_ship_price": {
      "id": "1",
      "pot_size": "0 - 30 cm",
      "price_per_plant": "5000"
    },
    "plant_category": [
      {"id": "7", "name": "Cây cảnh treo tường", "plant_id": "1"},
      {"id": "8", "name": "Cây cảnh trang trí", "plant_id": "1"},
      {"id": "2", "name": "Cây cảnh sân vườn", "plant_id": "1"},
      {"id": "4", "name": "Cây cảnh để bàn", "plant_id": "1"},
      {"id": "5", "name": "Cây cảnh văn phòng", "plant_id": "1"},
      {"id": "1", "name": "Cây cảnh trong nhà", "plant_id": "1"}
    ],
    "list_img": [
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
      }
    ]
  }
];
