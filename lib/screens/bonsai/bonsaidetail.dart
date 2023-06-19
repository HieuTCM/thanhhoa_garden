import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thanhhoa_garden/blocs/feedback/feedback_bloc.dart';
import 'package:thanhhoa_garden/blocs/feedback/feedback_event.dart';

import 'package:thanhhoa_garden/components/appBar.dart';
import 'package:thanhhoa_garden/components/feedback/listfeedback_component.dart';
import 'package:thanhhoa_garden/components/listImg.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/bonsai/bonsai.dart';
import 'package:thanhhoa_garden/providers/feedback/feedback_provider.dart';

class BonsaiDetail extends StatefulWidget {
  Bonsai bonsai;
  BonsaiDetail({super.key, required this.bonsai});

  @override
  State<BonsaiDetail> createState() => _BonsaiDetailState();
}

class _BonsaiDetailState extends State<BonsaiDetail> {
  Bonsai bonsai = Bonsai();
  var f = NumberFormat("###,###,###", "en_US");
  late FeedbackBloc feedbackBloc;
  int count = 0;
  @override
  void initState() {
    bonsai = widget.bonsai;
    feedbackBloc = Provider.of<FeedbackBloc>(context, listen: false);
    feedbackBloc.send(GetAllFeedbackEvent());
    super.initState();
  }

  @override
  void dispose() {
    feedbackBloc.dispose();
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
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  AppBarWiget(title: bonsai.name),
                  //list Image
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
                  Container(
                    height: 10,
                    decoration: const BoxDecoration(color: divince),
                  ),
                  //feedback
                  _feedback(),

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
            Text(bonsai.with_pot == 'True' ? 'Có' : 'Không',
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
            Text(bonsai.height + ' Cm', style: const TextStyle(fontSize: 18)
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
              'Giá: ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '${f.format(double.parse(bonsai.price))} đ',
              style: const TextStyle(
                  fontSize: 20, color: priceColor, fontWeight: FontWeight.w500),
            ),
          ],
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
            bonsai.care_note, style: const TextStyle(fontSize: 16, height: 1.5),
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
      // height: 476,
      decoration: const BoxDecoration(),
      child: Column(children: [
        Row(
          children: const [
            Text(
              'Khách Hàng Cùng Đánh giá: ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(Icons.star, color: Colors.yellow, size: 25),
            Text(
              '4.5',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(width: 5),
            Text('(75 đánh giá)')
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
        SizedBox(
          height: 395,
          child: Consumer<FeedbackProvider>(
            builder: (context, value, _) {
              return (value.listFeedback == null)
                  ? const Center(child: CircularProgressIndicator())
                  : ListFeebback(
                      listData: value.listFeedback!,
                    );
            },
          ),
        ),
        Center(
          child: Container(
              alignment: Alignment.center,
              height: 40,
              child: GestureDetector(
                child: const Text(
                  'Xem tất cả >>',
                  style: TextStyle(
                      color: buttonColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              )),
        )
      ]),
    );
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
                if (count > 0) {
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
            onTap: () {},
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
}
