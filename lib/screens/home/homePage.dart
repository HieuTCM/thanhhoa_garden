// ignore_for_file: must_be_immutable, file_names, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thanhhoa_garden/blocs/bonsai/bonsai_bloc.dart';
import 'package:thanhhoa_garden/blocs/bonsai/bonsai_event.dart';
import 'package:thanhhoa_garden/blocs/bonsai/bonsai_state.dart';
import 'package:thanhhoa_garden/blocs/cart/cart_bloc.dart';
import 'package:thanhhoa_garden/blocs/cart/cart_event.dart';
import 'package:thanhhoa_garden/blocs/cart/cart_state.dart';
import 'package:thanhhoa_garden/blocs/notification/notiBloc.dart';
import 'package:thanhhoa_garden/blocs/notification/notiEvent.dart';
import 'package:thanhhoa_garden/blocs/notification/notiState.dart';

import 'package:thanhhoa_garden/blocs/service/service_bloc.dart';
import 'package:thanhhoa_garden/blocs/service/service_event.dart';
import 'package:thanhhoa_garden/blocs/service/service_state.dart';
import 'package:thanhhoa_garden/components/bonsai/listBonsai_Component.dart';
import 'package:thanhhoa_garden/components/cart/cartButton.dart';
import 'package:thanhhoa_garden/components/sideBar.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/bonsai/bonsai.dart';
import 'package:thanhhoa_garden/models/service/service.dart';
import 'package:thanhhoa_garden/providers/notification/notification_Provider.dart';
import 'package:thanhhoa_garden/screens/bonsai/searchScreen.dart';
import 'package:thanhhoa_garden/screens/service/serviceScreen.dart';
import 'package:thanhhoa_garden/models/authentication/user.dart' as UserObj;
import 'package:thanhhoa_garden/utils/helper/shared_prefs.dart';

class HomePage extends StatefulWidget {
  // User? user;
  HomePage({
    super.key,
    //  required this.user
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserObj.User user = getCuctomerIDFromSharedPrefs();

  late ServiceBloc serviceBloc;
  late BonsaiBloc bonsaiBloc;
  late NotificationBloc notificationBloc;
  late CartBloc cartBloc;

  StreamSubscription<ServiceState>? _serviceStateSubscription;
  StreamSubscription<BonsaiState>? _bonsaiStateSubscription;
  StreamSubscription<CartState>? _cartStateSubscription;

  late Stream<CartState> cartStream;
  late Stream<BonsaiState> bonsaiStream;
  late Stream<ServiceState> serviceStream;
  late Stream<NotificationState> notificationStream;

  int? Cartcount = 0;

  List<Bonsai> listPlant = [];
  GlobalKey<ScaffoldState> drawkey = GlobalKey();
  @override
  void initState() {
    super.initState();

    serviceBloc = Provider.of<ServiceBloc>(context, listen: false);
    bonsaiBloc = Provider.of<BonsaiBloc>(context, listen: false);
    cartBloc = Provider.of<CartBloc>(context, listen: false);
    notificationBloc = Provider.of<NotificationBloc>(context, listen: false);

    bonsaiStream = bonsaiBloc.authStateStream;
    serviceStream = serviceBloc.authStateStream;
    cartStream = cartBloc.cartStateStream;

    bonsaiBloc.send(GetAllBonsaiEvent(
        pageNo: 0,
        pageSize: 3,
        sortBy: 'ID',
        sortAsc: true,
        listBonsai: listPlant));
    serviceBloc.send(GetAllServiceEvent());
    cartBloc.send(GetCart());
    notificationBloc.send(GetAllNotificationEvent());
    // _bonsaiStateSubscription = bonsaiStream.listen(
    //   (event) {},
    // );
    // _serviceStateSubscription = serviceStream.listen((state) {});
    // _cartStateSubscription = cartStream.listen((event) {});
  }

  @override
  void didChangeDependencies() {
    _serviceStateSubscription?.cancel();
    _bonsaiStateSubscription?.cancel();
    // _cartStateSubscription?.cancel();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    serviceBloc.dispose();
    // bonsaiBloc.dispose();
    // _cartStateSubscription?.cancel();
    _serviceStateSubscription?.cancel();
    _bonsaiStateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      key: drawkey,
      drawer: SideBar(),
      floatingActionButton: Builder(builder: (context) {
        return const CartButton();
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: background,
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(children: [
            //Banner
            Container(
              height: size.height / 2,
              decoration: const BoxDecoration(color: Colors.transparent),
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(children: [
                Container(
                  width: (size.width / 5) * 3,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        )
                      ],
                      image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/image1.jpg')),
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(20))),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: (size.width / 5) * 2,
                        height: ((size.height / 2) / 5) * 2,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/Logo.png')),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20))),
                      ),
                      Row(
                        children: [
                          Container(
                            width: ((size.width / 5) * 2) / 2,
                            height: ((size.width / 5) * 2) / 2 + 20,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/image2.jpg')),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20))),
                          ),
                          Container(
                            width: ((size.width / 5) * 2) / 2,
                            height: ((size.width / 5) * 2) / 2 + 20,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/image3.jpg')),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20))),
                          ),
                        ],
                      )
                    ]),
              ]),
            ),
            //Services list
            SizedBox(
                height: 200,
                child: Column(
                  children: [
                    const Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Text('Các Dịch Vụ',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: buttonColor)),
                      ],
                    ),
                    StreamBuilder<ServiceState>(
                      stream: serviceStream,
                      initialData: ServiceInitial(),
                      builder: (context, snapshot) {
                        final state = snapshot.data;
                        if (state is ServiceLoading) {
                          return const Expanded(
                              child:
                                  Center(child: CircularProgressIndicator()));
                        } else if (state is ListServiceSuccess) {
                          return Expanded(
                              child: state.listService == null
                                  ? Container()
                                  : _listService(state.listService));
                        } else if (state is ServiceFailure) {
                          return Text(state.errorMessage);
                        } else {
                          return const Text('Load faild');
                        }
                      },
                    ),
                  ],
                )),
            const SizedBox(
              height: 15,
            ),
            //Bonsai list
            SizedBox(
              height: 580,
              width: size.width,
              // decoration: const BoxDecoration(color: Colors.deepOrange),
              child: Stack(children: [
                Positioned(
                  top: 100,
                  child: Container(
                    height: 500,
                    width: size.width - 100,
                    decoration: const BoxDecoration(color: Colors.white),
                  ),
                ),
                Positioned(
                  bottom: 46,
                  left: 140,
                  child: Container(
                    height: 220,
                    width: size.width - 140,
                    decoration: const BoxDecoration(color: buttonColor),
                  ),
                ),
                //Derection search View
                Positioned(
                    bottom: 0,
                    left: 15,
                    child: SizedBox(
                      width: size.width,
                      child: Row(
                        children: [
                          const Spacer(),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SearchScreen(),
                                ));
                              },
                              child: const Row(
                                children: [
                                  Text('Xem thêm',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: buttonColor)),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.arrowRight,
                                    size: 35,
                                    color: buttonColor,
                                  ),
                                ],
                              )),
                          const SizedBox(
                            width: 25,
                          ),
                        ],
                      ),
                    )),
                // const SizedBox(
                //   height: 510,
                // ),

                Column(
                  children: [
                    const Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text('Cây Cảnh',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: buttonColor)),
                      ],
                    ),
                    SizedBox(
                      // height: 510,
                      child: StreamBuilder<BonsaiState>(
                        stream: bonsaiStream,
                        initialData: BonsaiInitial(),
                        builder: (context, snapshot) {
                          final state = snapshot.data;
                          if (state is BonsaiLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is ListBonsaiSuccess) {
                            return state.listBonsai == null
                                ? Container()
                                : ListBonsai(
                                    listBonsai: state.listBonsai,
                                    // cartStateSubscription:
                                    //     _cartStateSubscription,
                                    // cartStream: cartStream,
                                  );
                          } else if (state is BonsaiFailure) {
                            return Text(state.errorMessage);
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ]),
            ),

            const SizedBox(
              height: 10,
            ),
          ]),
        ),
        Stack(
          children: [
            Positioned(
                top: 30,
                left: 10,
                child: IconButton(
                  icon: const FaIcon(FontAwesomeIcons.gripLines,
                      color: buttonColor, size: 40),
                  onPressed: () {
                    drawkey.currentState!.openDrawer();
                  },
                )),
            Positioned(
              top: 35,
              left: 35,
              child: Consumer<NotificationProvider>(
                builder: (context, value, _) {
                  return (value.countNotRead != 0)
                      ? ClipOval(
                          child: Container(
                              color: Colors.red,
                              width: 20,
                              height: 20,
                              child: Center(
                                  child: Text(
                                value.countNotRead.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ))),
                        )
                      : const SizedBox();
                },
              ),
            )
          ],
        ),
      ]),
    );
  }

  Widget _listService(List<Service>? listService) {
    // var size = MediaQuery.of(context).size;
    return Container(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listService!.length,
          itemBuilder: (context, index) {
            return Container(
                width: 130,
                height: 145,
                alignment: Alignment.center,
                child: _serviceTab(listService[index],
                    icons[(index > 2) ? index % 2 - 1 : index]));
          },
        ));
  }

  Widget _serviceTab(Service? service, IconData icon) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ServiceDetail(service: service),
        ));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: Colors.transparent),
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 80,
                height: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: darkText),
                    borderRadius: BorderRadius.circular(50),
                    color: barColor),
                child: FaIcon(icon, size: 35, color: buttonColor)),
            const SizedBox(
              height: 20,
            ),
            AutoSizeText(
              service!.name,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600),
              maxFontSize: 30,
            ),
          ],
        )),
      ),
    );
  }

  List<IconData> icons = [
    FontAwesomeIcons.leaf,
    FontAwesomeIcons.plantWilt,
    FontAwesomeIcons.sunPlantWilt,
  ];
}
