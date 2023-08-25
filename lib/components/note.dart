import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  if (!await launchUrl(launchUri)) {
    throw 'Could not launch $launchUri';
  }
}

//Note Orderr
class NoteOrder extends StatefulWidget {
  final String? Phone;
  NoteOrder({super.key, this.Phone});

  @override
  State<NoteOrder> createState() => _NoteOrderState();
}

class _NoteOrderState extends State<NoteOrder> {
  String? phone = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    phone = widget.Phone ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Lưu ý',
            style: TextStyle(
                color: darkText, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  color: buttonColor, borderRadius: BorderRadius.circular(50)),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              alignment: Alignment.topLeft,
              width: size.width - 30,
              padding: const EdgeInsets.all(10),
              child: const AutoSizeText(
                'Khách hàng có thể huỷ đơn và được hoàn tiền 100% khi đơn chưa được giao.',
                style: TextStyle(color: darkText, fontSize: 18),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  color: buttonColor, borderRadius: BorderRadius.circular(50)),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              alignment: Alignment.topLeft,
              width: size.width - 30,
              padding: const EdgeInsets.all(10),
              child: const AutoSizeText(
                'Khi đơn được giao đến, khách hàng vui lòng kiểm tra sự dầy đủ và chính xác của đơn hàng.',
                style: TextStyle(color: darkText, fontSize: 18),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  color: buttonColor, borderRadius: BorderRadius.circular(50)),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              alignment: Alignment.topLeft,
              width: size.width - 30,
              padding: const EdgeInsets.all(10),
              child: RichText(
                text: TextSpan(
                    style: const TextStyle(color: darkText, fontSize: 18),
                    text: 'Mọi thắc mắc/bất tiện vui lòng gọi trực tiếp cho',
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => makePhoneCall(phone!),
                        text: ' chúng tôi ',
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: 'để được giải đáp/ xử lý kịp thời.')
                    ]),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Note Cancel Order
class NoteCancelOrder extends StatefulWidget {
  final String phone;
  final String orderid;
  final String totalPrice;
  NoteCancelOrder(
      {super.key,
      required this.phone,
      required this.orderid,
      required this.totalPrice});

  @override
  State<NoteCancelOrder> createState() => _NoteCancelOrderState();
}

class _NoteCancelOrderState extends State<NoteCancelOrder> {
  String? phone = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    phone = widget.phone;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  color: buttonColor, borderRadius: BorderRadius.circular(50)),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              alignment: Alignment.topLeft,
              width: size.width - 158,
              padding: const EdgeInsets.all(10),
              child: RichText(
                text: TextSpan(
                    style: const TextStyle(color: darkText, fontSize: 15),
                    text: 'Bạn có chắn sẽ huỷ đơn hàng ',
                    children: [
                      TextSpan(
                        text: widget.orderid.substring(1),
                        style: const TextStyle(
                            color: darkText,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: ' ,tổng đơn hàng '),
                      TextSpan(
                          text: widget.totalPrice,
                          style: const TextStyle(
                              color: darkText,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    ]),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  color: buttonColor, borderRadius: BorderRadius.circular(50)),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              alignment: Alignment.topLeft,
              width: size.width - 158,
              padding: const EdgeInsets.all(10),
              child: RichText(
                text: const TextSpan(
                    style: TextStyle(color: darkText, fontSize: 15),
                    text: 'Nếu ',
                    children: [
                      TextSpan(
                        text: 'Huỷ ',
                        style: TextStyle(
                            color: darkText,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: 'bạn sẽ được liên hệ hoàn tiền trong '),
                      TextSpan(
                          text: '48h ',
                          style: TextStyle(
                              color: darkText,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text:
                              'tiếp theo (Nếu có). Xin vui lòng kiểm tra điện thoại.'),
                    ]),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  color: buttonColor, borderRadius: BorderRadius.circular(50)),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              alignment: Alignment.topLeft,
              width: size.width - 158,
              padding: const EdgeInsets.all(10),
              child: RichText(
                text: TextSpan(
                    style: const TextStyle(color: darkText, fontSize: 15),
                    text: 'Trong trường hợp quá ',
                    children: [
                      const TextSpan(
                        text: '48h',
                        style: TextStyle(
                            color: darkText,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                          text:
                              ' vẫn chưa được liên hệ gửi lại tiền, vui lòng  '),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => makePhoneCall(phone!),
                          text: 'liên hệ chúng tôi',
                          style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      const TextSpan(text: ' hoặc đến cơ sở '),
                      const TextSpan(
                        text: 'Thanh Hoa',
                        style: TextStyle(
                            color: darkText,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: ' gần nhất để được hỗ trợ.'),
                    ]),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

//Note Confirm Cancel Order
class ConfirmCancelOrder extends StatefulWidget {
  final String orrderID;
  final Function callback;
  ConfirmCancelOrder(
      {super.key, required this.orrderID, required this.callback});

  @override
  State<ConfirmCancelOrder> createState() => _ConfirmCancelOrderState();
}

class _ConfirmCancelOrderState extends State<ConfirmCancelOrder> {
  TextEditingController _reasonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    List<String> listRea = listReason();
    String dropdownValue = listRea.last;
    return StatefulBuilder(
      builder: (context, setState) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Hủy đơn hàng: ',
                style: TextStyle(
                    color: darkText, fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.orrderID.substring(1),
                style: const TextStyle(
                  color: darkText,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                'Lý do hủy đơn : ',
                style: TextStyle(
                    color: darkText, fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 10,
              ),
              DropdownButton<String>(
                isExpanded: false,
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                    widget.callback(value);
                  });
                },
                items: listRea.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: SizedBox(width: 140, child: Text(value)),
                  );
                }).toList(),
              )
            ],
          ),
          (dropdownValue == 'Lý do khác')
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nhập lý do : '),
                    TextFormField(
                      controller: _reasonController,
                      maxLength: 150,
                      onChanged: (value) {
                        setState(() {
                          widget.callback(value);
                        });
                      },
                    ),
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}

//Report
class SendReport extends StatefulWidget {
  final Function callback;
  SendReport({super.key, required this.callback});

  @override
  State<SendReport> createState() => _SendReportState();
}

class _SendReportState extends State<SendReport> {
  TextEditingController _reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StatefulBuilder(
      builder: (context, setState) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: size.width - 130,
                child: const AutoSizeText(
                  'Gửi báo cáo cho chúng tôi nếu bạn cảm thấy không hài lòng về chất lượng phục vụ của nhân viên.',
                  style: TextStyle(
                      color: darkText,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Nội dung'),
              TextFormField(
                controller: _reasonController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng đủ thông tin';
                  }
                  return null;
                },
                maxLength: 150,
                onChanged: (value) {
                  setState(() {
                    widget.callback(value);
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
