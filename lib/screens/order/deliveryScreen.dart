import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:thanhhoa_garden/components/appBar.dart';
import 'package:thanhhoa_garden/components/note.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/order/order.dart';

class DeliveryScreen extends StatefulWidget {
  final OrderObject order;
  DeliveryScreen({super.key, required this.order});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  String getDate(String date) {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
    return date = DateFormat('MM/dd/yyyy hh:mm a').format(parseDate);
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    var order = widget.order;

    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 35,
          ),
          AppBarWiget(
            title: 'Tiến độ đơn hàng',
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
          _columnTimeLine(order.progressStatus, order),
          Container(
            height: 10,
            decoration: const BoxDecoration(color: divince),
          ),
          NoteOrder()
        ]),
      ),
    );
  }

  Widget _timeLineDone(OrderObject order, String date, String title,
      String status, Color? colors) {
    // var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(left: 10),
      alignment: Alignment.center,
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date.substring(11),
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  date.substring(0, 10),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Container(
            height: 70,
            width: 2,
            decoration: const BoxDecoration(color: buttonColor),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 250,
                child: AutoSizeText(
                  status,
                  style: TextStyle(fontSize: 18, color: colors),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _timeLine(OrderObject order, String title, String status) {
    // var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(left: 10),
      alignment: Alignment.center,
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '_ _:_ _',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '_ _/_ _/_ _ _ _',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Container(
            height: 70,
            width: 2,
            decoration: const BoxDecoration(color: buttonColor),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, color: HintIcon),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                status,
                style: const TextStyle(fontSize: 18, color: HintIcon),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _columnTimeLine(String status, OrderObject order) {
    switch (status) {
      case 'WAITING':
        return Column(
          children: [
            //xác nhận
            _timeLineDone(
                order,
                getDate(order.createdDate),
                'Hoàn thành đặt mua đơn hàng',
                convertStatusOrder(order.progressStatus),
                priceColor),
            //đã xác nhận
            _timeLine(order, 'Hoàn thành xác nhận đơn hàng', 'Chờ xác nhận'),
            //đóng gói
            _timeLine(order, 'Hoàn thành đóng gói', 'Chờ đóng gói'),
            //vận chuyễn
            _timeLine(order, 'Đăng vận chuyễn', 'Nhân viên: _ _ _  _ _ _'),
            //hoàn thành
            _timeLine(order, 'Đã nhận', ''),
          ],
        );

      case 'APPROVED':
        return Column(
          children: [
            //xác nhận
            _timeLineDone(order, getDate(order.createdDate),
                'Hoàn thành đặt mua đơn hàng', 'Thành công', buttonColor),
            //đã xác nhận
            _timeLineDone(order, getDate(order.approveDate),
                'Hoàn thành xác nhận đơn hàng', 'Đã xác nhận', buttonColor),
            //đóng gói
            _timeLine(order, 'Hoàn thành đóng gói', 'Chờ đóng gói'),
            //vận chuyễn
            _timeLine(order, 'Đăng vận chuyễn', 'Nhân viên: _ _ _  _ _ _'),
            //hoàn thành
            _timeLine(order, 'Đã nhận', ''),
          ],
        );
      case 'PACKAGING':
        return Column(
          children: [
            //xác nhận
            _timeLineDone(order, getDate(order.createdDate),
                'Hoàn thành đặt mua đơn hàng', 'Thành công', buttonColor),
            //đã xác nhận
            _timeLineDone(order, getDate(order.approveDate),
                'Hoàn thành xác nhận đơn hàng', 'Đã xác nhận', buttonColor),
            //đóng gói
            _timeLineDone(order, getDate(order.packageDate), 'Đang đóng gói',
                'Chờ vận chuyễn', buttonColor),
            //vận chuyễn
            _timeLine(order, 'Đăng vận chuyễn', 'Nhân viên: _ _ _  _ _ _'),
            //hoàn thành
            _timeLine(order, 'Đã nhận', ''),
          ],
        );
      case 'DELIVERING':
        return Column(
          children: [
            //xác nhận
            _timeLineDone(order, getDate(order.createdDate),
                'Hoàn thành đặt mua đơn hàng', 'Thành công', buttonColor),
            //đã xác nhận
            _timeLineDone(order, getDate(order.approveDate),
                'Hoàn thành xác nhận đơn hàng', 'Đã xác nhận', buttonColor),
            //đóng gói
            _timeLineDone(order, getDate(order.packageDate),
                'Hoàn thành đóng gói', 'Đã đóng gói', buttonColor),
            //vận chuyễn
            _timeLineDone(order, getDate(order.packageDate), 'Đang vận chuyển',
                'Nhân Viên: ${order.showStaffModel!.fullName}', buttonColor),
            //hoàn thành
            _timeLine(order, 'Đã nhận', ''),
          ],
        );
      case 'RECEIVED':
        return Column(
          children: [
            //xác nhận
            _timeLineDone(order, getDate(order.createdDate),
                'Hoàn thành đặt mua đơn hàng', 'Thành công', buttonColor),
            //đã xác nhận
            _timeLineDone(order, getDate(order.approveDate),
                'Hoàn thành xác nhận đơn hàng', 'Đã xác nhận', buttonColor),
            //đóng gói
            _timeLineDone(order, getDate(order.packageDate),
                'Hoàn thành đóng gói', 'Chờ vận chuyễn', buttonColor),
            //vận chuyễn
            _timeLineDone(order, getDate(order.deliveryDate), 'Đang vận chuyển',
                'Nhân Viên: ${order.showStaffModel!.fullName}', buttonColor),
            //hoàn thành
            _timeLineDone(order, getDate(order.receivedDate), 'Hoàn thành', '',
                buttonColor),
          ],
        );
      case 'DENIED':
        return Column(
          children: [
            //xác nhận
            _timeLineDone(order, getDate(order.rejectDate),
                'Đơn hàng đã từ chối', 'Lý do: ${order.reason}', priceColor),
            //đã xác nhận
            _timeLine(order, '_ _ _ _ _ _ _ _', '_ _ _ _'),
            //đóng gói
            _timeLine(order, '_ _ _ _ _ _ _ _', '_ _ _ _'),
            //vận chuyễn
            _timeLine(order, '_ _ _ _ _ _ _ _', '_ _ _ _'),
            //hoàn thành
            _timeLine(order, '_ _ _ _ _ _ _ _', '_ _ _ _'),
          ],
        );
      case 'STAFFCANCELED':
        return Column(
          children: [
            //xác nhận
            _timeLineDone(order, getDate(order.rejectDate),
                'Đơn hàng đã từ chối', 'Lý do: ${order.reason}', priceColor),
            //đã xác nhận
            _timeLine(order, '_ _ _ _ _ _ _ _', '_ _ _ _'),
            //đóng gói
            _timeLine(order, '_ _ _ _ _ _ _ _', '_ _ _ _'),
            //vận chuyễn
            _timeLine(order, '_ _ _ _ _ _ _ _', '_ _ _ _'),
            //hoàn thành
            _timeLine(order, '_ _ _ _ _ _ _ _', '_ _ _ _'),
          ],
        );
      case 'CUSTOMERCANCELED':
        return Column(
          children: [
            //xác nhận
            _timeLineDone(order, getDate(order.rejectDate), 'Đơn hàng đã hủy',
                'Lý do: ${order.reason}', priceColor),
            //đã xác nhận
            _timeLine(order, '_ _ _ _ _ _ _ _', '_ _ _ _'),
            //đóng gói
            _timeLine(order, '_ _ _ _ _ _ _ _', '_ _ _ _'),
            //vận chuyễn
            _timeLine(order, '_ _ _ _ _ _ _ _', '_ _ _ _'),
            //hoàn thành
            _timeLine(order, '_ _ _ _ _ _ _ _', '_ _ _ _'),
          ],
        );
      case 'STAFFCANCELED':
        return Column(
          children: [
            //xác nhận
            _timeLineDone(order, getDate(order.rejectDate),
                'Đơn hàng đã từ chối', 'Đặt hàng thất bại', priceColor),
            //đã xác nhận
            _timeLine(order, '_ _ _ _ _ _ _ _', '_ _ _ _'),
            //đóng gói
            _timeLine(order, '_ _ _ _ _ _ _ _', '_ _ _ _'),
            //vận chuyễn
            _timeLine(order, '_ _ _ _ _ _ _ _', '_ _ _ _'),
            //hoàn thành
            _timeLine(order, '_ _ _ _ _ _ _ _', '_ _ _ _'),
          ],
        );
      default:
        return Column(
          children: [
            //xác nhận
            _timeLine(order, '_ _ _ _ _ _ _ _', '_ _ _ _'),
            //đã xác nhận
            _timeLine(order, '_ _ _ _ _ _ _ _', '_ _ _ _'),
            //đóng gói
            _timeLine(order, '_ _ _ _ _ _ _ _', '_ _ _ _'),
            //vận chuyễn
            _timeLine(order, '_ _ _ _ _ _ _ _', '_ _ _ _'),
            //hoàn thành
            _timeLine(order, '_ _ _ _ _ _ _ _', '_ _ _ _'),
          ],
        );
    }
  }
}
