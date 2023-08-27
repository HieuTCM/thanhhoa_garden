import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:thanhhoa_garden/blocs/feedback/feedback_bloc.dart';
import 'package:thanhhoa_garden/blocs/feedback/feedback_event.dart';
import 'package:thanhhoa_garden/blocs/feedback/feedback_state.dart';
import 'package:thanhhoa_garden/blocs/order/orderBloc.dart';
import 'package:thanhhoa_garden/blocs/order/orderEvent.dart';
import 'package:thanhhoa_garden/blocs/order/orderState.dart';
import 'package:thanhhoa_garden/components/appBar.dart';
import 'package:thanhhoa_garden/components/feedback/listfeedback_component.dart';
import 'package:thanhhoa_garden/components/order/orderDetail_component.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/feedback/feedback.dart';
import 'package:thanhhoa_garden/models/order/order.dart';

class ListFeedbackScreen extends StatefulWidget {
  const ListFeedbackScreen({super.key});

  @override
  State<ListFeedbackScreen> createState() => _ListFeedbackScreenState();
}

class _ListFeedbackScreenState extends State<ListFeedbackScreen> {
  // final _scrollControllerFeedback = ScrollController();
  final _scrollControllerNotFeedback = ScrollController();

  int indexStack = 0;
  bool isFeedback = false;
  bool isSelected = false;

  List<OrderDetail> listOrderFeedback = [];
  List<FeedbackModel> listFeedback = [];

  late OrderBloc OrderBlocFeedback;
  late FeedbackBloc feedbackBloc;

  late Stream<OrderState> OrderFeedbackStream;
  late Stream<FeedbackState> feedbackStream;

  int pageNoFeedback = 0;
  int pageNoNotFeedback = 0;

  int PageSize = 100;

  @override
  void initState() {
    OrderBlocFeedback = Provider.of<OrderBloc>(context, listen: false);
    feedbackBloc = Provider.of<FeedbackBloc>(context, listen: false);
    OrderFeedbackStream = OrderBlocFeedback.authStateStream;
    feedbackStream = feedbackBloc.feedbackStateStream;
    _getOrder(0, PageSize, 'ID', false, 0);
    _getFeedback(0, PageSize, 'ID', false);
    // _getOrder(0, PageSize, 'ID', false, 1);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    OrderBlocFeedback.dispose();
    feedbackBloc.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  // _getMorePlant() async {
  //   if (_scrollController.position.pixels ==
  //       _scrollController.position.maxScrollExtent) {
  //     int totalPage = listPlant[0].totalPage.round() - 1;
  //     if (pageNo >= totalPage) {
  //       // setState(() {
  //       //   isLoading = false;
  //       // });
  //       Fluttertoast.showToast(
  //           msg: "Hết trang",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: buttonColor,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //     } else {
  //       Fluttertoast.showToast(
  //           msg: "Đang tải thêm cây ...",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: buttonColor,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //       pageNo++;
  //       int nextPage = pageNo;
  //       await _searchPlant(
  //           nextPage, PageSize, 'ID', true, null, cateID, null, null);
  //     }
  //   }
  // }

  _getOrder(int pageNo, int pageSize, String sortBy, bool sortAsc, int index) {
    switch (index) {
      case 0:
        OrderBlocFeedback.send(GetAllOrderDetailEvent(
            pageNo: pageNo,
            pageSize: pageSize,
            sortBy: sortBy,
            sortAsc: sortAsc,
            isFeedback: false,
            listOrderDetial: listOrderFeedback));
        break;

      case 1:
        OrderBlocFeedback.send(GetAllOrderDetailEvent(
            pageNo: pageNo,
            pageSize: pageSize,
            sortBy: sortBy,
            sortAsc: sortAsc,
            isFeedback: true,
            listOrderDetial: listOrderFeedback));
        break;
    }
  }

  _getFeedback(int pageNo, int pageSize, String sortBy, bool sortAsc) {
    feedbackBloc.send(GetAllFeedbackEvent(
      pageNo: pageNo,
      pageSize: pageSize,
      sortBy: sortBy,
      sortAsc: sortAsc,
      listFeedback: [],
    ));
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
      body: Column(
        children: [
          const SizedBox(
            height: 35,
          ),
          AppBarWiget(
            title: 'Đánh giá của bạn',
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                GestureDetector(
                  onTap: () {
                    if (indexStack == 1) {
                      setState(() {
                        indexStack = 0;
                        checkSelect(0);
                        listOrderFeedback.clear();
                        _getOrder(0, PageSize, 'ID', false, 0);
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
                      'Chưa đánh giá',
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
                        listOrderFeedback.clear();
                        _getFeedback(0, PageSize, 'ID', false);
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
                    child: Text('Đã đánh giá',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: checkTextColor(!isSelected))),
                  ),
                ),
              ])),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 10,
            decoration: const BoxDecoration(color: divince),
          ),
          IndexedStack(
            index: indexStack,
            alignment: Alignment.topCenter,
            children: [
              SingleChildScrollView(
                child: Container(
                    height: size.height - 185,
                    child: _ListOrderDetail(OrderFeedbackStream, 0)),
              ),
              SingleChildScrollView(
                child: Container(
                  height: size.height - 185,
                  child: _ListFeedback(OrderFeedbackStream, 1),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _ListOrderDetail(Stream<OrderState> stream, int index) {
    return StreamBuilder<OrderState>(
      stream: stream,
      initialData: OrderInitial(),
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state is OrderLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ListOrderDetailSuccess) {
          listOrderFeedback = [...state.listOrderDetail!];
          return listOrderFeedback.isEmpty
              ? const Center(
                  child: Text('Không tìm thấy đáng giá'),
                )
              : ListFeedbackComponent(
                  scrollController: _scrollControllerNotFeedback,
                  listDetail: (indexStack == 1) ? [] : listOrderFeedback,
                );
        } else if (state is OrderFailure) {
          return Text(state.errorMessage);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _ListFeedback(Stream<OrderState> stream, int index) {
    return StreamBuilder<FeedbackState>(
      stream: feedbackStream,
      initialData: FeedbackInitial(),
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state is FeedbackLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ListFeedbackSuccess) {
          listFeedback = [...state.listFeedback!];
          return listFeedback.isEmpty
              ? const Center(
                  child: Text('Không tìm thấy đáng giá'),
                )
              : ListFeebback(
                  listData: (indexStack == 0) ? [] : state.listFeedback!,
                  wherecall: 'OrderFeedback',
                );
        } else if (state is FeedbackFailure) {
          return Text(state.errorMessage);
        } else {
          return Container();
        }
      },
    );
  }
}
