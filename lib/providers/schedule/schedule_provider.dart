import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:thanhhoa_garden/models/contract/contact.dart';
import 'package:thanhhoa_garden/models/workingDate/working_date.dart';
import '../../utils/connection/utilsConnection.dart';
import '../../utils/helper/shared_prefs.dart';
import '../../constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<List<WorkingDate>> fetchSchedule() async {
  var header = getheader(getTokenAuthenFromSharedPrefs());

  String url = mainURL + getScheduleURL;

  final response = await http.get(
    Uri.parse(url),
    headers: header,
  );
  final responseJson = jsonDecode(response.body);
  if (response.statusCode == 200) {
    List<dynamic> jsonData = responseJson as List<dynamic>;
    List<WorkingDate> schedule = jsonData
        .map((json) => WorkingDate.fromJson(json as Map<String, dynamic>))
        .toList();
    print(responseJson);
    return schedule;
  } else {
    throw Exception('Failed to fetch contract details');
  }
}

Future<List<ContactDetail>> fetchScheduleInWeek(from, to) async {
  var header = getheader(getTokenAuthenFromSharedPrefs());
  String url = '$mainURL${getScheduleInWeekURL}from=$from&to=$to';

  final response = await http.get(
    Uri.parse(url),
    headers: header,
  );
  final decoded = utf8.decode(response.bodyBytes);
  print(decoded);
  if (response.statusCode == 200) {
    List<ContactDetail> contractDetails = ((jsonDecode(decoded)) as List)
        .map((json) => ContactDetail.fromJson2(json))
        .toList();
    return contractDetails;
  } else {
    throw Exception('Failed to fetch contract details');
  }
}

Future ConfirmWorkingDate(contractDetailID) async {
  var header = getheader(getTokenAuthenFromSharedPrefs());
  final response = await http.post(
    Uri.parse(mainURL + confirmWorkingURL + contractDetailID),
    headers: header,
  );
  //final responseBody = response.body.toString();
  if (response.statusCode == 200) {
    Fluttertoast.showToast(
        msg: "Hoàn Tất Việc Này",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: buttonColor,
        textColor: Colors.white,
        fontSize: 16.0);
  } else if (response.body.isEmpty) {
    Fluttertoast.showToast(
        msg: "Đã Có Lỗi Xẩy Ra",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ErorText,
        textColor: Colors.white,
        fontSize: 16.0);
  } else {
    throw Exception('Đã có lỗi: ${response.statusCode}');
  }
}

Future<bool?> checkWorkingDate(contractDetailID, date) async {
  var header = getheader(getTokenAuthenFromSharedPrefs());
  String url = mainURL +
      '/workingDate/getByWorkingDate?contractDetailID=$contractDetailID&date=$date';
  final response = await http.get(
    Uri.parse(url),
    headers: header,
  );

  if (response.statusCode == 200) {
    if (response.body.isNotEmpty) {
      print('co ngay nay');
      return true;
    }
    print('khong co ngay nay');
    return false;
  } else {
    Fluttertoast.showToast(
        msg: "Đã Có Lỗi Xẩy Ra",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ErorText,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  return null;
}
