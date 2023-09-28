// ignore_for_file: constant_identifier_names, unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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

String convertStatusOrder(String value) {
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

String convertStatusContact(String value) {
  String result = value;
  switch (value) {
    case "ALL":
      result = 'Tất cả';
      break;
    case "WAITING":
      result = 'Chờ xác nhận';
      break;
    case "CONFIRMING":
      result = 'Đang xác nhận';
      break;
    case "CUSTOMERCANCELED":
      result = 'Đã huỷ';
      break;
    case "STAFFCANCELED":
      result = 'Bị Hủy';
      break;
    case "DENIED":
      result = 'Bị từ chối';
      break;
    case "WORKING":
      result = 'Đang hoạt động';
      break;
    case "DONE":
      result = 'Hoàn thành';
      break;
    case "APPROVED":
      result = 'Đã xác nhận';
      break;
    case "SIGNED":
      result = 'Đã ký';
      break;
  }
  return result;
}

String convertStatusReport(String value) {
  String result = value;
  switch (value) {
    case "NEW":
      result = 'Mới';
      break;
    case "INACTIVE":
      result = 'Bị từ chối';
      break;
    case "DONE":
      result = 'Đã xác nhận';
      break;
    case "DENIED":
      result = 'Đã bị từ chối';
      break;
    case "APPROVED":
      result = 'Đã xác nhận';
      break;
  }
  return result;
}

String convertStatusWorkingDate(String value) {
  String result = value;
  switch (value) {
    case "WAITING":
      result = 'Chờ thực hiện';
      break;
    case "WORKING":
      result = 'Đang thực hiện';
      break;
    case "DONE":
      result = 'Hoàn thành';
      break;
    case "CUSTOMERCANCELED":
      result = 'KH Hủy';
      break;
    case "STAFFCANCELED":
      result = 'Hủy';
      break;
  }
  return result;
}

Color colorWorkingDate(String value) {
  Color result = Colors.black;
  switch (value) {
    case "WAITING":
      result = Colors.yellow.shade700;
      break;
    case "WORKING":
      result = Colors.green;
      break;
    case "DONE":
      result = buttonColor;
      break;
    case "CUSTOMERCANCELED":
      result = Colors.red;
      break;
    case "STAFFCANCELED":
      result = Colors.red;
      break;
  }
  return result;
}

String scoreFeedback(int score) {
  switch (score) {
    case 1:
      return 'Chưa hài lòng';
    case 2:
      return 'Tạm ổn';
    case 3:
      return 'Bình thường';
    case 4:
      return 'Hài lòng';
    default:
      return 'Rất hài lòng';
  }
}

String convertDate(OrderObject order) {
  String result = order.createdDate.toString().substring(0, 10);
  switch (order.progressStatus) {
    case "WAITING":
      order.createdDate == null
          ? result = result
          : result = order.createdDate.toString().substring(0, 10);
      break;
    case "APPROVED":
      order.approveDate == null
          ? result = result
          : result = order.approveDate.toString().substring(0, 10);
      break;
    case "DENIED":
      order.rejectDate == null
          ? result = result
          : result = order.rejectDate.toString().substring(0, 10);
      break;
    case "PACKAGING":
      order.packageDate == null
          ? result = result
          : result = order.packageDate.toString().substring(0, 10);
      break;
    case "DELIVERING":
      order.deliveryDate == null
          ? result = result
          : result = order.deliveryDate.toString().substring(0, 10);
      break;
    case "RECEIVED":
      order.receivedDate == null
          ? result = result
          : result = order.receivedDate.toString().substring(0, 10);
      break;
    case "STAFFCANCELED":
      order.rejectDate == null
          ? result = result
          : result = order.rejectDate.toString().substring(0, 10);
      break;
    case "CUSTOMERCANCELED":
      order.rejectDate == null
          ? result = result
          : result = order.rejectDate.toString().substring(0, 10);
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
    'không muốn mua nữa',
    'Lý do khác'
  ];
}

List<String> listReasonContract() {
  return [
    'Thêm dịch vụ khác',
    'Chọn Nhầm dịch vụ',
    'Chi phí này quá cao',
    'không muốn thuê dịch vụ nữa',
    'Lý do khác'
  ];
}

List<String> tab = [
  ('Hôm nay'),
  ('Lịch theo tháng'),
  // ('Lịch theo HĐ'),
];
String getDate(String date) {
  DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
  return date = DateFormat('dd/MM/yyyy hh:mm a').format(parseDate);
}

String formatDate1(DateTime date) {
  String result = DateFormat('dd/MM/yyyy').format(date);
  return result;
}

String getToday(DateTime date) {
  String result = DateFormat('yyyy-MM-dd').format(date);
  return result;
}

String formatDateStartDateContact(String date) {
  DateTime parseDate = DateFormat("dd/MM/yyyy").parse(date);
  return date = DateFormat('yyyy-MM-dd').format(parseDate);
}

String formatDateShow(String date) {
  DateTime parseDate = DateFormat("yyyy-MM-dd").parse(date);
  return date = DateFormat('dd/MM/yyyy').format(parseDate);
}

var f = NumberFormat("###,###,###", "en_US");
String setPriceService(double price, int type, int pack, int months) {
  return f.format(price * months +
      (price * type / 100) * months -
      (price * pack / 100) * months);
}

int countMonths(DateTime date1, DateTime date2) {
  int months = (date2.difference(date1).inDays / 31).ceil();
  return months;
}

const String policyOrder =
    'Chính Sách Đơn Hàng:\n1.Xác Nhận Đơn Hàng:\nĐơn hàng do khách hàng tạo cần được xác nhận bởi người quản lý.\n2.Hủy Đơn Hàng Trong Quá Trình Xem Xét:\nKhách hàng có thể hủy đơn hàng trong thời gian chờ người quản lý duyệt đơn hàng.\n3.Không Thể Sửa Đổi Sau Xác Nhận:'
    'Sau khi đơn hàng đã được người quản lý duyệt, sẽ không thể thực hiện bất kỳ sửa đổi nào.\n4.Hủy Đơn Hàng Bởi Thanh Hoa:'
    'Thanh Hoa sẽ hủy đơn hàng nếu có vấn đề về đơn hàng hoặc cần thực hiện các điều chỉnh.\n'
    '5.Thông Báo Về Giao Hàng:\n'
    'Khách hàng lưu ý theo dõi điện thoại trong quá trình giao hàng. Nếu không thể liên hệ nhiều lần, Thanh Hoa có quyền hủy đơn hàng hoặc chọn ngày giao hàng thay thế.\n'
    '6.Xác Nhận Giao Nhận Cây Cảnh:\n'
    'Khi giao nhận cây cảnh, nhân viên sẽ chụp hình để xác nhận công việc. Vì vậy, đề nghị khách hàng vui lòng hợp tác với nhân viên giao hàng.\n'
    '7.Xác Nhận Đơn Hàng Tại Cửa Hàng:\n'
    '+Các đơn đặt hàng do nhân viên cửa hàng tạo để mua hàng tại cửa hàng sẽ được xác nhận ngay lập tức. Do đó, các đơn đặt hàng như vậy không thể bị hủy bỏ.\n'
    '8.Bảo Mật Thông Tin Khách Hàng:\n'
    'Thanh Hoa phải đảm bảo tính bảo mật của thông tin khách hàng.\n'
    '9.Độ Chính Xác Của Thông Tin Khách Hàng:\n'
    'Thông tin khách hàng cung cấp cho Thanh Hoa phải chính xác.\n'
    '10.Độ Chính Xác Của Thông Tin Thanh Hoa:\n'
    'Thông tin Thanh Hoa cung cấp cho khách hàng phải chính xác.\n'
    '11.Xác Nhận Thông Tin Giao Dịch:\n'
    'Mọi thông tin giao dịch cần phải được xác nhận bởi cả hai bên.\n';

const String policyContract = 'Điều khoản hợp đồng'
    '\n1.Tạo và xác nhận hợp đồng:'
    '\nHợp đồng tạo khách hàng cần được người quản lý xác nhận.'
    '\n2.Hủy Trong Quá trình Người Quản lý Lý Xem:'
    '\nTrong thời gian chờ trình quản lý đồng bộ, khách hàng có thể hủy hợp đồng.'
    '\n3.Hoàn Thiện và Chỉnh Hợp Đồng:'
    '\nSau khi người quản lý xác nhận đồng ý, không thể sửa đổi bất cứ điều gì.'
    '\n4.Hủy và Điều chỉnh bởi Thanh Hóa:'
    '\nThanh Hóa có quyền hủy bỏ hoặc điều chỉnh đồng bộ nếu có vấn đề xảy ra.'
    '\n5.Ký hiệu Hợp Đồng và Phân Phối:'
    '\nSau khi người quản lý xác nhận đồng ý, hợp đồng sẽ được gửi cho khách hàng để ký kết.'
    '\n6.Bản Sao Hợp Đồng và Lưu Trữ:'
    '\nMỗi bên chứa một bản sao đã ký và một bản sao sẽ được lưu trữ trong hệ thống của Thanh Hóa.'
    '\n7.Hợp Đồng Tại Cửa Hàng:'
    '\nHợp đồng tạo tại cửa hàng sẽ được ký tại cửa hàng với tham số của người quản lý cửa hàng. Mỗi bên chứa một bản sao và một bản sao sẽ được lưu trữ trong hệ thống của Thanh Hóa.'
    '\n8.Thời gian làm việc hiệu lực:'
    '\nSau khi ký hợp đồng, thời gian làm việc được xác định sẽ có hiệu lực như trong hợp đồng. Khách hàng có thể theo dõi tiến trình công việc trực tiếp qua ứng dụng "Thanh Hóa".'
    '\n9.Báo Cáo Lỡ Hẹn:'
    '\nTrong những ngày dự phòng nhưng nhân viên chưa đến, khách hàng có thể sử dụng ứng dụng để tạo báo cáo và thông báo cho Thanh Hóa.'
    '\n10.Báo Cáo Do Khách Hàng Tạo Ra:'
    '\nMọi báo cáo do khách hàng tạo ra sẽ được người quản lý hợp lý đồng xem xét và phê duyệt.'
    '\n11.Phê duyệt Báo Cáo:'
    '\nNếu báo cáo được người quản lý hợp lý chấp thuận, khách hàng sẽ nhận được dịch vụ bỏ lỡ vào một ngày thay thế.'
    '\n12.Nhiệm vụ trong Công Cáo:'
    '\nKhách hàng phải sử dụng tính năng báo cáo một cách trách nhiệm và người quản lý luôn xác minh các báo cáo để đảm bảo tính chính xác.'
    '\n13.Vi Phạm Hợp Đồng:'
    '\nTrong thời hạn hợp nhất, nếu có một bên trong phạm vi điều khoản, bên kia có quyền yêu cầu chấm dứt hợp đồng và thực hiện các thủ tục liên tục và tương ứng phí.'
    '\n14.Bảo Mật Thông Tin Hàng Hàng:'
    '\nThanh Hóa phải đảm bảo tính bảo mật của thông tin khách hàng.'
    '\n16.Độ Chính Xác Của Thông Tin Hàng Hàng:'
    '\nCung cấp thông tin khách hàng cho Thanh Hóa phải chính xác.'
    '\n17.Độ Chính xác Thông tin của Thanh Hóa:'
    '\nThông tin Thanh Hóa cung cấp cho khách hàng phải chính xác.'
    '\n18.Xác nhận Nhận Thông Tin Giao Dịch:'
    '\nMọi thông tin liên quan đến giao dịch phải được xác định bởi cả hai bên.';

dynamic showPolyci(String policy, context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Center(
              child: Text(
                'Điều khoảng',
                style: TextStyle(color: buttonColor, fontSize: 25),
              ),
            ),
            content: SingleChildScrollView(child: Text(policy)));
      });
}
