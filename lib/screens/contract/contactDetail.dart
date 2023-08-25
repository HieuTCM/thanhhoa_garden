import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:popup_banner/popup_banner.dart';
import 'package:provider/provider.dart';
import 'package:thanhhoa_garden/blocs/contract/contactBloc.dart';
import 'package:thanhhoa_garden/blocs/contract/contactEvent.dart';
import 'package:thanhhoa_garden/blocs/contract/contactState.dart';
import 'package:thanhhoa_garden/components/appBar.dart';
import 'package:thanhhoa_garden/components/note.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/authentication/user.dart';
import 'package:thanhhoa_garden/models/contract/contact.dart';
import 'package:thanhhoa_garden/providers/contact/contact_provider.dart';
import 'package:thanhhoa_garden/providers/report/report_provider.dart';

class ContactDetailScreen extends StatefulWidget {
  final Contact? contact;
  ContactDetailScreen({super.key, required this.contact});

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  int indexStack = 0;
  bool isSelected = false;

  var f = NumberFormat("###,###,###", "en_US");
  ContactProvider contactProvider = ContactProvider();

  final _scrollController = ScrollController();

  bool isLoading = true;
  var selectedTab = 0;
  bool isLoadingcontact = false;
  int pageNo = 0;
  int PageSize = 10;

  late ContactBloc contactBloc;
  late Stream<ContactState> contactStream;

  List<ContactDetail> contactDetailList = [];

  _getContactDetail(
    int pageNo,
    int pageSize,
    String sortBy,
    bool sortAsc,
  ) {
    contactBloc.send(GetAllContactDetailEvent(
        pageNo: pageNo,
        pageSize: pageSize,
        sortBy: sortBy,
        sortAsc: sortAsc,
        contactID: widget.contact!.id,
        listContactDetail: contactDetailList));
  }

  _getMore() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      int totalPage = contactDetailList[0].totalPage.round() - 1;
      if (pageNo >= totalPage) {
        // setState(() {
        //   isLoading = false;
        // });
        Fluttertoast.showToast(
            msg: "Hết trang",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: buttonColor,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Đang tải thêm đơn hàng ...",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: buttonColor,
            textColor: Colors.white,
            fontSize: 16.0);
        pageNo++;
        int nextPage = pageNo;
        await _searchContact(
            nextPage, PageSize, 'CREATEDDATE', false, widget.contact!.id);
      }
    }
  }

  _searchContact(
    int pageNo,
    int pageSize,
    String sortBy,
    bool sortAsc,
    String? id,
  ) {
    contactBloc.send(GetAllContactDetailEvent(
        listContactDetail: contactDetailList,
        pageNo: pageNo,
        pageSize: pageSize,
        sortBy: sortBy,
        sortAsc: sortAsc,
        contactID: id));
  }

  checkSelect(int index) {
    switch (index == indexStack) {
      case true:
        setState(() {
          isSelected = !isSelected;
        });
    }
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

  @override
  void initState() {
    // TODO: implement initState
    contactBloc = Provider.of<ContactBloc>(context, listen: false);
    contactStream = contactBloc.authStateStream;
    _getContactDetail(0, PageSize, 'ID', true);

    _scrollController.addListener(() {
      _getMore();
    });
    super.initState();
  }

  @override
  void dispose() {
    contactBloc.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: background,
        body: SingleChildScrollView(
            // physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(children: [
              const SizedBox(
                height: 35,
              ),
              AppBarWiget(title: 'Chi Tiết Hợp Đồng'),
              _tabIndex(),
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
              IndexedStack(
                index: indexStack,
                alignment: Alignment.topCenter,
                children: [
                  SingleChildScrollView(
                      child: Column(
                    children: [
                      _contactTab(widget.contact!),
                      Container(
                        height: 10,
                        decoration: const BoxDecoration(color: divince),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Bản cứng hợp đồng: ',
                            style: TextStyle(
                                color: darkText,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            constraints: BoxConstraints(
                              minWidth: size.width - 270,
                            ),
                            child: AutoSizeText(
                              widget.contact!.isSigned
                                  ? 'Đã ký'
                                  : 'Chưa ký hợp đồng',
                              style: const TextStyle(
                                  color: darkText, fontSize: 16),
                            ),
                          ),
                          const Spacer(),
                          widget.contact!.isSigned
                              ? IconButton(
                                  onPressed: () {
                                    PopupBanner(
                                      fit: BoxFit.cover,
                                      height: size.height * 0.8,
                                      context: context,
                                      images: [
                                        for (int i = 0;
                                            i < widget.contact!.imgList!.length;
                                            i++)
                                          widget.contact!.imgList![i].url
                                      ],
                                      autoSlide: false,
                                      dotsAlignment: Alignment.bottomCenter,
                                      dotsColorActive: buttonColor,
                                      dotsColorInactive:
                                          Colors.grey.withOpacity(0.5),
                                      onClick: (index) {
                                        debugPrint("CLICKED $index");
                                      },
                                    ).show();
                                  },
                                  icon: const Icon(
                                    Icons.image,
                                    color: buttonColor,
                                    size: 35,
                                  ))
                              : const SizedBox(),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      (widget.contact!.showStaffModel!.fullName != null)
                          ? _staffTab(widget.contact!.showStaffModel!)
                          : const SizedBox(),
                      _customerTab(widget.contact!.showCustomerModel!),
                    ],
                  )),
                  SingleChildScrollView(
                    child: _listService(),
                  ),
                ],
              )
            ])));
  }

  Widget _contactTab(Contact contact) {
    return Column(
      children: [
        _inforRow('Mã hợp đồng', contact.id.toString().substring(2), null),
        _inforRow('Tên hợp đồng', contact.title, null),
        _inforRow('Ngày bắt đầu', getDate(contact.startedDate).substring(0, 10),
            null),
        _inforRow(
            'Ngày kết thúc', getDate(contact.endedDate).substring(0, 10), null),
        _inforRow('Trạng thái', convertStatusContact(contact.status), null),
        _inforRow('Địa chỉ', contact.address, null),
        _inforRow(
            'Giá trị hợp đồng', '${f.format(contact.total)} đ', priceColor),
        _inforRow(
            'Trạng thái thanh toán',
            contact.isPaid ? 'Hoàn thành' : 'Chưa hoàn thành',
            contact.isPaid ? buttonColor : priceColor),
      ],
    );
  }

  Widget _staffTab(User staff) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: 10,
          decoration: const BoxDecoration(color: divince),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text('Thông tin nhân viên ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 10,
        ),
        _inforRow('Tên', staff.fullName, null),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Số điện thoại: ',
              style: TextStyle(
                  color: darkText, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: (() {
                makePhoneCall(staff.phone);
              }),
              child: Container(
                constraints: BoxConstraints(
                  minWidth: size.width - 270,
                ),
                child: AutoSizeText(
                  staff.phone,
                  style: const TextStyle(color: buttonColor, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        _inforRow('Email', staff.email, null),
      ],
    );
  }

  Widget _customerTab(User customer) {
    // var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: 10,
          decoration: const BoxDecoration(color: divince),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text('Thông tin khác hàng',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 10,
        ),
        _inforRow('Tên', customer.fullName, null),
        _inforRow('Số điện thoại', customer.phone, null),
        _inforRow('Email', customer.email, null),
        _inforRow('Địa chỉ', customer.address, null),
      ],
    );
  }

  Widget _tabIndex() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          GestureDetector(
            onTap: () {
              if (indexStack == 1) {
                setState(() {
                  indexStack = 0;
                  checkSelect(0);
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
              child: AutoSizeText(
                'Hợp đồng',
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
              child: Text('Dịch vụ',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: checkTextColor(!isSelected))),
            ),
          ),
        ]));
  }

  Widget _inforRow(String title, String value, Color? colorValue) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(
            minWidth: size.width - 140,
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                '$title : ',
                style: const TextStyle(
                    color: darkText, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                constraints: BoxConstraints(
                  minWidth: size.width - 270,
                ),
                child: AutoSizeText(
                  value,
                  style: TextStyle(color: colorValue ?? darkText, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _listService() {
    return StreamBuilder<ContactState>(
      stream: contactStream,
      initialData: ContactInitial(),
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state is ContactLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ListContactDetailSuccess) {
          contactDetailList = [...state.listContactDetail!];
          return contactDetailList.isEmpty
              ? const Center(
                  child: Text('Không tìm thấy hợp đồng'),
                )
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Container(
                    child: _serviceTab(contactDetailList[index], index + 1),
                  ),
                  itemCount: contactDetailList.length,
                );
        } else if (state is ContactFailure) {
          return const Center(
            child: Text('Không tìm thấy đơn hàng'),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _serviceTab(ContactDetail detail, int index) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: Column(children: [
        SizedBox(
          width: size.width,
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(50)),
              ),
              const SizedBox(
                width: 10,
              ),
              AutoSizeText(
                'Thông tin dịch vụ $index: ',
                style: const TextStyle(
                    color: darkText, fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        _inforRow('Tên dịch vụ', detail.serviceModel!.name, null),
        detail.serviceModel!.atHome
            ? _inforRow(
                'Lịch chăm sóc',
                detail.timeWorking
                    .toString()
                    .replaceAll(RegExp(r'[\[*\]]'), ''),
                null)
            : const SizedBox(),
        _inforRow('Ngày bắt đầu', formatDateShow(detail.startDate), null),
        _inforRow('Ngày kết thức', formatDateShow(detail.endDate), null),
        _inforRow(
            'Gói dịch vụ',
            detail.servicePackModel!.range +
                ' ' +
                detail.servicePackModel!.unit +
                ' ( giảm ' +
                detail.servicePackModel!.percentage.toString() +
                ' % )',
            null),
        _inforRow(
            'Loại dịch vụ',
            detail.serviceTypeModel!.name +
                ' (thêm ' +
                detail.serviceTypeModel!.percentage.toString() +
                ' % )',
            null),
        _inforRow('Đơn giá', f.format(detail.serviceModel!.price), null),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              _inforRow('Lưu ý', detail.note, null),
              Spacer(),
              (widget.contact!.status == 'WORKING')
                  ? GestureDetector(
                      onTap: () {
                        reportDialog(detail.id);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 40,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(50)),
                        margin: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: const AutoSizeText('Gửi báo cáo',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800, color: lightText)),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
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
      ]),
    );
  }

  dynamic reportDialog(String detailID) {
    // var phone = widget.phone;
    var size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
              child: Text(
                'Gửi báo cáo',
                style: TextStyle(color: buttonColor, fontSize: 25),
              ),
            ),
            content: SizedBox(
                height: 170,
                width: size.width - 10,
                child: SendReport(
                  callback: setReason,
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
                      if (reason.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Vui lòng nhập nội dung báo cáo",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else if (reason.length < 5) {
                        Fluttertoast.showToast(
                            msg: "Vui lòng mô tả chi tiết hơn",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        OverlayLoadingProgress.start(context);
                        Navigator.pop(context);
                        ReportProvider()
                            .SendReport(detailID, reason)
                            .then((value) {
                          if (value) {
                            Fluttertoast.showToast(
                                msg: "Gửi báo cáo thành công",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            OverlayLoadingProgress.stop();
                          } else {
                            Fluttertoast.showToast(
                                msg: "Gửi báo cáo thất bại",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            OverlayLoadingProgress.stop();
                          }
                        });
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 110,
                      height: 45,
                      decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: const Text('Gửi',
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

  String reason = '';
  bool validate = false;
  setReason(String value) {
    setState(() {
      reason = value;
    });
  }
}
