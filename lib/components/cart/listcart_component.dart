import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thanhhoa_garden/blocs/cart/cart_bloc.dart';
import 'package:thanhhoa_garden/blocs/cart/cart_event.dart';

import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/cart/cart.dart';
import 'package:thanhhoa_garden/providers/cart/cart_provider.dart';
import 'package:thanhhoa_garden/screens/bonsai/bonsaidetail.dart';

class LitsCart extends StatefulWidget {
  Function callback;
  LitsCart({super.key, required this.callback});

  @override
  State<LitsCart> createState() => _LitsCartState();
}

class _LitsCartState extends State<LitsCart> {
  Map<String, bool> values = {};
  Map<String, bool> quantity = {};
  bool isLoading = true;
  CartProvider cartProvider = CartProvider();
  late CartBloc cartBloc;
  TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    cartBloc = Provider.of<CartBloc>(context, listen: false);
    getCart();
    super.initState();
  }

  getCart() async {
    await cartProvider.getCart().then((value) {
      var list = cartProvider.list ?? [];
      if (list.isNotEmpty) {
        for (var cart in list) {
          setState(() {
            values[cart.plantID] = false;
          });
        }
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    // cartBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Consumer<CartProvider>(
            builder: (context, value, _) {
              return _litscart(value.list!);
            },
          );
  }

  Widget _litscart(List<OrderCart> list) {
    return (isLoading)
        ? Container()
        : list.isEmpty
            ? const Center(
                child: Text('Giỏ hàng trống'),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return _cartTab(list[index]);
                },
              );
  }

  Widget _cartTab(OrderCart cart) {
    var f = NumberFormat("###,###,###", "en_US");
    var size = MediaQuery.of(context).size;
    return (isLoading)
        ? Container()
        : GestureDetector(
            onTap: () {
              print('detail');
            },
            child: Container(
              width: size.width,
              margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
              height: 120,
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.2,
                    child: Checkbox(
                      value: values[cart.plantID] ?? true,
                      onChanged: (value) {
                        if (value!) {
                          widget.callback('checkBox', 'add', cart);
                        } else {
                          widget.callback('checkBox', 'remove', cart);
                        }
                        setState(() {
                          values[cart.plantID] = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    width: size.width * 0.8 - 20,
                    decoration: BoxDecoration(
                        gradient: tabBackground,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(children: [
                      Container(
                          padding: EdgeInsets.zero,
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(cart.image ??
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyRE2zZSPgbJThiOrx55_b4yG-J1eyADnhKw&usqp=CAU')),
                          )),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 10, left: 10, bottom: 10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: size.width * 0.8 - 160,
                                child: AutoSizeText(
                                  cart.plantName,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Text(
                                '${f.format(cart.plantPrice)} đ',
                                style: const TextStyle(
                                    color: priceColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              const Expanded(child: SizedBox()),
                              SizedBox(
                                width: size.width * 0.8 - 165,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        if (values[cart.plantID]!) {
                                          widget.callback(
                                              'minus', 'remove', cart);
                                        }
                                        cartBloc.send(MinusToCart(
                                            cart.id, cart.quantity! - 1));
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: buttonColor,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: const Text('-',
                                            style: TextStyle(
                                                color: lightText,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _amountController.clear();
                                        });
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Cập nhật số lương'),
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: [
                                                    TextFormField(
                                                      controller:
                                                          _amountController,
                                                      decoration:
                                                          const InputDecoration(
                                                        hintText: 'Số lượng',
                                                      ),
                                                      keyboardType:
                                                          TextInputType.number,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text(
                                                    'Cập nhật',
                                                    style: TextStyle(
                                                        color: buttonColor,
                                                        fontSize: 18),
                                                  ),
                                                  onPressed: () {
                                                    if (_amountController
                                                            .text ==
                                                        '') {
                                                      Fluttertoast.showToast(
                                                          msg: "Nhập Số Lượng",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                              Colors.red,
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 16.0);
                                                    } else if (int.parse(
                                                            _amountController
                                                                .text) <
                                                        0) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Số Lượng Lớn Hơn 0",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                              Colors.red,
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 16.0);
                                                    } else {
                                                      cartBloc.send(MinusToCart(
                                                          cart.id,
                                                          int.parse(
                                                              _amountController
                                                                  .text)));
                                                    }
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 40,
                                        child: Text(
                                          cart.quantity.toString(),
                                          style: const TextStyle(fontSize: 17),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (values[cart.plantID]!) {
                                          widget.callback('add', 'add', cart);
                                        }
                                        cartBloc
                                            .send(AddToCart(cart.plantID, 1));
                                        print('plus');
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: buttonColor,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: const Text('+',
                                            style: TextStyle(
                                                color: lightText,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ]),
                      )
                    ]),
                  )
                ],
              ),
            ));
  }
}
