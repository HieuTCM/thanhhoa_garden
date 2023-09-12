import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thanhhoa_garden/blocs/bonsai/bonsai_bloc.dart';
import 'package:thanhhoa_garden/blocs/bonsai/bonsai_event.dart';
import 'package:thanhhoa_garden/blocs/bonsai/bonsai_state.dart';
import 'package:thanhhoa_garden/blocs/cart/cart_bloc.dart';
import 'package:thanhhoa_garden/blocs/cart/cart_event.dart';
import 'package:thanhhoa_garden/blocs/feedback/feedback_bloc.dart';
import 'package:thanhhoa_garden/blocs/feedback/feedback_event.dart';
import 'package:thanhhoa_garden/blocs/feedback/feedback_state.dart';

import 'package:thanhhoa_garden/components/appBar.dart';
import 'package:thanhhoa_garden/components/cart/cartButton.dart';
import 'package:thanhhoa_garden/components/feedback/listfeedback_component.dart';
import 'package:thanhhoa_garden/components/listImg.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/bonsai/bonsai.dart';
import 'package:thanhhoa_garden/models/bonsai/plantCategory.dart';
import 'package:thanhhoa_garden/models/feedback/feedback.dart';
import 'package:thanhhoa_garden/providers/cart/cart_provider.dart';
import 'package:thanhhoa_garden/screens/feedback/feedbackPlantScreen.dart';

class BonsaiDetail extends StatefulWidget {
  final String bonsaiID;
  final String name;
  BonsaiDetail({super.key, required this.bonsaiID, required this.name});

  @override
  State<BonsaiDetail> createState() => _BonsaiDetailState();
}

class _BonsaiDetailState extends State<BonsaiDetail> {
  Bonsai bonsai = Bonsai();
  var f = NumberFormat("###,###,###", "en_US");
  late FeedbackBloc feedbackBloc;
  late Stream<FeedbackState> feedbackStream;

  late BonsaiBloc bonsaiBloc;
  late Stream<BonsaiState> bonsaiStream;

  CartProvider cartProvider = CartProvider();
  late CartBloc cartBloc;

  int count = 1;
  @override
  void initState() {
    cartBloc = Provider.of<CartBloc>(context, listen: false);
    feedbackBloc = Provider.of<FeedbackBloc>(context, listen: false);
    bonsaiBloc = Provider.of<BonsaiBloc>(context, listen: false);

    feedbackStream = feedbackBloc.feedbackStateStream;
    bonsaiStream = bonsaiBloc.authStateStream;
    getBonsai();
    feedbackBloc.send(GetAllFeedbackEventByPlantID(
        plantID: widget.bonsaiID,
        listFeedback: [],
        pageNo: 0,
        pageSize: 3,
        sortBy: 'ID',
        sortAsc: false));
    super.initState();
  }

  getBonsai() {
    bonsaiBloc.send(GetByIDBonsaiEvent(id: widget.bonsaiID));
  }

  @override
  void dispose() {
    // feedbackBloc.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: Builder(builder: (context) {
        return const CartButton();
      }),
      backgroundColor: background,
      body: Stack(
        children: [
          SingleChildScrollView(
              // shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  AppBarWiget(title: widget.name),
                  StreamBuilder<BonsaiState>(
                    stream: bonsaiStream,
                    initialData: BonsaiInitial(),
                    builder: (context, snapshot) {
                      final state = snapshot.data;
                      if (state is BonsaiLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is BonsaiSuccess) {
                        bonsai = state.bonsai!;
                        return _plantTab();
                      } else if (state is BonsaiFailure) {
                        return Text(state.errorMessage);
                      } else {
                        return Container();
                      }
                    },
                  ),
                  Container(
                    height: 10,
                    decoration: const BoxDecoration(color: divince),
                  ),
                  //feedback
                  _feedback(),
                  Container(
                    height: 10,
                  ),
                  Container(
                    height: 10,
                    decoration: const BoxDecoration(color: divince),
                  ),
                  Container(
                    height: 65,
                  ),
                ],
              )),
          Positioned(top: size.height - 65, child: _floatingBar()),
        ],
      ),
    );
  }

  Widget _plantTab() {
    return Column(
      children: [
        ListImg(listImage: bonsai.listImg!),
        Container(
          height: 10,
          decoration: const BoxDecoration(color: divince),
        ),
        //Plant Information
        _plantInformation(),
        Container(
          height: 10,
          decoration: const BoxDecoration(color: divince),
        ),
        //Note
        _noteCare(),
      ],
    );
  }

  Widget _plantInformation() {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(20),
      // height: 220,
      width: size.width,
      // decoration: const BoxDecoration(color: Colors.blueAccent),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'Mô tả: ',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        AutoSizeText(bonsai.description,
            style: const TextStyle(fontSize: 16, height: 1.5)
            // style: TextStyle(fontWeight: FontWeight.bold),
            ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            const Text(
              'Kèm Chậu: ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(bonsai.withPot == 'True' ? 'Có' : 'Không',
                style: const TextStyle(fontSize: 18)
                // style: TextStyle(fontWeight: FontWeight.bold),
                ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            const Text(
              'Tổng Chiều Cao: ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(bonsai.height.toString(), style: const TextStyle(fontSize: 18)
                // style: TextStyle(fontWeight: FontWeight.bold),
                ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            const Text(
              'Kính thước chậu : ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(bonsai.plantShipPrice!.potSize.toString(),
                style: const TextStyle(fontSize: 18)
                // style: TextStyle(fontWeight: FontWeight.bold),
                ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: const AutoSizeText(
                'Giá cây: ',
                maxLines: 1,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
                width: size.width * 0.6,
                child: AutoSizeText(
                  '${f.format(bonsai.price)} đ / Cây',
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 20,
                      color: priceColor,
                      fontWeight: FontWeight.w500),
                )),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            SizedBox(
              width: size.width * 0.3,
              child: const AutoSizeText(
                'Giá vận chuyển: ',
                maxLines: 1,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
                width: size.width * 0.6,
                child: AutoSizeText(
                  '${f.format(bonsai.plantShipPrice!.pricePerPlant)} đ / Cây',
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 20,
                      color: priceColor,
                      fontWeight: FontWeight.w500),
                )),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
            width: size.width,
            child: AutoSizeText(
              '* Giá vận chuyện được áp dụng dựa trên kích thước chậu của cây',
              maxLines: 1,
              style: const TextStyle(
                  fontSize: 15.5,
                  color: priceColor,
                  fontWeight: FontWeight.w500),
            )),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: size.width,
          child: const Row(
            children: [
              Text(
                'Danh mục : ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
            width: size.width,
            child: AutoSizeText(cateToString(bonsai.listCate!),
                style: TextStyle(fontSize: 16, height: 1.5))),
        const SizedBox(
          height: 5,
        ),
      ]),
    );
  }

  Widget _noteCare() {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(20),
      width: size.width,
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Chăm Sóc & Lưu Ý: ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          AutoSizeText(
            bonsai.careNote, style: const TextStyle(fontSize: 16, height: 1.5),
            // style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Widget _feedback() {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      width: size.width,
      decoration: const BoxDecoration(),
      child: SizedBox(
          // height: 395,
          child: StreamBuilder<FeedbackState>(
              initialData: FeedbackInitial(),
              stream: feedbackStream,
              builder: (context, snapshot) {
                final state = snapshot.data;
                if (state is FeedbackLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ListFeedbackSuccess) {
                  return state.listFeedback!.isEmpty
                      ? const Center(
                          child: Text('Cây chưa có đánh giá '),
                        )
                      : _listFeedback(state.listFeedback!);
                } else if (state is FeedbackFailure) {
                  return Text(state.errorMessage);
                } else {
                  return Container();
                }
              })),
    );
  }

  Widget _listFeedback(List<FeedbackModel> listFeedback) {
    var size = MediaQuery.of(context).size;
    return Column(children: [
      Row(
        children: [
          const Text(
            'Khách Hàng Cùng Đánh giá: ',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Icon(Icons.star, color: Colors.yellow, size: 25),
          Text(
            listFeedback[0].avgRatingFeedback.toString(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 5),
          Text(
              '(${listFeedback[0].totalFeedback.toString().split('.')[0]} đánh giá)')
        ],
      ),
      Center(
        child: Container(
          margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
          height: 1.5,
          width: size.width,
          decoration: const BoxDecoration(color: divince),
        ),
      ),
      ListFeebback(
        listData: listFeedback,
      ),
      Center(
        child: Container(
            alignment: Alignment.center,
            height: 40,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FeedbackPlantScreen(
                          PlantID: widget.bonsaiID,
                        )));
              },
              child: const Text(
                'Xem tất cả >>',
                style: TextStyle(
                    color: buttonColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            )),
      )
    ]);
  }

  Widget _floatingBar() {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(5),
      height: 65,
      width: size.width,
      decoration: const BoxDecoration(color: barColor),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                if (count > 1) {
                  count -= 1;
                }
              });
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              height: 45,
              width: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: buttonColor, borderRadius: BorderRadius.circular(50)),
              child: const FaIcon(FontAwesomeIcons.minus, color: lightText),
            ),
          ),
          Container(
              margin: const EdgeInsets.all(5),
              height: 45,
              width: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(color: buttonColor), color: Colors.white),
              child: Text(
                count.toString(),
                style: const TextStyle(fontSize: 25),
              )),
          GestureDetector(
            onTap: () {
              setState(() {
                count += 1;
              });
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              height: 45,
              width: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: buttonColor, borderRadius: BorderRadius.circular(50)),
              child: const FaIcon(FontAwesomeIcons.plus, color: lightText),
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              cartBloc.send(AddToCart(widget.bonsaiID, count));
            },
            child: Container(
              height: 45,
              width: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: buttonColor, borderRadius: BorderRadius.circular(50)),
              child: const Text(
                'Thêm Vào Giỏ',
                style: TextStyle(
                    color: lightText,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }

  String cateToString(List<PlantCategory> list) {
    String result = '';

    list.forEach(
      (element) {
        result = '${result + element.categoryName}, ';
      },
    );

    return result.substring(0, result.length - 2);
  }
}
