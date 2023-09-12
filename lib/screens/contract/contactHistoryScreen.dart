import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thanhhoa_garden/blocs/contract/contactBloc.dart';
import 'package:thanhhoa_garden/blocs/contract/contactEvent.dart';
import 'package:thanhhoa_garden/blocs/contract/contactState.dart';
import 'package:thanhhoa_garden/components/appBar.dart';
import 'package:thanhhoa_garden/components/button.dart';
import 'package:thanhhoa_garden/components/sideBar.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/contract/contact.dart';
import 'package:thanhhoa_garden/providers/contact/contact_provider.dart';
import 'package:thanhhoa_garden/screens/contract/contactDetail.dart';

class ContactHistorySreen extends StatefulWidget {
  final Function callBack;
  ContactHistorySreen({super.key, required this.callBack});

  @override
  State<ContactHistorySreen> createState() => _ContactHistorySreenState();
}

class _ContactHistorySreenState extends State<ContactHistorySreen> {
  var f = NumberFormat("###,###,###", "en_US");
  ContactProvider contactProvider = ContactProvider();

  final _scrollController = ScrollController();

  bool isLoading = true;
  var selectedTab = 0;
  bool isLoadingcontact = false;
  int pageNo = 0;
  int PageSize = 10;
  String status = 'ALL';

  late ContactBloc contactBloc;
  late Stream<ContactState> contactStream;

  List<String> enumStatus = [];
  List<Contact> contactList = [];

  getEnum() {
    contactProvider.getContactStatus().then((value) {
      setState(() {
        enumStatus = contactProvider.enumStatus!;
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    contactBloc = Provider.of<ContactBloc>(context, listen: false);
    contactStream = contactBloc.authStateStream;
    _getContact(0, PageSize, 'CREATEDDATE', false);
    // TODO: implement initState
    getEnum();
    _scrollController.addListener(() {
      _getMore();
    });
    super.initState();
  }

  _getContact(
    int pageNo,
    int pageSize,
    String sortBy,
    bool sortAsc,
  ) {
    contactBloc.send(GetAllContactEvent(
        pageNo: pageNo,
        pageSize: pageSize,
        sortBy: sortBy,
        sortAsc: sortAsc,
        listContact: contactList));
  }

  _getMore() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      int totalPage = contactList[0].totalPage.round() - 1;
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
        await _searchContact(nextPage, PageSize, 'CREATEDDATE', false, status);
      }
    }
  }

  _searchContact(
    int pageNo,
    int pageSize,
    String sortBy,
    bool sortAsc,
    String? status,
  ) {
    contactBloc.send(GetAllContactEvent(
      listContact: contactList,
      pageNo: pageNo,
      pageSize: pageSize,
      sortBy: sortBy,
      sortAsc: sortAsc,
      status: status == 'ALL' ? null : status,
    ));
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
        drawer: SideBar(),
        backgroundColor: background,
        body: Container(
            height: size.height,
            child: Column(children: [
              const SizedBox(
                height: 35,
              ),
              AppBarWiget(
                title: 'Hợp đồng của bạn',
                tail: _tailButton(),
              ),
              const SizedBox(
                height: 20,
              ),
              //Status list
              (isLoading)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      height: 50,
                      width: size.width,
                      child: _listStatus(),
                    ),
              Container(
                height: 10,
                decoration: const BoxDecoration(color: divince),
              ),
              Expanded(child: _listContact())
            ])));
  }

  Widget _tailButton() {
    return GestureDetector(
      onTap: () {
        widget.callBack();
      },
      child: Stack(
        children: [
          Center(
              child: SizedBox(
            height: 40,
            width: 35,
            child: FaIcon(
              FontAwesomeIcons.cartShopping,
              color: Colors.cyan.shade700,
              size: 30,
            ),
          )),
          const Positioned(
              bottom: -10,
              right: -5,
              child: Icon(
                Icons.compare_arrows_sharp,
                color: buttonColor,
                size: 40,
              ))
        ],
      ),
    );
  }

  Widget _statusTab(List<String> enumStatus) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTab = index;
                status = enumStatus[index];
                contactList.clear();
                pageNo = 0;
              });
              _searchContact(0, PageSize, 'CREATEDDATE', false, status);
            },
            child: Container(
              alignment: Alignment.center,
              width: 100,
              height: 30,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: (selectedTab == index) ? buttonColor : barColor,
                  borderRadius: BorderRadius.circular(50)),
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: AutoSizeText(convertStatusContact(enumStatus[index]),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: (selectedTab == index) ? lightText : HintIcon)),
            ),
          );
        },
        itemCount: enumStatus.length);
  }

  Widget _listStatus() {
    return _statusTab(enumStatus);
  }

  Widget _listContact() {
    return StreamBuilder<ContactState>(
      stream: contactStream,
      initialData: ContactInitial(),
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state is ContactLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ListContactSuccess) {
          contactList = [...state.listContact!];
          return contactList.isEmpty
              ? const Center(
                  child: Text('Không tìm thấy hợp đồng'),
                )
              : ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const ScrollPhysics(),
                  itemCount: contactList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ContactDetailScreen(contact: contactList[index]),
                        ));
                      },
                      child:
                          (contactList[index].showStaffModel!.fullName == null)
                              ? _contactTab(contactList[index])
                              : _contactTabWithStaff(contactList[index]),
                    );
                  },
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

  Widget _contactTab(Contact contact) {
    return Container(
      constraints: const BoxConstraints(minHeight: 160),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(left: 10, top: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: tabBackground, borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 10, right: 10),
          width: MediaQuery.of(context).size.width,
          child: AutoSizeText(
            contact.title,
            maxLines: 1,
            style: const TextStyle(fontSize: 500, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        _inforRow('Mã hợp đồng', contact.id.toString().substring(2), null),
        _inforRow('Ngày bắt đầu', getDate(contact.startedDate).substring(0, 10),
            null),
        // _inforRow(
        //     'Ngày kết thúc', getDate(contact.endedDate).substring(0, 10), null),
        _inforRow(
            'Giá trị hợp đồng', '${f.format(contact.total)} đ', priceColor),
        _inforRow('Trạng thái', convertStatusContact(contact.status), null),
        _inforRow('Địa chỉ', contact.address, null),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CancelContractButton(
                contractid: contact.id,
                phone: contact.showStoreModel!.phone,
                status: contact.status)
          ],
        )
      ]),
    );
  }

  Widget _contactTabWithStaff(Contact contact) {
    return Container(
      constraints: const BoxConstraints(minHeight: 160),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(left: 10, top: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: tabBackground, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(
            contact.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.33 - 33,
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  contact.showStaffModel!.avatar ?? NoIMG))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Nhân viên',
                        style: TextStyle(
                          color: darkText,
                          fontSize: 16,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: AutoSizeText(contact.showStaffModel!.fullName,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: darkText,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
              Column(children: [
                const SizedBox(
                  height: 10,
                ),
                _inforRow(
                    'Mã hợp đồng', contact.id.toString().substring(2), null),
                _inforRow('Ngày bắt đầu',
                    getDate(contact.startedDate).substring(0, 10), null),
                // _inforRow('Ngày kết thúc',
                //     getDate(contact.endedDate).substring(0, 10), null),
                _inforRow('Giá trị hợp đồng', '${f.format(contact.total)} đ',
                    priceColor),
                _inforRow(
                    'Trạng thái', convertStatusContact(contact.status), null),
                _inforRow('Địa chỉ', contact.address, null),
              ]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _inforRow(String title, String value, Color? colorValue) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: size.width - 133,
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 100,
                child: AutoSizeText(
                  '$title : ',
                  maxLines: 1,
                  style: const TextStyle(
                      color: darkText,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 243,
                child: AutoSizeText(
                  value,
                  maxLines: 1,
                  style: TextStyle(color: colorValue ?? darkText, fontSize: 18),
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
}
