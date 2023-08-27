import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:thanhhoa_garden/components/appBar.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/main.dart';
import 'package:thanhhoa_garden/models/authentication/user.dart';
import 'package:thanhhoa_garden/models/contract/contact.dart';
import 'package:thanhhoa_garden/models/store/store.dart';
import 'package:thanhhoa_garden/providers/authentication/authantication_provider.dart';
import 'package:thanhhoa_garden/providers/contact/contact_provider.dart';
import 'package:thanhhoa_garden/providers/store/store_provider.dart';
import 'package:thanhhoa_garden/screens/contract/serviceDetailContactSreen.dart';
import 'package:thanhhoa_garden/screens/home/historyScreen.dart';
import 'package:http/http.dart' as http;
import 'package:thanhhoa_garden/utils/helper/shared_prefs.dart';
import 'package:flutter/gestures.dart';

class ConfirmContactScreen extends StatefulWidget {
  final Function callback;
  final List<ContactDetail> listContact;
  final List<int> listIndex;
  final int totalService;
  final double totalPriceService;
  ConfirmContactScreen(
      {super.key,
      required this.listContact,
      required this.callback,
      required this.totalPriceService,
      required this.listIndex,
      required this.totalService});

  @override
  State<ConfirmContactScreen> createState() => _ConfirmContactScreenState();
}

class _ConfirmContactScreenState extends State<ConfirmContactScreen> {
  var f = NumberFormat("###,###,###", "en_US");
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  StoreProvider _storeProvider = StoreProvider();
  AuthenticationProvider _authenticationProvider = AuthenticationProvider();

  LatLng origin = LatLng(0, 0);
  // double _distance = 0.0;

  List<Store> listStore = [];

  Map<String, double> listDistance = {};
  Map<String, dynamic> distance = {};

  User? user;
  bool isLoading = false;

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
              setState(() {
                distance = value;
                isLoading = false;
              });
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

  Future<Map<String, dynamic>> getDistanceNearBy() async {
    Map<String, dynamic> Distance = {};
    for (var store in listStore) {
      await getCoordinatesFromAddress(store.address).then((value) async {
        await getDistance(origin, value).then((value) {
          listDistance[store.id] = value + .0;
        });
      });
    }
    double thevalue = listDistance.values.first;
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

        distance = jsondata['routes'][0]['distance'] ?? 0.0;
      }
    } on HttpException catch (e) {
      print(e.message);
    }
    return distance + .0;
  }

  @override
  void initState() {
    getListStore();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
            child: Column(children: [
              const SizedBox(
                height: 35,
              ),
              AppBarWiget(
                title: 'Thông tin hợp đồng',
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 10,
                decoration: const BoxDecoration(color: divince),
              ),
              const SizedBox(
                height: 10,
              ),
              _shipTab(),
              Container(
                height: 10,
                decoration: const BoxDecoration(color: divince),
              ),
              Container(
                // height: size.height * 0.7,
                child: _listService(),
              ),
              Container(
                height: 65,
              ),
            ]),
          ),
          Positioned(top: size.height - 95, child: _floatingBarService()),
        ],
      ),
    );
  }

  Widget _shipTab() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Thông tin khách hàng',
              style: TextStyle(
                  color: darkText, fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          //Full name
          _textFormField("Tên khách hàng", 'Nhập khách hàng', false, null,
              _nameController),
          //Email
          _textFormField("Email khách hàng", 'Nhập Email khách hàng', false,
              null, _emailController),
          //Phone
          _textFormField("Số điện thoại khách hàng", 'Nhập số điện thoại',
              false, null, _phoneController),
          //address
          _textFormField("Địa chỉ giao hàng", 'Bấm vào đây để chọn địa chỉ !!!',
              false, null, _addressController),
        ]);
  }

  Widget _textFormField(String label, String hint, bool readonly,
      Function()? onTap, TextEditingController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
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

  Widget _listService() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => Container(
        child: _serviceTab(widget.listContact[index], index + 1),
      ),
      itemCount: widget.listContact.length,
    );
  }

  Widget _serviceTab(ContactDetail detail, int index) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ServiceDetailContact(detail: detail),
        ));
      },
      child: Column(children: [
        SizedBox(
          width: size.width,
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(50)),
              ),
              const SizedBox(
                width: 10,
              ),
              AutoSizeText(
                'Thông tin dịch vụ $index: ',
                style: const TextStyle(
                    color: darkText, fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        _inforRow('Tên dịch vụ', detail.serviceModel!.name),
        (detail.timeWorking != "")
            ? _inforRow(
                'Lịch chăm sóc',
                detail.timeWorking
                    .toString()
                    .replaceAll(RegExp(r'[\[*\]]'), ''))
            : const SizedBox(),
        _inforRow('Ngày bắt đầu', formatDateShow(detail.startDate)),
        _inforRow('Ngày kết thức', formatDateShow(detail.endDate)),
        _inforRow(
            'Gói dịch vụ',
            detail.servicePackModel!.range +
                ' ( giảm ' +
                detail.servicePackModel!.percentage.toString() +
                ' % )'),
        _inforRow(
            'Loại dịch vụ',
            detail.serviceTypeModel!.name +
                ' (thêm ' +
                detail.serviceTypeModel!.percentage.toString() +
                ' % )'),
        _inforRow('Đơn giá', f.format(detail.serviceModel!.price)),
        _inforRow('Lưu ý', detail.note),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 10,
          decoration: const BoxDecoration(color: divince),
        ),
        const SizedBox(
          height: 10,
        ),
      ]),
    );
  }

  Widget _inforRow(String title, String value) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: size.width,
          child: Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              Container(
                constraints: BoxConstraints(
                  minWidth: size.width * 0.2,
                ),
                child: AutoSizeText(
                  '$title : ',
                  maxLines: 1,
                  style: const TextStyle(
                      color: darkText,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  minWidth: size.width * 0.5,
                ),
                child: AutoSizeText(
                  value,
                  maxLines: 1,
                  style: const TextStyle(color: darkText, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _floatingBarService() {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10),
      height: 95,
      width: size.width,
      decoration: const BoxDecoration(color: barColor),
      child: Column(
        children: [
          SizedBox(
            width: size.width - 20,
            child: RichText(
              text: TextSpan(
                  style: const TextStyle(color: darkText, fontSize: 14),
                  text: 'Bấm xác nhận điều đó có nghĩa là bạn đồng ý với ',
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => showPolyci(policyContract, context),
                      text: 'điều khoản của chúng tôi',
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Số dịch vụ ${widget.totalService}',
                      style: const TextStyle(
                          color: darkText,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                  Text('${f.format(widget.totalPriceService)} đ',
                      style: const TextStyle(
                          color: priceColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              Spacer(),
              (isLoading)
                  ? const Text('Đang tìm cửa hàng gần bạn nhất...')
                  : GestureDetector(
                      onTap: () async {
                        String title =
                            'Hợp đồng ${widget.listContact[0].serviceModel!.name}';
                        ContactRequest request = ContactRequest(
                            title: title,
                            fullName: _nameController.text,
                            phone: _phoneController.text,
                            address: _addressController.text,
                            email: _emailController.text,
                            storeID: distance.keys.first,
                            detailModelList: widget.listContact);

                        var map = ContactRequest().toJson(request);
                        ContactProvider().createContact(map).then((value) {
                          if (value) {
                            Fluttertoast.showToast(
                                msg: "Tạo hợp đồng thành công",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            List<Map<String, dynamic>> listContactDetail =
                                getListContactDetailFromSharedPrefs();
                            for (var data in widget.listIndex) {
                              listContactDetail.removeAt(data);
                            }
                            Map<String, dynamic> map = Map<String, dynamic>();
                            map['detailModelList'] = listContactDetail;
                            sharedPreferences.setString(
                                'ContactDetail', json.encode(map));
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => HistoryScreen(index: 1),
                            ));
                          } else {
                            Fluttertoast.showToast(
                                msg: "Tạo hợp đồng thất bại",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        width: 130,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: const Text(
                          'Xác nhận',
                          style: TextStyle(
                              color: lightText,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
            ],
          ),
        ],
      ),
    );
  }
}
