import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thanhhoa_garden/blocs/cart/cart_bloc.dart';
import 'package:thanhhoa_garden/blocs/cart/cart_event.dart';

import 'package:thanhhoa_garden/components/appBar.dart';
import 'package:thanhhoa_garden/components/cart/listcart_component.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/bonsai/bonsai.dart';
import 'package:thanhhoa_garden/models/cart/cart.dart';
import 'package:thanhhoa_garden/providers/cart/cart_provider.dart';
import 'package:thanhhoa_garden/screens/order/orderScreen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var f = NumberFormat("###,###,###", "en_US");
  Map<String, int> listCart = {};
  double totalPrice = 0;
  int totalPlant = 0;
  CartProvider cartProvider = CartProvider();
  late CartBloc cartBloc;
  List<OrderCart> listPlant = [];
  List<OrderCart> litsPlantinCart = [];
  @override
  void initState() {
    cartBloc = Provider.of<CartBloc>(context, listen: false);
    getCart();
    super.initState();
  }

  getCart() async {
    await cartProvider.getCart().then((value) {
      listPlant = cartProvider.list!;
    });
  }

  updatecart(
    String whereCall,
    String type,
    OrderCart cart,
  ) {
    if (whereCall == 'checkBox') {
      switch (type) {
        case 'add':
          setCart(whereCall, cart);
          break;
        case 'remove':
          removeCart(whereCall, cart);
          break;
      }
    } else {
      Future.delayed(const Duration(seconds: 2)).then((value) {
        switch (type) {
          case 'add':
            setCart(whereCall, cart);
            break;
          case 'remove':
            removeCart(whereCall, cart);
            break;
        }
      });
    }
  }

  setCart(String whereCall, OrderCart cart) {
    switch (whereCall) {
      case 'add':
        {
          setState(() {
            listCart[cart.plantID] = cart.quantity!;
            totalPlant = totalPlant + 1;
            totalPrice = totalPrice + cart.plantPrice!;
          });
          break;
        }

      case 'checkBox':
        {
          setState(() {
            listCart[cart.plantID] = cart.quantity!;
            totalPlant = totalPlant + cart.quantity!;
            totalPrice = totalPrice + cart.plantPrice! * cart.quantity!;
          });
          break;
        }
    }
  }

  removeCart(String whereCall, OrderCart cart) {
    switch (whereCall) {
      case 'minus':
        {
          setState(() {
            listCart[cart.plantID] = cart.quantity!;
            totalPlant = totalPlant - 1;
            totalPrice = totalPrice - cart.plantPrice!;
          });
          break;
        }

      case 'checkBox':
        {
          setState(() {
            listCart.remove(cart.plantID);
            totalPlant = totalPlant - cart.quantity!;
            totalPrice = totalPrice - cart.plantPrice! * cart.quantity!;
          });
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: background,
        body: Stack(
          children: [
            Container(
              height: size.height,
              child: Column(children: [
                const SizedBox(
                  height: 35,
                ),
                AppBarWiget(
                  title: 'Giỏ Hàng Của Bạn',
                ),
                Container(
                  height: 10,
                  decoration: const BoxDecoration(color: divince),
                ),
                Expanded(
                  child: Consumer<CartProvider>(
                    builder: (context, value, _) {
                      return LitsCart(
                        callback: updatecart,
                      );
                    },
                  ),
                ),
                Container(
                  height: 10,
                  decoration: const BoxDecoration(color: divince),
                ),
                Container(
                  height: 65,
                ),
              ]),
            ),
            Positioned(top: size.height - 65, child: _floatingBar()),
          ],
        ));
  }

  Widget _floatingBar() {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10),
      height: 65,
      width: size.width,
      decoration: const BoxDecoration(color: barColor),
      child: Row(
        children: [
          // Checkbox(
          //   value: true,
          //   onChanged: (value) {
          //     if (value!) {}
          //   },
          // ),
          // const Text('Tất cả',
          //     style: TextStyle(
          //         color: darkText, fontSize: 16, fontWeight: FontWeight.w500)),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Số sản phẩm $totalPlant',
                  style: const TextStyle(
                      color: darkText,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              Text('${f.format(totalPrice)} đ',
                  style: const TextStyle(
                      color: priceColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            ],
          ),
          GestureDetector(
            onTap: () async {
              await getCart();
              litsPlantinCart.clear();
              listCart.forEach((key, value) {
                litsPlantinCart = [
                  ...litsPlantinCart,
                  ...listPlant
                      .where(
                          (element) => element.plantID.toString().contains(key))
                      .toList()
                ];
              });
              // print(litsPlantinCart.length);
              if (litsPlantinCart.length == 0) {
                Fluttertoast.showToast(
                    msg: "Bạn chưa chọn cây",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => OrderScreen(listPlant: litsPlantinCart),
                ));
              }
            },
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              width: 130,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: buttonColor, borderRadius: BorderRadius.circular(50)),
              child: const Text(
                'Mua hàng',
                style: TextStyle(
                    color: lightText,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
