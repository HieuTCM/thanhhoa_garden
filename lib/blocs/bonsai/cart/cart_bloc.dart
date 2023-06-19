import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thanhhoa_garden/blocs/bonsai/cart/cart_event.dart';
import 'package:thanhhoa_garden/blocs/bonsai/cart/cart_state.dart';
import 'package:thanhhoa_garden/models/bonsai/bonsai.dart';
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
    _cartStateController.add(CartSuccess(list: []));
  }

  void send(CartEvent event) async {
    switch (event.runtimeType) {
      case AddtoCart:
        _cartStateController.add(CartLoading());
        await _cartProvider.addtoCart(event.bonsai!).then(
          (value) {
            final list = _cartProvider.lits;
            _cartStateController.add(CartSuccess(list: list!));
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
