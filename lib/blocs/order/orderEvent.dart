import 'package:thanhhoa_garden/models/order/order.dart';

abstract class OrderEvent {
  String? _orderID;
  String? get orderID => _orderID;

  String? _reason;
  String? get reason => _reason;

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

  bool? _isFeedback;
  bool? get isFeedback => _isFeedback;

  List<OrderObject>? _listOrder;
  List<OrderObject>? get listOrder => _listOrder;

  List<OrderDetail>? _listOrderDetial;
  List<OrderDetail>? get listOrderDetial => _listOrderDetial;
}

class GetAllOrderEvent extends OrderEvent {
  String? status;
  int pageNo;
  int pageSize;
  String sortBy;
  bool sortAsc;
  List<OrderObject> listOrder;

  GetAllOrderEvent(
      {this.status,
      required this.pageNo,
      required this.pageSize,
      required this.sortBy,
      required this.sortAsc,
      required this.listOrder})
      : super();
}

class GetAllOrderDetailEvent extends OrderEvent {
  bool isFeedback;
  int pageNo;
  int pageSize;
  String sortBy;
  bool sortAsc;

  List<OrderDetail> listOrderDetial;

  GetAllOrderDetailEvent(
      {required this.isFeedback,
      required this.pageNo,
      required this.pageSize,
      required this.sortBy,
      required this.sortAsc,
      required this.listOrderDetial})
      : super();
}

class CancelOrderEvent extends OrderEvent {
  String status;
  String orderID;
  String reason;

  CancelOrderEvent(
      {required this.status, required this.orderID, required this.reason})
      : super();
}

class GetByIDOrderEvent extends OrderEvent {
  @override
  String? id;
  GetByIDOrderEvent({this.id}) : super();
}
