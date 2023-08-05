import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thanhhoa_garden/blocs/order/orderBloc.dart';
import 'package:thanhhoa_garden/blocs/order/orderEvent.dart';
import 'package:thanhhoa_garden/blocs/order/orderState.dart';
import 'package:thanhhoa_garden/components/appBar.dart';
import 'package:thanhhoa_garden/components/button.dart';
import 'package:thanhhoa_garden/components/sideBar.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/order/order.dart';
import 'package:thanhhoa_garden/providers/order/order_provider.dart';
import 'package:thanhhoa_garden/screens/feedback/listFeedbackScreen.dart';
import 'package:thanhhoa_garden/screens/order/orderDetail.dart';

class OrderHistoryScreen extends StatefulWidget {
  final Function callback;
  OrderHistoryScreen({super.key, required this.callback});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  var f = NumberFormat("###,###,###", "en_US");
  var selectedTab = 0;
  bool isLoadingOrder = false;

  int pageNo = 0;
  int PageSize = 10;
  OrderProvider orderProvider = OrderProvider();
  bool isLoading = true;
  String status = 'ALL';
  final _scrollController = ScrollController();

  late OrderBloc orderBloc;
  late Stream<OrderState> orderStream;

  List<OrderObject> listOrder = [];

  getEnum() {
    orderProvider.getOrderStatus().then((value) {
      setState(() {
        enumStatus = orderProvider.enumStatus!;
        isLoading = false;
      });
    });
  }

  List<String> enumStatus = [];
  @override
  void initState() {
    getEnum();
    orderBloc = Provider.of<OrderBloc>(context, listen: false);
    orderStream = orderBloc.authStateStream;
    _getOrder(0, PageSize, 'CREATEDDATE', false);
    _scrollController.addListener(() {
      _getMoreOrder();
    });
    // TODO: implement initState
    super.initState();
  }

  _getOrder(
    int pageNo,
    int pageSize,
    String sortBy,
    bool sortAsc,
  ) {
    orderBloc.send(GetAllOrderEvent(
        pageNo: pageNo,
        pageSize: pageSize,
        sortBy: sortBy,
        sortAsc: sortAsc,
        listOrder: listOrder));
  }

  _getMoreOrder() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      int totalPage = listOrder[0].totalPage.round() - 1;
      if (pageNo >= totalPage) {
        // setState(() {
        //   isLoading = false;
        // });
        Fluttertoast.showToast(
            msg: "Hết trang",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: buttonColor,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Đang tải thêm đơn hàng ...",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: buttonColor,
            textColor: Colors.white,
            fontSize: 16.0);
        pageNo++;
        int nextPage = pageNo;
        await _searchOrder(nextPage, PageSize, 'CREATEDDATE', false, status);
      }
    }
  }

  _searchOrder(
    int pageNo,
    int pageSize,
    String sortBy,
    bool sortAsc,
    String? status,
  ) {
    orderBloc.send(GetAllOrderEvent(
      listOrder: listOrder,
      pageNo: pageNo,
      pageSize: pageSize,
      sortBy: sortBy,
      sortAsc: sortAsc,
      status: status == 'ALL' ? null : status,
    ));
  }

  @override
  void dispose() {
    orderBloc.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: SideBar(),
      backgroundColor: background,
      body: Container(
        height: size.height,
        child: Column(children: [
          const SizedBox(
            height: 35,
          ),
          AppBarWiget(title: 'Đơn Hàng Của Bạn', tail: _tailButton()),

          const SizedBox(
            height: 20,
          ),
          //Status list
          (isLoading)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  height: 50,
                  width: size.width,
                  child: _listStatus(),
                ),
          Container(
            height: 10,
            decoration: const BoxDecoration(color: divince),
          ),
          Expanded(child: _listOrder())
          //Order List
        ]),
      ),
    );
  }

  Widget _statusTab(List<String> enumStatus) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTab = index;
                status = enumStatus[index];
                listOrder.clear();
                pageNo = 0;
              });
              _searchOrder(0, PageSize, 'CREATEDDATE', false, status);
            },
            child: Container(
              alignment: Alignment.center,
              width: 100,
              height: 30,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: (selectedTab == index) ? buttonColor : barColor,
                  borderRadius: BorderRadius.circular(50)),
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: AutoSizeText(convertStatusOrder(enumStatus[index]),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: (selectedTab == index) ? lightText : HintIcon)),
            ),
          );
        },
        itemCount: enumStatus.length);
  }

  Widget _listStatus() {
    return _statusTab(enumStatus);
  }

  Widget _listOrder() {
    return StreamBuilder<OrderState>(
      stream: orderStream,
      initialData: OrderInitial(),
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state is OrderLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ListOrderSuccess) {
          listOrder = [...state.listOrder!];
          return listOrder.isEmpty
              ? const Center(
                  child: Text('Không tìm thấy đơn hàng'),
                )
              : ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const ScrollPhysics(),
                  itemCount: listOrder.length,
                  itemBuilder: (context, index) {
                    return _orderTab(listOrder[index]);
                  },
                );
        } else if (state is OrderFailure) {
          return const Center(
            child: Text('Không tìm thấy đơn hàng'),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _orderTab(OrderObject order) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetailScreen(order: order),
            ));
      },
      child: Container(
        constraints: const BoxConstraints(minHeight: 160),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: tabBackground, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(children: [
              Container(
                  padding: EdgeInsets.zero,
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            NetworkImage(order.showPlantModel!.image ?? NoIMG)),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 210,
                        height: 25,
                        child: Row(
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                order.showPlantModel!.plantName ?? '',
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        convertStatusOrder(order.progressStatus!),
                        style: const TextStyle(color: priceColor, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ]),
              ),
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: 25,
                        child: Row(
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                convertDate(order),
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AutoSizeText(
                              'x ${order.showPlantModel!.quantity}',
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AutoSizeText(
                              '${f.format(order.showPlantModel!.plantPrice).toString()} đ',
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ]),
            const Divider(
              color: buttonColor,
              height: 20,
              thickness: 2,
            ),
            Row(
              children: [
                Text('${order.numOfPlant} sản phẩm ',
                    style: const TextStyle(
                      color: darkText,
                      fontSize: 16,
                    )),
                Spacer(),
                Text('${f.format(order.total)} đ',
                    style: const TextStyle(
                        color: priceColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500))
              ],
            ),
            const Divider(
              color: buttonColor,
              height: 20,
              thickness: 2,
            ),
            _bottomRow(order.progressStatus!, order)
          ],
        ),
      ),
    );
  }

  Widget _bottomRow(String status, OrderObject order) {
    return (status == 'RECEIVED')
        ? Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 160,
                child: const AutoSizeText(NotiOrder2),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ListFeedbackScreen(),
                  ));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 40,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(50)),
                  margin:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: const AutoSizeText('Đánh giá',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w800, color: lightText)),
                ),
              )
            ],
          )
        : Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 160,
                child: const AutoSizeText(NotiOrder1),
              ),
              CancelOrderButton(
                orderid: order.id,
                phone: order.showStoreModel!.phone,
                totalPrice: '${f.format(order.total)} đ',
                status: status,
              )
            ],
          );
  }

  Widget _tailButton() {
    return GestureDetector(
      onTap: () {
        widget.callback();
      },
      child: Stack(
        children: [
          Center(
              child: SizedBox(
            height: 40,
            width: 35,
            child: FaIcon(
              FontAwesomeIcons.fileContract,
              color: Colors.cyan.shade700,
              size: 30,
            ),
          )),
          const Positioned(
              bottom: -10,
              right: -5,
              child: Icon(
                Icons.compare_arrows_sharp,
                color: buttonColor,
                size: 40,
              ))
        ],
      ),
    );
  }
}
