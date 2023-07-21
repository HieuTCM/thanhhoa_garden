import 'package:thanhhoa_garden/models/bonsai/bonsai.dart';
import 'package:thanhhoa_garden/models/order/order.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class ListOrderSuccess extends OrderState {
  final List<OrderObject>? listOrder;
  ListOrderSuccess({required this.listOrder});
}

class OrderSuccess extends OrderState {
  final OrderObject? Order;
  OrderSuccess({required this.Order});
}

class OrderFailure extends OrderState {
  final String errorMessage;
  OrderFailure({required this.errorMessage});
}

class OrderCancelSuccess extends OrderState {
  final String errorMessage;
  OrderCancelSuccess({required this.errorMessage});
}
