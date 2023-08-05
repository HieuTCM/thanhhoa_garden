import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thanhhoa_garden/components/button.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/order/order.dart';
import 'package:thanhhoa_garden/screens/feedback/feedbackScreen.dart';

class ListFeedbackComponent extends StatefulWidget {
  final List<OrderDetail> listDetail;
  final ScrollController? scrollController;
  ListFeedbackComponent({
    super.key,
    required this.listDetail,
    this.scrollController,
  });

  @override
  State<ListFeedbackComponent> createState() => _ListFeedbackComponentState();
}

class _ListFeedbackComponentState extends State<ListFeedbackComponent> {
  var f = NumberFormat("###,###,###", "en_US");
  @override
  Widget build(BuildContext context) {
    return _listOrderDetail();
  }

  Widget _listOrderDetail() {
    return ListView.builder(
      controller: widget.scrollController,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const ScrollPhysics(),
      itemCount: widget.listDetail.length,
      itemBuilder: (context, index) {
        return _orderDetailTab(widget.listDetail[index]);
      },
    );
  }

  Widget _orderDetailTab(OrderDetail order) {
    return GestureDetector(
      onTap: () {},
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
                        convertStatusOrder(
                            order.showOrderModel!.progressStatus!),
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
                                convertDate(order.showOrderModel!),
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
                Text('${order.showPlantModel!.quantity} sản phẩm ',
                    style: const TextStyle(
                      color: darkText,
                      fontSize: 16,
                    )),
                const Spacer(),
                Text(
                    '${f.format(order.showPlantModel!.plantPrice! * order.showPlantModel!.quantity!)} đ',
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
            _bottomRow(order.showOrderModel!.progressStatus!,
                order.showOrderModel!, order)
          ],
        ),
      ),
    );
  }

  Widget _bottomRow(String status, OrderObject order, OrderDetail detail) {
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
                    builder: (context) => FeedbackScreen(
                        orderrDetailID: detail.id,
                        plantID: detail.showPlantModel!.id),
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
}
