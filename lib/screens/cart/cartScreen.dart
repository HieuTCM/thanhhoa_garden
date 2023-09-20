import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thanhhoa_garden/blocs/cart/cart_bloc.dart';

import 'package:thanhhoa_garden/components/appBar.dart';
import 'package:thanhhoa_garden/components/cart/listServiceCart_component.dart';
import 'package:thanhhoa_garden/components/cart/listcart_component.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/cart/cart.dart';
import 'package:thanhhoa_garden/models/contract/contact.dart';
import 'package:thanhhoa_garden/providers/cart/cart_provider.dart';
import 'package:thanhhoa_garden/screens/contract/confirmContactScreen.dart';
import 'package:thanhhoa_garden/screens/order/orderScreen.dart';
import 'package:thanhhoa_garden/utils/helper/shared_prefs.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int indexStack = 0;
  bool isSelected = false;

  var f = NumberFormat("###,###,###", "en_US");
  Map<String, int> listCart = {};

  double totalPrice = 0;
  double totalPriceService = 0;

  int totalPlant = 0;
  int totalService = 0;

  CartProvider cartProvider = CartProvider();
  late CartBloc cartBloc;

  List<OrderCart> listPlant = [];
  List<OrderCart> litsPlantinCart = [];

  List<int> indexService = [];
  List<ContactDetail> listContactDetail = [];
  List<ContactDetail> listContactDetailSelect = [];
  List<int> listIndex = [];

  @override
  void initState() {
    getListService();
    cartBloc = Provider.of<CartBloc>(context, listen: false);
    getCart();
    super.initState();
  }

  @override
  void dispose() {
    // cartBloc.dispose();
    super.dispose();
  }

  getCart() async {
    await cartProvider.getCart().then((value) {
      listPlant = cartProvider.list!;
    });
  }

  getListService() {
    var json = getListContactDetailFromSharedPrefs();
    for (var data in json) {
      setState(() {
        listContactDetail.add(ContactDetail.fromJson(data));
      });
    }
  }

  updateServiceCart(
    String type,
    int index,
  ) {
    switch (type) {
      case 'add':
        {
          setState(() {
            listContactDetailSelect.clear();
            listIndex.clear();
            indexService.add(index);
            totalService++;
            totalPriceService =
                totalPriceService + listContactDetail[index].totalPrice;
          });
          for (var index in indexService) {
            setState(() {
              listContactDetailSelect.add(listContactDetail[index]);
              listIndex.add(index);
            });
          }
        }
        ;
        break;
      case 'delete':
        {
          setState(() {
            listContactDetailSelect.clear();
            listIndex.clear();
            indexService.isNotEmpty ? indexService.remove(index) : null;
            totalService != 0 ? totalService-- : 0;
            totalPriceService != 0
                ? totalPriceService =
                    totalPriceService - listContactDetail[index].totalPrice
                : 0;

            // listContactDetail.removeAt(index);
            // Map<String, dynamic> map = Map<String, dynamic>();
            // map['detailModelList'] = listContactDetail;
            // sharedPreferences.setString('ContactDetail', json.encode(map));
          });
          for (var index in indexService) {
            setState(() {
              listContactDetailSelect.add(listContactDetail[index]);
              listIndex.add(index);
            });
          }
        }
        ;
        break;
      case 'remove':
        {
          setState(() {
            listContactDetailSelect.clear();
            listIndex.clear();
            indexService.remove(index);
            totalService--;
            totalPriceService =
                totalPriceService - listContactDetail[index].totalPrice;
          });
          for (var index in indexService) {
            setState(() {
              listContactDetailSelect.add(listContactDetail[index]);
              listIndex.add(index);
            });
          }
        }
        ;
        break;
    }
  }

  updatecart(String whereCall, String type, OrderCart cart, int num) {
    if (whereCall == 'checkBox') {
      switch (type) {
        case 'add':
          setCart(whereCall, cart, num);
          break;
        case 'remove':
          removeCart(whereCall, cart);
          break;
      }
    } else {
      Future.delayed(const Duration(seconds: 2)).then((value) {
        switch (type) {
          case 'add':
            setCart(whereCall, cart, num);
            break;
          case 'remove':
            removeCart(whereCall, cart);
            break;
        }
      });
    }
  }

  setCart(String whereCall, OrderCart cart, int num) {
    switch (whereCall) {
      case 'add':
        {
          setState(() {
            listCart[cart.plantID] = cart.quantity!;
            totalPlant = totalPlant + num;
            totalPrice = totalPrice + cart.plantPrice! * num;
          });
          getCart();
          break;
        }

      case 'checkBox':
        {
          setState(() {
            listCart[cart.plantID] = cart.quantity!;
            totalPlant = totalPlant + cart.quantity!;
            totalPrice = totalPrice + cart.plantPrice! * cart.quantity!;
          });
          getCart();
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
          getCart();
          break;
        }

      case 'checkBox':
        {
          setState(() {
            listCart.remove(cart.plantID);
            totalPlant = totalPlant - cart.quantity!;
            totalPrice = totalPrice - cart.plantPrice! * cart.quantity!;
          });
          getCart();
          break;
        }
    }
  }

  Color checkTextColor(bool bool) {
    if (bool) {
      return HintIcon;
    }
    return lightText;
  }

  Color checkbackColor(bool bool) {
    if (bool) {
      return barColor;
    }
    return buttonColor;
  }

  checkSelect(int index) {
    switch (index == indexStack) {
      case true:
        setState(() {
          isSelected = !isSelected;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: background,
        body: SingleChildScrollView(
            child: Stack(
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
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (indexStack == 1) {
                                setState(() {
                                  indexStack = 0;
                                  checkSelect(0);
                                });
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              width: 150,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: checkbackColor(isSelected)),
                              alignment: Alignment.center,
                              child: Text(
                                'Cây cảnh',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: checkTextColor(isSelected)),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (indexStack == 0) {
                                setState(() {
                                  indexStack = 1;
                                  checkSelect(1);
                                });
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              width: 150,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: checkbackColor(!isSelected)),
                              alignment: Alignment.center,
                              child: Text('Dịch vụ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: checkTextColor(!isSelected))),
                            ),
                          ),
                        ])),
                Container(
                  height: 10,
                  decoration: const BoxDecoration(color: divince),
                ),
                IndexedStack(
                  index: indexStack,
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: size.height - 250,
                      child: Consumer<CartProvider>(
                        builder: (context, value, _) {
                          return LitsCart(
                            callback: updatecart,
                          );
                        },
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        height: size.height - 250,
                        child: ListCartService(
                          callback: updateServiceCart,
                        ),
                      ),
                    ),
                  ],
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
            Positioned(
                top: size.height - 65,
                child: (indexStack == 0)
                    ? _floatingBarPlant()
                    : _floatingBarService()),
          ],
        )));
  }

  Widget _floatingBarPlant() {
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

  Widget _floatingBarService() {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10),
      height: 65,
      width: size.width,
      decoration: const BoxDecoration(color: barColor),
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          // Checkbox(
          //   value: true,
          //   onChanged: (value) {
          //     if (value!) {}
          //   },
          // ),
          // const Text('Tất cả',
          //     style: TextStyle(
          //         color: darkText, fontSize: 16, fontWeight: FontWeight.w500)),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Số dịch vụ $totalService',
                  style: const TextStyle(
                      color: darkText,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              Text('${f.format(totalPriceService)} đ',
                  style: const TextStyle(
                      color: priceColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            ],
          ),

          GestureDetector(
            onTap: () async {
              if (listContactDetailSelect.length > 3) {
                Fluttertoast.showToast(
                    msg: "Hợp đồng tối đa 3 dịch vụ",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ConfirmContactScreen(
                      listContact: listContactDetailSelect,
                      listIndex: listIndex,
                      callback: () {},
                      totalPriceService: totalPriceService,
                      totalService: totalService),
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
                'Tạo yêu cầu',
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
