import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/main.dart';
import 'package:thanhhoa_garden/models/contract/contact.dart';
import 'package:thanhhoa_garden/models/service/service.dart';
import 'package:thanhhoa_garden/utils/helper/shared_prefs.dart';

class ListCartService extends StatefulWidget {
  Function callback;
  ListCartService({super.key, required this.callback});

  @override
  State<ListCartService> createState() => _ListCartServiceState();
}

class _ListCartServiceState extends State<ListCartService> {
  var f = NumberFormat("###,###,###", "en_US");
  List<ContactDetail> listContactDetail = [];
  Map<int, bool> values = {};
  @override
  void initState() {
    // TODO: implement initState
    getListService();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  getListService() {
    var json = getListContactDetailFromSharedPrefs();
    for (var data in json) {
      setState(() {
        listContactDetail.add(ContactDetail.fromJson(data));
      });
    }
    if (listContactDetail.isNotEmpty) {
      for (int i = 0; i < listContactDetail.length; i++) {
        setState(() {
          values[i] = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listContactDetail.length,
      itemBuilder: (context, index) => _serviceTab(
          listContactDetail[listContactDetail.length - 1 - index],
          listContactDetail.length - 1 - index),
    );
  }

  Widget _serviceTab(ContactDetail contactDetail, index) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          SizedBox(
            width: size.width * 0.15,
            child: Checkbox(
              value: values[index] ?? true,
              onChanged: (value) {
                if (value!) {
                  widget.callback('add', index);
                } else {
                  widget.callback('remove', index);
                }
                setState(() {
                  values[index] = value;
                });
              },
            ),
          ),
          Container(
            width: size.width * 0.8,
            height: 140,
            decoration: BoxDecoration(
                gradient: tabBackground,
                borderRadius: BorderRadius.circular(10)),
            child: Row(children: [
              Container(
                  padding: EdgeInsets.zero,
                  width: 130,
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            contactDetail.serviceModel!.imgList![0].url ??
                                NoIMG)),
                  )),
              Container(
                padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * 0.8 - 140,
                        child: AutoSizeText(
                          contactDetail.serviceModel!.name,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.8 - 140,
                        child: AutoSizeText(
                          'Giá : ${f.format(contactDetail.totalPrice)} đ',
                          maxLines: 1,
                          style: const TextStyle(
                              color: priceColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      (contactDetail.timeWorking == '[]')
                          ? SizedBox()
                          : SizedBox(
                              width: size.width * 0.8 - 140,
                              child: AutoSizeText(
                                'Thời gian làm việc : ${contactDetail.timeWorking.toString().replaceAll(RegExp(r'[\[*\]]'), '')}',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                      SizedBox(
                        width: size.width * 0.8 - 140,
                        child: AutoSizeText(
                          'Thời gian hợp đồng : ${contactDetail.servicePackModel!.range}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.8 - 140,
                        child: AutoSizeText(
                          'Ngày bắt đầu: ${formatDateShow(contactDetail.startDate)}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ]),
              )
            ]),
          )
        ],
      ),
    );
  }
}
