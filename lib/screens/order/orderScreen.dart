import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:thanhhoa_garden/components/appBar.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/cart/cart.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:thanhhoa_garden/models/store/store.dart';
import 'package:thanhhoa_garden/providers/authentication/authantication_provider.dart';
import 'package:thanhhoa_garden/providers/store/store_provider.dart';
import 'package:thanhhoa_garden/screens/order/mapScreen.dart';
import 'package:thanhhoa_garden/models/authentication/user.dart' as UserObj;

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

  MapController _mapController = MapController();
  List<LatLng> _routePoints = [];
  double _distance = 0.0;
  double lat = 10.81471;
  double long = 106.6773817;
  var oneDecimal = const Duration(milliseconds: 100);

  AuthenticationProvider _authenticationProvider = AuthenticationProvider();
  StoreProvider _storeProvider = StoreProvider();

  List<Store> listStore = [];
  UserObj.User? user;

  Map<String, dynamic> listDistance = {};
  Map<String, dynamic> distance = {};

  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    getListStore();

    super.initState();
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
        getListDistance().then((value) {
          distance = value;
          setState(() {
            isLoading = false;
          });
        });
      }
    });
  }

  setAdress(String address) {
    setState(() {
      _addressController.text = address;
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

  Future<Map<String, int>> getListDistance() async {
    Map<String, int> Distance = {};
    for (var store in listStore) {
      await getDistance(user!.address, store.address).then((value) {
        listDistance[store.id] = value;
      });
    }
    var thevalue = listDistance.values.first;
    var thekey;
    listDistance.forEach((k, v) {
      if (v < thevalue || v == 0) {
        thevalue = v;
        thekey = k;
      }
    });
    Distance[thekey] = thevalue;
    return Distance;
  }

  Future<int> getDistance(String origin, String destination) async {
    int distance = 0;
    try {
      final res = await http.post(Uri.parse(
          'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$GG_API_Key'));
      if (res.statusCode == 200) {
        var jsondata = json.decode(res.body);
        if (jsondata['error_message'] == null) {
          distance = jsondata['routes'][0]['legs'][0]['distance']['value'] ?? 0;
        }
      }
    } on HttpException catch (e) {}
    return distance;
  }

  @override
  void dispose() {
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
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _shipTab(widget.listPlant),
              Container(
                height: 10,
                decoration: const BoxDecoration(color: divince),
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
                  '${f.format((widget.listPlant.fold(0.0, (sum, item) => sum + item.plantPrice! * item.quantity!)) + (widget.listPlant.fold(0.0, (sum, item) => sum + item.shipPrice! * item.quantity!)) + ((distance.values.first / 1000) * 7000))} đ',
                  style: const TextStyle(
                      color: priceColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
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
        Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: buttonColor),
            child: const Text(
              'Kiểm tra phí vận chuyển',
              style: TextStyle(
                  color: lightText, fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const Divider(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text('Phí vận chuyễn',
                style: TextStyle(
                    color: darkText,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
          ],
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
                              style: TextStyle(color: darkText, fontSize: 16)),
                          Text('Phí giao hàng: ',
                              style: TextStyle(color: darkText, fontSize: 16)),
                        ]),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            '${f.format(widget.listPlant.fold(0.0, (sum, item) => sum + item.shipPrice! * item.quantity!))} đ',
                            style:
                                const TextStyle(color: darkText, fontSize: 16)),
                        Text(
                            '${f.format((distance.values.first / 1000) * 7000)} đ',
                            style:
                                const TextStyle(color: darkText, fontSize: 16)),
                        Text(' ( ${(distance.values.first / 1000)} Km )',
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
            children: const [
              Text(
                  '*Hệ thống sẽ tự động chọn cửa hàng gần nhất cho bạn (7000đ / km)',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  )),
            ],
          ),
        ),
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
}
