import 'dart:convert';


String formatDate(String date) {
  try {
    DateTime dateTime = DateTime.parse(date);
    String hour = dateTime.hour.toString().padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');
    String formattedString =
        "$hour:$minute ${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year}";

    return formattedString;
  } catch (e) {
    print('This is not a valid JSON.');
  }
  return 'Đang cập nhật';
}
int formatNumDay(String day) {
  int fday = 0;
  switch (day) {
    case 'Thứ 2' : fday = 0;
    break;
    case 'Thứ 3' : fday = 1;
    break;
    case 'Thứ 4' : fday = 2;
    break;
    case 'Thứ 5' : fday = 3;
    break;
    case 'Thứ 6' : fday = 4;
    break;
    case 'Thứ 7' : fday = 5;
    break;
    case 'Chủ Nhật' : fday = 6;
    break;
    default : fday = 0;
  }
  return fday;
}

String formatDatenoTime(String date) {
  try {
    DateTime dateTime = DateTime.parse(date);
    String hour = dateTime.hour.toString().padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');
    String formattedString =
        "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year}";

    return formattedString;
  } catch (e) {
    print('This is not a valid JSON.');
  }
  return 'Đang cập nhật';
}