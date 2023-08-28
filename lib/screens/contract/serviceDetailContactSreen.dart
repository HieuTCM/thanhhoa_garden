import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'package:thanhhoa_garden/components/appBar.dart';
import 'package:thanhhoa_garden/components/listImg.dart';
import 'package:thanhhoa_garden/constants/constants.dart';

import 'package:thanhhoa_garden/models/contract/contact.dart';
import 'package:thanhhoa_garden/models/service/service.dart';

class ServiceDetailContact extends StatefulWidget {
  final ContactDetail detail;
  ServiceDetailContact({super.key, required this.detail});

  @override
  State<ServiceDetailContact> createState() => _ServiceDetailContactState();
}

class _ServiceDetailContactState extends State<ServiceDetailContact> {
  var f = NumberFormat("###,###,###", "en_US");
  Service service = Service();

  ServicePack servicePackSelect = ServicePack();
  TypeService typeService = TypeService();

  String totalPrice = '0';

  TextEditingController _inforController = TextEditingController();
  TextEditingController _StartDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();

  final _multiSelectKey = GlobalKey<FormFieldState>();

  final _formKey = GlobalKey<FormState>();

  DateTime? startDate;
  DateTime? endDate;
  void initState() {
    service = widget.detail.serviceModel!;
    servicePackSelect = widget.detail.servicePackModel!;
    typeService = widget.detail.serviceTypeModel!;
    _inforController.text = widget.detail.note!;
    _StartDateController.text = formatDateShow(widget.detail.startDate!);
    _endDateController.text = formatDateShow(widget.detail.endDate!);
    totalPrice = f.format(widget.detail.totalPrice);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Scaffold(
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
              ListImg(listImage: service.imgList!),
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
                        Row(
                          children: [
                            Text(
                              'Giá dịch vụ: ${f.format(service.price)} đ / tháng',
                              style: const TextStyle(
                                  color: priceColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
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
              _infor('Thông tin cây (vườn) của bạn :'),
              Container(
                height: 10,
                decoration: const BoxDecoration(color: divince),
              ),
              _serviceTab(),
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
      ),
    );
  }

  Widget _infor(String title) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  color: buttonColor, borderRadius: BorderRadius.circular(50)),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Chiều cao của cây (độ rộng của vườn) :',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              _listSize(service),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Ghi chú :',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              _textFormField('Mô tả cây (vườn) của bạn', 'Mô tả cây (vườn)',
                  false, () {}, _inforController, 150, 3),
            ],
          ),
        )
      ]),
    );
  }

  Widget _listSize(Service service) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 58,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: buttonColor, width: 2),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: SizedBox(
          width: MediaQuery.of(context).size.width - 130,
          child: AutoSizeText(
              'Chiều cao (diện tích) ${typeService.size} (tăng ${typeService.percentage}%)',
              style: const TextStyle(fontSize: 18, color: buttonColor))),
    );
  }

  Widget _textFormField(String label, String hint, bool readonly,
      Function()? onTap, TextEditingController controller, maxLength, height) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            width: MediaQuery.of(context).size.width - 60,
            child: TextFormField(
              autofocus: false,
              readOnly: readonly,
              controller: controller,
              maxLines: height,
              minLines: 1,
              onTap: onTap,
              maxLength: maxLength,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Vui lòng đủ thông tin';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: label,
                hintText: hint,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: buttonColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: buttonColor,
                    width: 2.0,
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget _listPack() {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 58,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: buttonColor, width: 2),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width - 130,
          height: 58,
          child: AutoSizeText(
              'Thời gian ${servicePackSelect.range}'
              '${servicePackSelect.percentage == 0 ? '' : '( ưu đãi  ${servicePackSelect.percentage} %)'}',
              style: const TextStyle(fontSize: 18, color: buttonColor))),
    );
  }

  Widget _serviceTab() {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              (service.serviceID == 'SE002')
                  ? const SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Thời gian làm việc',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.detail.timeWorking,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Gói dịch vụ ',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              _listPack(),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Ngày bắt đầu hợp đồng',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              _textFormField('Ngày bắt đầu hợp đồng', 'Chọn ngày bắt đầu', true,
                  () {}, _StartDateController, null, 1),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Ngày Kết thúc hợp đồng',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              _textFormField('Ngày kết thúc hợp đồng', 'Ngày kết thức', true,
                  null, _endDateController, null, 1),
            ],
          ),
        )
      ]),
    );
  }

  getStartDate() async {
    startDate = await showDatePicker(
        helpText: 'Chọn ngày bắt đầu hợp đồng',
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    setState(() {
      _StartDateController.text = formatDate1(startDate!);
    });

    getEndDate(startDate!, servicePackSelect);
  }

  getEndDate(DateTime startDate, ServicePack servicePack) async {
    switch (servicePack.range) {
      case '1 tháng':
        endDate = startDate.add(const Duration(days: 30));
        break;
      case '3 tháng':
        endDate = startDate.add(const Duration(days: 90));
        break;
      case '6 tháng':
        endDate = startDate.add(const Duration(days: 180));
        break;
      case '1 năm':
        endDate = startDate.add(const Duration(days: 365));
        break;
      default:
        endDate = await showDatePicker(
            helpText: 'Chọn ngày kết thúc hợp đồng',
            context: context,
            initialDate: startDate.add(const Duration(days: 366)),
            firstDate: startDate.add(const Duration(days: 366)),
            lastDate: DateTime(2101));
    }
    setState(() {
      _endDateController.text = formatDate1(endDate!);
      print('Start : ' + _StartDateController.text);
      print('End: ' + _endDateController.text);
      totalPrice = setPriceService(service.price, typeService.percentage,
          servicePackSelect.percentage, countMonths(startDate, endDate!));
    });
  }

  Widget _selectWorkingDate() {
    List<String> litDate = [
      'Thứ 2',
      'Thứ 3',
      'Thứ 4',
      'Thứ 5',
      'Thứ 6',
      'Thứ 7',
      'Chủ nhật'
    ];
    final _items =
        litDate.map((date) => MultiSelectItem<String>(date, date)).toList();
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: lightText,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: buttonColor,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              MultiSelectBottomSheetField(
                key: _multiSelectKey,
                initialChildSize: 0.4,
                listType: MultiSelectListType.CHIP,
                searchable: false,
                buttonText: const Text("Thời gian làm việc"),
                title: const Text("Ngày làm việc bạn muốn nhân viên đến"),
                items: _items,
                selectedColor: buttonColor,
                selectedItemsTextStyle: const TextStyle(color: lightText),
                validator: (value) {
                  if (value!.length > 3) {
                    return "Chọn tối đa 3 ngày làm việc";
                  }
                  if (value.length == 0) {
                    return "Bạn chưa chọn ngày làm việc";
                  }
                  return null;
                },
                onConfirm: (values) {
                  _multiSelectKey.currentState!.validate();
                },
                onSelectionChanged: (p0) {},
                maxChildSize: 0.5,
                chipDisplay: MultiSelectChipDisplay(
                  chipColor: buttonColor,
                  textStyle: const TextStyle(color: lightText),
                  onTap: (value) {
                    // setState(() {
                    //   selectDate.remove(value.toString());
                    // });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _floatingBar() {
    var size = MediaQuery.of(context).size;

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
            '$totalPrice đ',
            style: const TextStyle(
                fontSize: 20, color: priceColor, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
