// ignore_for_file: constant_identifier_names, unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thanhhoa_garden/models/order/order.dart';

// const String GG_API_Key = 'AIzaSyA2yiHIRWwyTMebbwJmYDiQcN6AZxpyvrI';
const String GG_API_Key = 'AIzaSyCGhBhR1KfeRlTi_vn8vD8SZEmO1pr-74I';

const tabBackground = LinearGradient(
  colors: [
    Color(0xFF91C4C7),
    Color(0xFFC0DADC),
    Color(0xFFF1F7F9),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0.0, 0.3, 0.99],
  tileMode: TileMode.clamp,
);
const narBarBackgroud = LinearGradient(
  colors: [
    Color(0xFF0D6368),
    Color(0xFF91C4C7),
    Color(0xFFC0DADC),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0.0, 0.4, 0.99],
  tileMode: TileMode.clamp,
);

const background = Color(0xFFF1F7F9);
const divince = Color(0xFFD9D9D9);
const barColor = Color(0xFFC0DADC);
const buttonColor = Color(0xFF0D6368);
const darkText = Color(0xFF000000);
const lightText = Color(0xFFF8FDFF);
const highLightText = Color(0xFFFF97A3);
const ErorText = Color(0xFFFD6B6B);
const HintIcon = Color(0xFFA0A0A0);
const priceColor = Color(0xFFBD5864);

String convertStatus(String value) {
  String result = value;
  switch (value) {
    case "ALL":
      result = 'Tất cả';
      break;
    case "WAITING":
      result = 'Chờ xác nhận';
      break;
    case "APPROVED":
      result = 'Đã xác nhận';
      break;
    case "DENIED":
      result = 'Bị từ chối';
      break;
    case "PACKAGING":
      result = 'Đang đóng gói';
      break;
    case "DELIVERING":
      result = 'Đang giao';
      break;
    case "RECEIVED":
      result = 'Đã nhận';
      break;
    case "STAFFCANCELED":
      result = 'Đã bị Hủy';
      break;
    case "CUSTOMERCANCELED":
      result = 'Đã huỷ';
      break;
  }
  return result;
}

String converDate(OrderObject order) {
  String result = order.createdDate.toString().substring(0, 10);
  switch (order.progressStatus) {
    case "WAITING":
      result = order.createdDate.toString().substring(0, 10);
      break;
    case "APPROVED":
      result = order.approveDate.toString().substring(0, 10);
      break;
    case "DENIED":
      result = order.rejectDate.toString().substring(0, 10);
      break;
    case "PACKAGING":
      result = order.packageDate.toString().substring(0, 10);
      break;
    case "DELIVERING":
      result = order.deliveryDate.toString().substring(0, 10);
      break;
    case "RECEIVED":
      result = order.receivedDate.toString().substring(0, 10);
      break;
    case "STAFFCANCELED":
      result = order.rejectDate.toString().substring(0, 10);
      break;
    case "CUSTOMERCANCELED":
      result = order.rejectDate.toString().substring(0, 10);
      break;
  }
  return result;
}

const NoIMG =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyRE2zZSPgbJThiOrx55_b4yG-J1eyADnhKw&usqp=CAU';

const NotiOrder1 = 'Thường xuyên theo dỗi đơn hàng của bạn nhé !!!';
const NotiOrder2 =
    'Gửi đánh giá của bạn về dịch vụ của Thanh Hoa để chúng tôi có thể mang đến trải nghiệm tốt hơn cho bạn.';

List<String> listReason() {
  return [
    'Đặt nhầm sản phẩm',
    'Đặt nhầm địa chỉ',
    'Phí vận chuyển cao',
    'Không muốn chuyển khoản',
    'Đơn trùng',
    'Đã mua tại quầy',
    'Khách không muốn mua nữa',
    'Lý do khác'
  ];
}
