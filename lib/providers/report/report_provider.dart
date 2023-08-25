import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thanhhoa_garden/models/report/report.dart';
import 'package:thanhhoa_garden/utils/connection/utilsConnection.dart';
import 'package:thanhhoa_garden/utils/helper/shared_prefs.dart';
import 'package:http/http.dart' as http;

class ReportProvider extends ChangeNotifier {
  ReportModel? _report;
  List<ReportModel>? _listReport = [];

  ReportModel? get report => _report;
  List<ReportModel>? get list => _listReport;

  Future<bool> SendReport(String detailID, String reason) async {
    bool result = false;
    Map<String, String?> params =
        ({'description': reason, 'contractDetailID': detailID});
    var body = json.encode(params);
    var header = getheader(getTokenAuthenFromSharedPrefs());
    try {
      final res = await http.post(Uri.parse(mainURL + sendReportURL),
          headers: header, body: body);
      if (res.statusCode == 200) {
        result = true;
        notifyListeners();
      } else {
        result = false;
        notifyListeners();
      }
    } on HttpException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    return result;
  }

  Future<bool> getAllReport() async {
    bool result = false;
    List<ReportModel> list = [];

    var header = getheader(getTokenAuthenFromSharedPrefs());
    try {
      final res =
          await http.get(Uri.parse(mainURL + getReportURL), headers: header);
      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          var jsondata = json.decode(res.body);
          for (var data in jsondata) {
            _report = ReportModel.fromJson(data);
            list.add(_report!);
          }
        }
        _listReport = list;
        result = true;
        notifyListeners();
      } else {
        result = false;
        notifyListeners();
      }
    } on HttpException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    return result;
  }
}
