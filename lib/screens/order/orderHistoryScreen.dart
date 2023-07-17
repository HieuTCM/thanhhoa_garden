import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:thanhhoa_garden/blocs/order/orderBloc.dart';
import 'package:thanhhoa_garden/blocs/order/orderEvent.dart';
import 'package:thanhhoa_garden/blocs/order/orderState.dart';
import 'package:thanhhoa_garden/components/appBar.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/order/order.dart';
import 'package:thanhhoa_garden/providers/order/order_provider.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  var selectedTab = 0;
  bool isLoadingOrder = false;

  int pageNo = 0;
  int PageSize = 10;
  OrderProvider orderProvider = OrderProvider();
  bool isLoading = true;
  String status = '';
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
    _getOrder(0, PageSize, 'ID', true);
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
            msg: "Đang tải thêm cây ...",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: buttonColor,
            textColor: Colors.white,
            fontSize: 16.0);
        pageNo++;
        int nextPage = pageNo;
        await _searchOrder(nextPage, PageSize, 'ID', true, null);
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
      status: status,
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
      backgroundColor: background,
      body: Container(
        height: size.height,
        child: Column(children: [
          SizedBox(
            height: 35,
          ),
          AppBarWiget(
            title: 'Lịch Sử Của Bạn',
          ),
          Center(
            child: Container(
              height: 1,
              width: 250,
              decoration: const BoxDecoration(color: buttonColor),
            ),
          ),
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
                  child: _cateList(),
                ),
          Container(
            height: 10,
            decoration: const BoxDecoration(color: divince),
          ),
          Expanded(child: Container())
          //Order List
        ]),
      ),
    );
  }

  Widget _listStatus(List<String> enumStatus) {
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
              _searchOrder(0, PageSize, 'ID', true, status);
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
              child: AutoSizeText(convertStatus(enumStatus[index]),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: (selectedTab == index) ? lightText : HintIcon)),
            ),
          );
        },
        itemCount: enumStatus.length);
  }

  Widget _cateList() {
    return _listStatus(enumStatus);
  }
}
