import 'package:thanhhoa_garden/models/order/order.dart';

abstract class OrderEvent {
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

  List<OrderObject>? _listOrder;
  List<OrderObject>? get listOrder => _listOrder;
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

class SearchOrderEvent extends OrderEvent {}

class GetByIDOrderEvent extends OrderEvent {
  @override
  String? id;
  GetByIDOrderEvent({this.id}) : super();
}
