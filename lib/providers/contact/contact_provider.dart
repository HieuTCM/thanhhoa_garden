import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:thanhhoa_garden/blocs/contract/contactEvent.dart';
import 'package:thanhhoa_garden/models/contract/contact.dart';
import 'package:thanhhoa_garden/utils/connection/utilsConnection.dart';
import 'package:thanhhoa_garden/utils/helper/shared_prefs.dart';
import 'package:http/http.dart' as http;

class ContactProvider extends ChangeNotifier {
  List<String>? _enumStatus;
  List<String>? get enumStatus => _enumStatus;

  Contact? _contact;
  Contact? get contact => _contact;

  ContactDetail? _contactDetail;
  ContactDetail? get contactDetail => _contactDetail;

  List<Contact>? _list;
  List<Contact>? get list => _list;

  List<ContactDetail>? _listDetail;
  List<ContactDetail>? get listDetail => _listDetail;

  Future<bool> createContact(Map<String, dynamic> map) async {
    bool result = false;
    var body = json.encode(map);
    var header = getheader(getTokenAuthenFromSharedPrefs());
    try {
      final res = await http.post(Uri.parse(mainURL + createContactURL),
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

  Future<bool> getContactStatus() async {
    bool result = false;
    List<String> enumStatus = [];
    var header = getheader(getTokenAuthenFromSharedPrefs());
    try {
      final res =
          await http.get(Uri.parse(mainURL + contactStatus), headers: header);
      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          var jsondata = json.decode(res.body);
          enumStatus.add('ALL');
          for (var data in jsondata) {
            enumStatus.add(data);
          }
          _enumStatus = enumStatus;
          result = true;
          notifyListeners();
        }
      }
      notifyListeners();
    } on HttpException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return result;
  }

  Future<bool> getContactList(ContactEvent event) async {
    bool result = false;
    List<Contact> list = [];
    Map<String, dynamic> param = ({});
    param['pageNo'] = '${event.pageNo}';
    param['pageSize'] = '${event.pageSize}';
    param['sortBy'] = event.sortBy;
    param['sortAsc'] = '${event.sortAsc}';
    if (event.status != null) param['status'] = event.status;
    String queryString = Uri(queryParameters: param).query;
    var header = getheader(getTokenAuthenFromSharedPrefs());
    try {
      final res = await http.get(
          Uri.parse(mainURL + getContactURL + queryString),
          headers: header);
      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          var jsondata = json.decode(res.body);
          for (var data in jsondata) {
            _contact = Contact.fromJson(data);
            list.add(_contact!);
          }
        }
        _list = list;
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

  Future<bool> getContactDetailList(ContactEvent event) async {
    bool result = false;
    List<ContactDetail> list = [];
    Map<String, dynamic> param = ({});
    param['pageNo'] = '${event.pageNo}';
    param['pageSize'] = '${event.pageSize}';
    param['sortBy'] = event.sortBy;
    param['sortAsc'] = '${event.sortAsc}';
    String queryString = Uri(queryParameters: param).query;
    var header = getheader(getTokenAuthenFromSharedPrefs());
    try {
      final res = await http.get(
          Uri.parse(mainURL +
              getContactDetailURL +
              event.contactID! +
              '?' +
              queryString),
          headers: header);
      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          var jsondata = json.decode(res.body);
          for (var data in jsondata) {
            _contactDetail = ContactDetail.fromJson2(data);
            list.add(_contactDetail!);
          }
        }
        _listDetail = list;
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
