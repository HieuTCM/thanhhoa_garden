import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thanhhoa_garden/blocs/bonsai/cart/cart_event.dart';
import 'package:thanhhoa_garden/blocs/bonsai/cart/cart_state.dart';
import 'package:thanhhoa_garden/providers/bonsai/cart_provider.dart';

class CartBloc {
  final CartProvider _cartProvider;
  final StreamController<CartState> _cartStateController =
      StreamController<CartState>();

  Stream<CartState> get cartStateStream =>
      _cartStateController.stream.asBroadcastStream();
  StreamController<CartState> get cartStateController => _cartStateController;

  CartBloc({required CartProvider cartProvider})
      : _cartProvider = cartProvider {
    _cartStateController.add(CartSuccess(Cart: 0));
  }

  void send(CartEvent event) async {
    switch (event.runtimeType) {
      case AddtoCart:
        _cartStateController.add(CartLoading());
        await _cartProvider.addtoCart(event.count).then(
          (value) {
            final count = _cartProvider.count;
            _cartStateController.add(CartSuccess(Cart: count));
          },
        );

        break;
      case RemovetoCart:
        break;
    }
  }

  void dispose() {
    _cartStateController.close();
  }
}
