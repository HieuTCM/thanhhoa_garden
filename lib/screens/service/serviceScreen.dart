import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:thanhhoa_garden/components/appBar.dart';
import 'package:thanhhoa_garden/components/listImg.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/service/service.dart';
import 'package:thanhhoa_garden/providers/service/service_provider.dart';

class ServiceDetail extends StatefulWidget {
  Service service;
  ServiceDetail({super.key, required this.service});

  @override
  State<ServiceDetail> createState() => _ServiceDetailState();
}

class _ServiceDetailState extends State<ServiceDetail> {
  Service service = Service();
  List<ServicePack> listServicePack = [];
  ServiceProvider serviceProvider = ServiceProvider();

  void initState() {
    service = widget.service;
    getServicePack();
    super.initState();
  }

  getServicePack() {
    serviceProvider.getAllServicePack().then((value) {
      setState(() {
        listServicePack = serviceProvider.listSeriverPack!;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: background,
      body: Stack(children: [
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(children: [
            const SizedBox(
              height: 35,
            ),
            AppBarWiget(title: service.name),
            //list Image
            ListImg(listImage: service.listImg!),
            Container(
              height: 10,
              decoration: const BoxDecoration(color: divince),
            ),
            //Information
            Container(
                padding: const EdgeInsets.all(20),
                width: size.width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Mô tả: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      AutoSizeText(service.description,
                          style: const TextStyle(fontSize: 16, height: 1.5)
                          // style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                      const SizedBox(
                        height: 5,
                      ),
                    ])),
            Container(
              height: 10,
              decoration: const BoxDecoration(color: divince),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              height: 43,
              width: size.width,
              decoration: const BoxDecoration(color: barColor),
              child: const Text(
                'Tiến Hành Đặt Dịch Vụ',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 10,
              decoration: const BoxDecoration(color: divince),
            ),

            Container(
              height: 65,
            ),
          ]),
        ),
        Positioned(top: size.height - 65, child: _floatingBar()),
      ]),
    );
  }

  Widget _floatingBar() {
    var size = MediaQuery.of(context).size;
    var f = NumberFormat("###,###,###", "en_US");
    return Container(
      padding: const EdgeInsets.all(10),
      height: 65,
      width: size.width,
      decoration: const BoxDecoration(color: barColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            'Giá: ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            '${f.format(widget.service.price)} đ',
            style: const TextStyle(
                fontSize: 20, color: priceColor, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 45,
              width: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: buttonColor, borderRadius: BorderRadius.circular(50)),
              child: const Text(
                'Xem hợp đồng',
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
