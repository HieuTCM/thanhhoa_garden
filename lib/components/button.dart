import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';
import 'package:thanhhoa_garden/blocs/order/orderBloc.dart';
import 'package:thanhhoa_garden/blocs/order/orderEvent.dart';
import 'package:thanhhoa_garden/components/note.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/providers/order/order_provider.dart';
import 'package:thanhhoa_garden/screens/home/historyScreen.dart';
import 'package:thanhhoa_garden/screens/order/orderHistoryScreen.dart';

class CancelOrderButton extends StatefulWidget {
  String status;
  String phone;
  String orderid;
  String totalPrice;
  CancelOrderButton(
      {super.key,
      required this.status,
      required this.phone,
      required this.orderid,
      required this.totalPrice});

  @override
  State<CancelOrderButton> createState() => _CancelOrderButtonState();
}

class _CancelOrderButtonState extends State<CancelOrderButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String reason = '';

  @override
  Widget build(BuildContext context) {
    var status = widget.status;
    var phone = widget.phone;
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        (status != 'WAITING')
            ? null
            : showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Center(
                      child: Text(
                        'Xác Nhận Hủy Đơn Hàng',
                        style: TextStyle(color: buttonColor, fontSize: 25),
                      ),
                    ),
                    content: SizedBox(
                        height: 250,
                        width: size.width - 10,
                        child: NoteCancelOrder(
                          orderid: widget.orderid,
                          totalPrice: widget.totalPrice,
                          phone: phone,
                        )),
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
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Text('Quay lại',
                                  style: TextStyle(
                                      color: lightText,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showdialogConfirm();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 110,
                              height: 45,
                              decoration: BoxDecoration(
                                  color: buttonColor,
                                  borderRadius: BorderRadius.circular(50)),
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
                });
      },
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 40,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: (status == 'WAITING') ? buttonColor : barColor,
            borderRadius: BorderRadius.circular(50)),
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: AutoSizeText(
            (status == 'WAITING') ? 'Hủy đơn' : convertStatusOrder(status),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w800,
                color: (status == 'WAITING') ? lightText : HintIcon)),
      ),
    );
  }

  dynamic showdialogConfirm() {
    var phone = widget.phone;
    var size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
              child: Text(
                'Xác Nhận Hủy Đơn Hàng',
                style: TextStyle(color: buttonColor, fontSize: 25),
              ),
            ),
            content: SizedBox(
                height: 170,
                width: size.width - 10,
                child: ConfirmCancelOrder(
                  callback: setReason,
                  orrderID: widget.orderid,
                )),
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
                          borderRadius: BorderRadius.circular(50)),
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
                      OrderProvider()
                          .cancelOrder(CancelOrderEvent(
                              status: 'CUSTOMERCANCELED',
                              orderID: widget.orderid,
                              reason: reason))
                          .then((value) {
                        if (value) {
                          OverlayLoadingProgress.stop();
                          Navigator.pop(context);
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => HistoryScreen(
                                        index: 0,
                                      )));
                          Fluttertoast.showToast(
                              msg: "Hủy đơn thành công",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          OverlayLoadingProgress.stop();
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "Hủy đơn thất bại",
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
                      alignment: Alignment.center,
                      width: 110,
                      height: 45,
                      decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: const Text('Hủy',
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
        });
  }

  setReason(String value) {
    setState(() {
      reason = value;
    });
  }
}
