import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:thanhhoa_garden/components/appBar.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/store/store.dart';
import 'package:thanhhoa_garden/providers/store/store_provider.dart';
import 'package:geocoder2/geocoder2.dart';

class MapScreen extends StatefulWidget {
  final Function callback;
  MapScreen({super.key, required this.callback});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  TextEditingController _searchController = TextEditingController();

  StoreProvider _storeProvider = StoreProvider();

  List<Marker> _makers = [];

  Marker? selectMarker;

  // double _distance = 0.0;
  double? lat;
  double? long;

  bool isLoading = false;
  List<Store> listStore = [];

  LatLng origin = LatLng(0, 0);

  getListStore() async {
    isLoading = true;
    await _storeProvider.getStore().then((value) {
      if (value) {
        getUserCurrentLocation().then((value) {
          setState(() {
            origin = LatLng(value.latitude, value.longitude);
            listStore = _storeProvider.list!;
            for (var store in listStore) {
              getCoordinatesFromAddress(store.address, store.storeName);
            }

            lat = value.latitude;
            long = value.longitude;
            isLoading = false;
          });
        });
      }
    });
  }

  getCoordinatesFromAddress(String address, String title) async {
    GeoData data = await Geocoder2.getDataFromAddress(
        address: address, googleMapApiKey: GG_API_Key, language: 'vi');
    if (title == 'search') {
      setState(() {
        selectMarker = Marker(
          markerId: MarkerId(data.address),
          infoWindow: const InfoWindow(title: 'Vị trí của bạn'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: LatLng(data.latitude, data.longitude),
        );
      });
    } else {
      var _storeMarker = Marker(
        markerId: MarkerId(data.address),
        infoWindow: InfoWindow(title: title),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: LatLng(data.latitude, data.longitude),
      );
      setState(() {
        _makers.add(_storeMarker);
      });
    }
  }

  Future<String> getAddressFromCoordinates(LatLng pos) async {
    String result = "";
    GeoData data = await Geocoder2.getDataFromCoordinates(
        latitude: pos.latitude,
        longitude: pos.longitude,
        googleMapApiKey: GG_API_Key,
        language: 'vi');

    result = data.address;
    setState(() {
      selectMarker = Marker(
        markerId: const MarkerId('Bạn'),
        infoWindow: const InfoWindow(title: 'Vị trí của bạn'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(data.latitude, data.longitude),
      );
    });

    return result;
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    getListStore();
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 35,
          ),
          AppBarWiget(
            title: 'Chọn vị trí của bạn',
          ),
          (isLoading)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  height: size.height - 85,
                  child: Stack(children: [
                    _map(),
                    Positioned(top: 5, left: 5, child: _searchForm()),
                  ]),
                )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () async {
          getUserCurrentLocation().then((value) async {
            CameraPosition cameraPosition = CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: 15,
            );
            _mapController.animateCamera(
              CameraUpdate.newCameraPosition(cameraPosition),
            );
            _addMarker(LatLng(value.latitude, value.longitude));
          });
        },
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  Widget _map() {
    return GoogleMap(
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      initialCameraPosition:
          CameraPosition(target: (LatLng(lat!, long!)), zoom: 11.5),
      onMapCreated: (controller) => _mapController = controller,
      markers: {if (selectMarker != null) selectMarker!, ..._makers.toSet()},
      myLocationEnabled: true,
      onTap: _addMarker,
    );
  }

  Widget _searchForm() {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25)),
          child: TextFormField(
            onChanged: (value) {
              getCoordinatesFromAddress(value, 'search');
            },
            controller: _searchController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  _searchController.clear();
                  setState(() {
                    origin = LatLng(0, 0);
                    selectMarker = Marker(
                      markerId: const MarkerId('Bạn'),
                      infoWindow: const InfoWindow(title: 'Vị trí của bạn'),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueBlue),
                      position: origin,
                    );
                  });
                },
                icon: const Icon(Icons.close),
              ),
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
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () {
            if (_searchController.text.isEmpty) {
              Fluttertoast.showToast(
                  msg: "Bạn chưa chọn địa chỉ",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              widget.callback(_searchController.text, origin);
              Navigator.pop(context);
            }
          },
          child: Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(color: buttonColor),
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(12)),
              child: const Text(
                'Lưu',
                style: TextStyle(
                    color: lightText,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
        )
      ],
    );
  }

  void _addMarker(LatLng pos) async {
    getAddressFromCoordinates(pos).then((value) {
      setState(() {
        origin = pos;
        _searchController.text = value;
      });
    });
  }
}
