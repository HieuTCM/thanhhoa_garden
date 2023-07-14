import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thanhhoa_garden/blocs/cart/cart_event.dart';
import 'package:thanhhoa_garden/blocs/cart/cart_state.dart';

import 'package:thanhhoa_garden/models/bonsai/bonsai.dart';
import 'package:thanhhoa_garden/providers/cart/cart_provider.dart';

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
      case GetCart:
        _cartStateController.add(CartLoading());
        await _cartProvider.getCart().then(
          (value) {
            if (value) {
              final list = _cartProvider.list;
              _cartStateController.add(CartSuccess(list: list!));
            } else {}
          },
        );
        break;
      case AddToCart:
        _cartStateController.add(CartLoading());
        await _cartProvider.AddToCart(event.plantID, event.quantity).then(
          (value) {
            if (value) {
            } else {
              Fluttertoast.showToast(
                  msg: "Thêm cây thất bại",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
        );

        break;
      case MinusToCart:
        _cartStateController.add(CartLoading());
        await _cartProvider.MinustoCart(event.cartID, event.quantity).then(
          (value) {
            if (value) {
            } else {
              Fluttertoast.showToast(
                  msg: "cập nhật thất bại",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
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
