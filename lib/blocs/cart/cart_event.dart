abstract class CartEvent {
  String? _plantID;
  String? get plantID => _plantID;

  String? _cartID;
  String? get cartID => _cartID;

  int? _quantity;
  int? get quantity => _quantity;
}

class GetCart extends CartEvent {}

class AddToCart extends CartEvent {
  @override
  String? plantID;
  @override
  int? quantity;

  AddToCart(this.plantID, this.quantity) : super();
}

class MinusToCart extends CartEvent {
  @override
  String? cartID;
  @override
  int? quantity;

  MinusToCart(this.cartID, this.quantity) : super();
}

class RemovetoCart extends CartEvent {}
