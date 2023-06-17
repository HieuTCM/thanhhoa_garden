abstract class CartEvent {
  int? _count;
  int? get count => _count;
}

class AddtoCart extends CartEvent {
  @override
  int? count;

  AddtoCart(this.count) : super();
}

class RemovetoCart extends CartEvent {}
