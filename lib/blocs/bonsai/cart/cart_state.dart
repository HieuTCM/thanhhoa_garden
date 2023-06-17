abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  int? Cart;
  CartSuccess({required this.Cart});
}

class CartFailure extends CartState {
  final String errorMessage;
  CartFailure({required this.errorMessage});
}
