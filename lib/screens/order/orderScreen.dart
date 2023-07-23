import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thanhhoa_garden/blocs/cart/cart_bloc.dart';
import 'package:thanhhoa_garden/blocs/cart/cart_event.dart';
import 'package:thanhhoa_garden/components/appBar.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/cart/cart.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:thanhhoa_garden/models/order/distance.dart';
import 'package:thanhhoa_garden/models/order/order.dart';
import 'package:thanhhoa_garden/models/store/store.dart';
import 'package:thanhhoa_garden/providers/authentication/authantication_provider.dart';
import 'package:thanhhoa_garden/providers/order/order_provider.dart';
import 'package:thanhhoa_garden/providers/store/store_provider.dart';
import 'package:thanhhoa_garden/screens/home/homePage.dart';
import 'package:thanhhoa_garden/screens/order/mapScreen.dart';
import 'package:thanhhoa_garden/models/authentication/user.dart' as UserObj;
import 'package:thanhhoa_garden/screens/order/orderHistoryScreen.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';

class OrderScreen extends StatefulWidget {
  List<OrderCart> listPlant;
  OrderScreen({super.key, required this.listPlant});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var f = NumberFormat("###,###,###", "en_US");
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  late CartBloc cartBloc;

  MapController _mapController = MapController();
  List<LatLng> _routePoints = [];
  double _distance = 0.0;
  double lat = 10.81471;
  double long = 106.6773817;
  var oneDecimal = const Duration(milliseconds: 100);

  AuthenticationProvider _authenticationProvider = AuthenticationProvider();
  StoreProvider _storeProvider = StoreProvider();
  OrderProvider _orderProvider = OrderProvider();

  List<Store> listStore = [];
  UserObj.User? user;
  Distance distancePrice = Distance();

  Map<String, dynamic> listDistance = {};
  Map<String, dynamic> distance = {};

  LatLng origin = LatLng(0, 0);

  bool isLoading = false;
  @override
  void initState() {
    cartBloc = Provider.of<CartBloc>(context, listen: false);
    getListStore();
    super.initState();
  }

  getDistancePrice() async {
    await _orderProvider.getDistancePrice().then((value) {
      if (value) {
        setState(() {
          distancePrice = _orderProvider.distancePrice!;
          isLoading = false;
        });
      }
    });
  }

  getUserInfor() async {
    await _authenticationProvider.getUserInfor().then((value) {
      if (value) {
        setState(() {
          user = _authenticationProvider.loggedInUser;
          _nameController.text = user!.fullName;
          _emailController.text = user!.email;
          _phoneController.text = user!.phone;
          _addressController.text = user!.address;
        });
        getCoordinatesFromAddress(user!.address).then((value) {
          setState(() {
            origin = value;
            getDistanceNearBy().then((value) {
              distance = value;
              getDistancePrice();
            });
          });
        });
      }
    });
  }

  Future<LatLng> getCoordinatesFromAddress(String address) async {
    LatLng latLng = LatLng(0.0, 0.0);
    GeoData data = await Geocoder2.getDataFromAddress(
        address: address, googleMapApiKey: GG_API_Key, language: 'vi');
    latLng = LatLng(data.latitude, data.longitude);

    return latLng;
  }

  setAdress(String address, LatLng orgin) {
    setState(() {
      origin = orgin;
      _addressController.text = address;
      isLoading = true;
      getDistanceNearBy().then((value) {
        distance = value;
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  getListStore() async {
    isLoading = true;
    await _storeProvider.getStore().then((value) {
      if (value) {
        setState(() {
          listStore = _storeProvider.list!;
        });
      }
      getUserInfor();
    });
  }

  Future<Map<String, double>> getDistanceNearBy() async {
    Map<String, double> Distance = {};
    for (var store in listStore) {
      await getCoordinatesFromAddress(store.address).then((value) async {
        await getDistance(origin, value).then((value) {
          listDistance[store.id] = value;
        });
      });
    }
    double thevalue = listDistance.values.first ?? 0;
    String thekey = '';
    listDistance.forEach((k, v) {
      if (v < thevalue) {
        thevalue = v;
        thekey = k;
      }
    });
    Distance[thekey] = double.parse((thevalue / 1000).toStringAsFixed(1));
    return Distance;
  }

  Future<double> getDistance(LatLng origin, LatLng destination) async {
    double distance = 0.0;
    try {
      final res = await http.get(Uri.parse(
          'https://api.mapbox.com/directions/v5/mapbox/driving/${origin.longitude},${origin.latitude};${destination.longitude},${destination.latitude}?alternatives=false&annotations=state_of_charge%2Cduration&geometries=geojson&language=vi&overview=simplified&steps=true&access_token=sk.eyJ1IjoicGV4aW5ocHJvMjYiLCJhIjoiY2xpOXhpNHRwNGFxNzNrbnRrM2ZscjRnbSJ9.F9fRoMST9bhfFDgoZWZ5dQ'));
      if (res.statusCode == 200) {
        var jsondata = json.decode(res.body);

        distance = jsondata['routes'][0]['distance'] ?? 0;
      }
    } on HttpException catch (e) {}
    return distance;
  }

  @override
  void dispose() {
    cartBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: [
          SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 35,
              ),
              AppBarWiget(
                title: 'Xác Nhận Thanh Toán',
              ),
              Container(
                height: 10,
                decoration: const BoxDecoration(color: divince),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Thông tin sản phẩm',
                  style: TextStyle(
                      color: darkText,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(child: _listPlant(widget.listPlant)),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                height: 50,
                child: Row(children: [
                  Text(
                      '${widget.listPlant.fold(0, (sum, item) => sum + item.quantity!)} sản phẩm'),
                  const Spacer(),
                  Text(
                      '${f.format(widget.listPlant.fold(0.0, (sum, item) => sum + item.plantPrice! * item.quantity!))} đ'),
                ]),
              ),
              Container(
                height: 10,
                decoration: const BoxDecoration(color: divince),
              ),
              (user == null)
                  ? const SizedBox(
                      height: 200,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _shipTab(widget.listPlant),
                        Container(
                          height: 10,
                          decoration: const BoxDecoration(color: divince),
                        ),
                        _paymentTab()
                      ],
                    ),
              Container(
                height: 90,
              ),
            ]),
          ),
          Positioned(bottom: 0, child: _floatingBar()),
        ],
      ),
    );
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
          const Text('Tổng cộng : ',
              style: TextStyle(
                  color: darkText, fontSize: 16, fontWeight: FontWeight.w500)),
          (isLoading)
              ? const Text('0đ',
                  style: TextStyle(
                      color: priceColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500))
              : Text(
                  '${f.format((widget.listPlant.fold(0.0, (sum, item) => sum + item.plantPrice! * item.quantity!)) + (widget.listPlant.fold(0.0, (sum, item) => sum + item.shipPrice! * item.quantity!)) + ((distance.values.first) * distancePrice.pricePerKm ?? 0))} đ',
                  style: const TextStyle(
                      color: priceColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
          const Spacer(),
          (isLoading)
              ? Container()
              : GestureDetector(
                  onTap: () {
                    List<Map<String, dynamic>> plant = [];
                    String method = COD ? 'Offline' : 'Online';
                    double dis = distance.values.first;
                    OrderObject order = OrderObject(
                        fullName: _nameController.text,
                        email: _emailController.text,
                        phone: _phoneController.text,
                        address: _addressController.text,
                        paymentMethod: method,
                        distance: dis);

                    for (var data in widget.listPlant) {
                      plant.add(data.toJson());
                    }
                    var data = order.createOrder(plant, distance.keys.first,
                        distancePrice.distancePriceID);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Center(
                            child: Text(
                              'Xác Nhận Đơn Hàng',
                              style:
                                  TextStyle(color: buttonColor, fontSize: 25),
                            ),
                          ),
                          content: SizedBox(
                            height: 395,
                            width: size.width - 10,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _rowInfor('Tên', order.fullName),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  _rowInfor('Email', order.email),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  _rowInfor('Số điện thoại', order.phone),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 7,
                                        width: 7,
                                        decoration: BoxDecoration(
                                            color: buttonColor,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'Địa chỉ: ',
                                        style: TextStyle(
                                            color: buttonColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: size.width - 10,
                                    child: AutoSizeText(
                                      '\t\t' + order.address,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'Thông tin đơn hàng : ',
                                    style: TextStyle(
                                        color: buttonColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(children: [
                                    Text(
                                        '${widget.listPlant.fold(0, (sum, item) => sum + item.quantity!)} sản phẩm'),
                                    const Spacer(),
                                    const Text('Giá: '),
                                    Text(
                                      '${f.format(widget.listPlant.fold(0.0, (sum, item) => sum + item.plantPrice! * item.quantity!))} đ',
                                      style: const TextStyle(color: priceColor),
                                    ),
                                  ]),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: const [Text('Phí giao hàng: ')],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text('Phí vận chuyển cây : ',
                                                style: TextStyle(
                                                    color: darkText,
                                                    fontSize: 16)),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text('Phí giao hàng: ',
                                                style: TextStyle(
                                                    color: darkText,
                                                    fontSize: 16)),
                                          ]),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              '${f.format(widget.listPlant.fold(0.0, (sum, item) => sum + item.shipPrice! * item.quantity!))} đ',
                                              style: const TextStyle(
                                                  color: priceColor)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              '${f.format((distance.values.first) * distancePrice.pricePerKm ?? 0)} đ',
                                              style: const TextStyle(
                                                  color: priceColor)),
                                          Text(
                                              ' ( ${(distance.values.first)} Km )',
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 15)),
                                        ],
                                      )
                                    ],
                                  ),
                                  Center(
                                    child: Column(children: [
                                      const Text('Tổng cộng : ',
                                          style: TextStyle(
                                              color: darkText,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          '${f.format((widget.listPlant.fold(0.0, (sum, item) => sum + item.plantPrice! * item.quantity!)) + (widget.listPlant.fold(0.0, (sum, item) => sum + item.shipPrice! * item.quantity!)) + ((distance.values.first) * distancePrice.pricePerKm ?? 0))} đ',
                                          style: const TextStyle(
                                              color: priceColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                    ]),
                                  )
                                ]),
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 110,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        color: buttonColor,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: const Text('Quay lại',
                                        style: TextStyle(
                                            color: lightText,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    OverlayLoadingProgress.start(context);
                                    _orderProvider
                                        .createOrder(data)
                                        .then((value) {
                                      if (value) {
                                        cartBloc.send(GetCart());

                                        Fluttertoast.showToast(
                                            msg: "Tạo Đơn Hàng Thành Công",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: buttonColor,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        Navigator.of(context)
                                            .pushReplacement(MaterialPageRoute(
                                          builder: (context) =>
                                              const OrderHistoryScreen(),
                                        ));
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Tạo Đơn Hàng Thất Bại",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                      OverlayLoadingProgress.stop();
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 110,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        color: buttonColor,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: const Text('Xác Nhận',
                                        style: TextStyle(
                                            color: lightText,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    width: 130,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: const Text(
                      'Đặt hàng',
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

  Widget _listPlant(List<OrderCart> listPlant) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: listPlant.length,
      itemBuilder: (context, index) {
        return _plantTab(listPlant[index]);
      },
    );
  }

  Widget _plantTab(OrderCart cart) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
            width: size.width,
            margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
            height: 80,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.zero,
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(cart.image ??
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyRE2zZSPgbJThiOrx55_b4yG-J1eyADnhKw&usqp=CAU')),
                    )),
                const SizedBox(
                  width: 10,
                ),
                Text(cart.plantName,
                    style: const TextStyle(
                        color: darkText,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('x${cart.quantity}'),
                      Text('${f.format(cart.quantity! * cart.plantPrice!)} đ')
                    ],
                  ),
                )
              ],
            )),
        const Divider(
          height: 2,
          color: Colors.grey,
        )
      ],
    );
  }

  bool _visibility = false;
  Widget _shipTab(List<OrderCart> listPlant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Thông tin giao hàng',
            style: TextStyle(
                color: darkText, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        //Full name
        _textFormField("Tên người nhận", 'Nhập tên người nhận', false, null,
            _nameController),
        //Email
        _textFormField("Email người nhận", 'Nhập Email người nhận', false, null,
            _emailController),
        //Phone
        _textFormField("Số điện thoại người nhận", 'Nhập số điện thoại', false,
            null, _phoneController),
        //address
        _textFormField(
            "Địa chỉ giao hàng", 'Bấm vào đây để chọn địa chỉ !!!', true, () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MapScreen(callback: setAdress),
          ));
        }, _addressController),
        GestureDetector(
          onTap: () {
            setState(() {
              _visibility = !_visibility;
            });
          },
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: buttonColor),
              child: const Text(
                'Kiểm tra phí vận chuyển',
                style: TextStyle(
                    color: lightText,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        Visibility(
          visible: _visibility,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Thông tin giao hàng',
                  style: TextStyle(
                      color: darkText,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              (!isLoading)
                  ? Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Phí vận chuyển cây : ',
                                    style: TextStyle(
                                        color: darkText, fontSize: 16)),
                                Text('Phí giao hàng: ',
                                    style: TextStyle(
                                        color: darkText, fontSize: 16)),
                              ]),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                  '${f.format(widget.listPlant.fold(0.0, (sum, item) => sum + item.shipPrice! * item.quantity!))} đ',
                                  style: const TextStyle(
                                      color: darkText, fontSize: 16)),
                              Text(
                                  '${f.format((distance.values.first) * distancePrice.pricePerKm ?? 0)} đ',
                                  style: const TextStyle(
                                      color: darkText, fontSize: 16)),
                              Text(' ( ${(distance.values.first)} Km )',
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 15)),
                            ],
                          )
                        ],
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        '*Hệ thống sẽ tự động chọn cửa hàng gần nhất cho bạn (${distancePrice.pricePerKm} / km)',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _paymentTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Phương thức thanh toán',
            style: TextStyle(
                color: darkText, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        Row(
          children: [
            Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              value: COD,
              onChanged: (value) {
                setState(() {
                  COD = value!;
                });
              },
            ),
            const SizedBox(
              width: 20,
            ),
            const Text('Thanh toán khi nhận hàng')
          ],
        ),
        Row(
          children: [
            Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              value: !COD,
              onChanged: (value) {
                setState(() {
                  COD = !value!;
                });
              },
            ),
            const SizedBox(
              width: 20,
            ),
            const Text('Thanh toán trực tuyến')
          ],
        )
      ],
    );
  }

  Widget _textFormField(String label, String hint, bool readonly,
      Function()? onTap, TextEditingController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              autofocus: false,
              readOnly: readonly,
              controller: controller,
              onTap: onTap,
              decoration: InputDecoration(
                labelText: label,
                hintText: hint,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: buttonColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: buttonColor,
                    width: 2.0,
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget _rowInfor(String title, String value) {
    return Row(
      children: [
        Container(
          height: 7,
          width: 7,
          decoration: BoxDecoration(
              color: buttonColor, borderRadius: BorderRadius.circular(50)),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          '$title :  ',
          style: const TextStyle(
              color: buttonColor, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        Expanded(
            child: AutoSizeText(
          value,
          maxLines: 2,
          style: const TextStyle(
            fontSize: 18,
          ),
        ))
      ],
    );
  }

  bool COD = true;
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return buttonColor;
  }
}
