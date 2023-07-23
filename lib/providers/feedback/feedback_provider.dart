import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:thanhhoa_garden/blocs/feedback/feedback_event.dart';
import 'package:thanhhoa_garden/models/bonsaiImg.dart';
import 'package:thanhhoa_garden/models/feedback/feedback.dart';
import 'package:thanhhoa_garden/utils/connection/utilsConnection.dart';
import 'package:thanhhoa_garden/utils/helper/shared_prefs.dart';
import 'package:http/http.dart' as http;

class FeedbackProvider extends ChangeNotifier {
  FeedbackModel? _feedback;
  List<FeedbackModel>? _listFeedback;
  Rating? _rating;
  List<Rating>? _listRating;

  FeedbackModel? get feedback => _feedback;
  List<FeedbackModel>? get listFeedback => _listFeedback;
  List<Rating>? get listRating => _listRating;
  Rating? get rating => _rating;

  Future<bool> getAllFeedbackByPlantID(FeedbackEvent event) async {
    bool result = false;
    List<FeedbackModel> list = [];
    Map<String, dynamic> param = ({});
    param['plantID'] = '${event.plantID}';
    param['pageNo'] = '${event.pageNo}';
    param['pageSize'] = '${event.pageSize}';
    param['sortBy'] = event.sortBy;
    param['sortAsc'] = '${event.sortAsc}';

    String queryString = Uri(queryParameters: param).query;
    var header = getheader(getTokenAuthenFromSharedPrefs());
    try {
      final res = await http.get(
          Uri.parse(mainURL + getFeedbackByPlantIDURL + queryString),
          headers: header);
      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          var jsondata = json.decode(res.body);
          for (var data in jsondata) {
            _feedback = FeedbackModel.fromJson(data);
            list.add(_feedback!);
          }
        }
        _listFeedback = list;
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

  Future<bool> getAllFeedback(FeedbackEvent event) async {
    bool result = false;
    List<FeedbackModel> list = [];
    Map<String, dynamic> param = ({});
    param['pageNo'] = '${event.pageNo}';
    param['pageSize'] = '${event.pageSize}';
    param['sortBy'] = event.sortBy;
    param['sortAsc'] = '${event.sortAsc}';

    String queryString = Uri(queryParameters: param).query;
    var header = getheader(getTokenAuthenFromSharedPrefs());
    try {
      final res = await http.get(
          Uri.parse(mainURL + getFeedbackURL + queryString),
          headers: header);
      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          var jsondata = json.decode(res.body);
          for (var data in jsondata) {
            _feedback = FeedbackModel.fromJson(data);
            list.add(_feedback!);
          }
        }
        _listFeedback = list;
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

  Future<bool> getRating() async {
    bool result = false;
    List<Rating> list = [];
    var header = getheader(getTokenAuthenFromSharedPrefs());

    try {
      final res =
          await http.get(Uri.parse(mainURL + getRatingURL), headers: header);
      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          var jsondata = json.decode(res.body);
          for (var data in jsondata) {
            _rating = Rating.fromJson(data);
            list.add(_rating!);
          }
        }
        _listRating = list;
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

  Future<bool> createFeedback(Map<String, dynamic> jsondata) async {
    bool result = false;
    var body = json.encode(jsondata);
    var header = getheader(getTokenAuthenFromSharedPrefs());
    try {
      final res = await http.post(Uri.parse(mainURL + createFeedbackDURL),
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
}
