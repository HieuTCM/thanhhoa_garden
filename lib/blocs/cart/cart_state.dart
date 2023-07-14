import 'package:thanhhoa_garden/models/bonsai/bonsai.dart';
import 'package:thanhhoa_garden/models/cart/cart.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  List<OrderCart> list;
  CartSuccess({required this.list});
}

class CartFailure extends CartState {
  final String errorMessage;
  CartFailure({required this.errorMessage});
}
