import 'package:thanhhoa_garden/models/contract/contact.dart';

abstract class ContactEvent {
  String? _contactID;
  String? get contactID => _contactID;

  String? _status;
  String? get status => _status;

  int? _pageNo;
  int? get pageNo => _pageNo;

  int? _pageSize;
  int? get pageSize => _pageSize;

  String? _sortBy;
  String? get sortBy => _sortBy;

  bool? _sortAsc;
  bool? get sortAsc => _sortAsc;

  String? _reason;
  String? get reason => _reason;

  List<Contact>? _listContact;
  List<Contact>? get listContact => _listContact;

  List<ContactDetail>? _listContactDetail;
  List<ContactDetail>? get listContactDetail => _listContactDetail;
}

class GetAllContactEvent extends ContactEvent {
  String? status;
  int pageNo;
  int pageSize;
  String sortBy;
  bool sortAsc;
  List<Contact> listContact;

  GetAllContactEvent(
      {this.status,
      required this.pageNo,
      required this.pageSize,
      required this.sortBy,
      required this.sortAsc,
      required this.listContact})
      : super();
}

class GetAllContactDetailEvent extends ContactEvent {
  String? contactID;
  int pageNo;
  int pageSize;
  String sortBy;
  bool sortAsc;
  List<ContactDetail> listContactDetail;

  GetAllContactDetailEvent(
      {this.contactID,
      required this.pageNo,
      required this.pageSize,
      required this.sortBy,
      required this.sortAsc,
      required this.listContactDetail})
      : super();
}

class CancelContactEvent extends ContactEvent {
  String status;
  String contactID;
  String reason;

  CancelContactEvent(
      {required this.status, required this.contactID, required this.reason})
      : super();
}
