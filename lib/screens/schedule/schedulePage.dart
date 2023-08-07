// ignore_for_file: must_be_immutable, file_names, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:thanhhoa_garden/models/contract/contact.dart';
import '../../components/circular.dart';
import 'package:thanhhoa_garden/models/workingDate/working_date.dart';
import '../../components/appBar.dart';
import '../../components/button/dialog_button.dart';
import '../../components/schedule/calender_componenet2.dart';
import '../../constants/constants.dart';
import '../../providers/schedule/schedule_provider.dart';
import '../../utils/format/date.dart';
import '../../utils/showDialog/show_dialog.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final ScrollController _scrollController = ScrollController();
  var selectedTab = 0; // For Main Category
  var selectedTabToday = 0; // For SUb Category (Today)
  var selectedTabInWeek = 0; // For SUb Category (Week schedule)
  var f = NumberFormat("###,###,###", "en_US");

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: background,
      body: SizedBox(
        height: size.height,
        child: Column(children: [
          const SizedBox(
            height: 35,
          ),
          //search Bar
          AppBarWiget(title: 'Lịch Chăm Sóc'),
          const SizedBox(
            height: 5,
          ),
          Center(
            child: Container(
              height: 1,
              width: size.width - 180,
              decoration: const BoxDecoration(color: buttonColor),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //Main Category list
          SizedBox(
            height: 50,
            width: size.width,
            child: _listCategory(),
          ),
          Container(
            height: 10,
            decoration: const BoxDecoration(color: divince),
          ),
          //Use when choose Today (selectedTab == 0)
          /*selectedTab == 0 ? Container(
            height: 50,
            width: size.width,
            child: _listCategoryToday(),
          ) : const SizedBox(),*/
          (selectedTab == 0 || selectedTab == 1)
              ? Container(
                  height: 1,
                  width: size.width,
                  decoration: const BoxDecoration(color: buttonColor),
                )
              : const SizedBox(),
          //Working List
          Expanded(
            child: selectedTab == 2
                ? _listSchedule()
                : selectedTab == 0
                    ? _listJobToday()
                    : _ScheduleFollowWeek(),
          ),
        ]),
      ),
    );
  }

  //All Of the Schedule that Staff done (History)
  Widget _listSchedule() {
    var size = MediaQuery.of(context).size;
    return FutureBuilder<List<WorkingDate>>(
      future: fetchSchedule(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Circular();
        }
        if (snapshot.hasData) {
          List<WorkingDate> date = snapshot.data!;
          if (snapshot.data! == null) {
            return const Center(
              child: Text(
                'Không có kết quả để hiển thị',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            );
          } else {
            int length = date.length;
            return ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: date.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ExpansionTile(
                      collapsedTextColor: Colors.black,
                      collapsedIconColor: Colors.black,
                      iconColor: buttonColor,
                      textColor: Colors.black,
                      backgroundColor: Colors.white,
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formatDatenoTime(
                                date[index].workingDate.toString()),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(date[index].serviceName.toString(),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          const SizedBox(
                            height: 5,
                          ),
                          _contractFiled(
                              'Khách hàng', date[index].fullName.toString()),
                          _contractFiled(
                              'Địa chỉ', date[index].address.toString()),
                        ],
                      ),
                      children: [
                        Column(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 5, right: 5, bottom: 10),
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: size.width - 40,
                                              height: 1,
                                              decoration: const BoxDecoration(
                                                  color: divince),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text('Thông tin dịch vụ',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: buttonColor)),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            _contractFiled('ID',
                                                date[index].id.toString()),
                                            _contractFiled(
                                                'Ngày làm việc',
                                                date[index]
                                                    .timeWorking
                                                    .toString()),
                                            _contractFiled('Chú ý',
                                                date[index].note.toString()),
                                            _contractFiled(
                                                date[index]
                                                            .serviceTypeID
                                                            .toString() ==
                                                        'ST005'
                                                    ? 'Kích thước vườn'
                                                    : date[index]
                                                                .serviceTypeID
                                                                .toString() ==
                                                            'ST006'
                                                        ? 'Kích thước vườn'
                                                        : date[index]
                                                                    .serviceTypeID
                                                                    .toString() ==
                                                                'ST007'
                                                            ? 'Kích thước vườn'
                                                            : date[index]
                                                                        .serviceTypeID
                                                                        .toString() ==
                                                                    'ST008'
                                                                ? 'Kích thước vườn'
                                                                : 'Chiều cao cây',
                                                date[index]
                                                    .typeSize
                                                    .toString()),
                                            _contractFiled(
                                                'Thời gian',
                                                date[index]
                                                    .packRange
                                                    .toString()),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              width: size.width - 40,
                                              height: 1,
                                              decoration: const BoxDecoration(
                                                  color: divince),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text('Thông tin khách hàng',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: buttonColor)),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            _contractFiled(
                                                'Khách hàng',
                                                date[index]
                                                    .fullName
                                                    .toString()),
                                            _contractFiled('địa chỉ',
                                                date[index].address.toString()),
                                            _contractFiled('Điện thoại',
                                                date[index].phone.toString()),
                                            _contractFiled(
                                                'Email',
                                                date[index].email == null
                                                    ? 'không có'
                                                    : date[index]
                                                        .email
                                                        .toString()),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          ],
                        )
                      ],
                    ),
                  );
                });
          }
        }
        return const Center(
          child: Text('Error'),
        );
      },
    );
  }

  Widget _listCategoryInWeek() {
    DateTime now = DateTime.now();
    String weekday = getWeekday(now.weekday);
    int seletedDay = formatNumDay(weekday);
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                setState(() {
                  selectedTabInWeek = index;
                });
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 7,
                height: 30,
                // padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: seletedDay == index
                        ? Border.all(width: 1, color: Colors.black)
                        : Border.all(width: 0, color: background),
                    color: (selectedTabInWeek == index)
                        ? buttonColor
                        : Colors.white),
                //margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: AutoSizeText(
                  dayOfWeek[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color:
                          (selectedTabInWeek == index) ? lightText : HintIcon),
                ),
              ));
        },
        itemCount: 7);
  }

  //UI Main Category
  Widget _listCategory() {
    DateTime now = DateTime.now();
    String weekday = getWeekday(now.weekday);
    int selectedDay = formatNumDay(weekday);
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                setState(() {
                  selectedTab = index;
                  selectedTab == 1
                      ? selectedTabInWeek = selectedDay
                      : selectedTabInWeek = 0;
                });
                // _searchPlant(0, PageSize, 'ID', true, null, cateID, null, null);
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 3,
                height: 30,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: (selectedTab == index) ? buttonColor : barColor,
                    borderRadius: BorderRadius.circular(50)),
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: AutoSizeText(
                  tab[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: (selectedTab == index) ? lightText : HintIcon),
                ),
              ));
        },
        itemCount: 3);
  }

  //List Working Today
  Widget _listJobToday() {
    bool ischeck = false;
    bool check = false;
    DateTime now = DateTime.now();
    String weekday = getWeekday(now.weekday);
    String fweekday = now.year.toString() +
        '-' +
        now.month.toString().padLeft(2, '0') +
        '-' +
        now.day.toString().padLeft(2, '0');
    var size = MediaQuery.of(context).size;

    return FutureBuilder<List<ContactDetail>>(
      future: fetchScheduleInWeek(fweekday, fweekday),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Circular();
        }
        if (snapshot.hasData) {
          List<ContactDetail> cD = snapshot.data!;
          if (snapshot.data == null) {
            return const Center(
              child: Text(
                'Không có kết quả để hiển thị',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            );
          } else {
            return ListView.builder(
                //padding: const EdgeInsets.symmetric(horizontal: 18),
                //scrollDirection: Axis.horizontal,
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: cD.length,
                itemBuilder: (BuildContext context, int index) {
                  List days_list =
                      (cD[index].timeWorking.toString().split(", "));
                  if (((selectedTabToday == 0) || (selectedTabToday == 1))) {
                    for (int i = 0; i < days_list.length; i++) {
                      if (days_list[i] == weekday) {
                        bool checkOk = false;
                        return GestureDetector(
                          onTap: () async {
                            print("need to fix ... sai logic roi");
                          },
                          child: Column(
                            children: [
                              Container(
                                width: size.width - 40,
                                margin:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Stack(
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cD[index]
                                                  .contactModel!
                                                  .title
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: size.width - 40,
                                                  height: 1,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: divince),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                _contractFiled('Mã công việc',
                                                    cD[index].id.toString()),
                                                _contractFiled(
                                                    'Mã hợp đồng',
                                                    cD[index]
                                                        .contactModel!
                                                        .id
                                                        .toString()),
                                                _contractFiled(
                                                    'Dịch vụ',
                                                    cD[index]
                                                            .serviceModel!
                                                            .name
                                                            .toString() +
                                                        ' - ' +
                                                        cD[index]
                                                            .serviceTypeModel!
                                                            .name
                                                            .toString()),
                                                _contractFiled(
                                                    'Lịch chăm sóc',
                                                    cD[index]
                                                        .timeWorking
                                                        .toString()),
                                                _contractFiled(
                                                    'Khách hàng',
                                                    cD[index]
                                                        .contactModel!
                                                        .fullName
                                                        .toString()),
                                                _contractFiled(
                                                    'Địa chỉ',
                                                    cD[index]
                                                        .contactModel!
                                                        .address
                                                        .toString()),
                                                _contractFiled(
                                                    'Điện thoại',
                                                    cD[index]
                                                        .contactModel!
                                                        .phone
                                                        .toString()),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      right: 5,
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog<String>(
                                            context: context,
                                            builder: (context) => SystemPadding(
                                              child: AlertDialog(
                                                  contentPadding:
                                                      const EdgeInsets.all(
                                                          16.0),
                                                  content: Row(
                                                    children: const <Widget>[
                                                      Text(
                                                          'Đã hoàn thành lịch chăm sóc này?'),
                                                    ],
                                                  ),
                                                  actions: <Widget>[
                                                    GestureDetector(
                                                      onTap: () async {
                                                        check =
                                                            (await checkWorkingDate(
                                                                cD[index].id,
                                                                fweekday))!;
                                                        if (check == true) {
                                                          Navigator.pop(
                                                              context);
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "Bạn đã đánh dấu công việc này rồi",
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity:
                                                                  ToastGravity
                                                                      .BOTTOM,
                                                              timeInSecForIosWeb:
                                                                  1,
                                                              backgroundColor:
                                                                  highLightText,
                                                              textColor:
                                                                  Colors.white,
                                                              fontSize: 16.0);
                                                        } else {
                                                          ConfirmWorkingDate(
                                                              cD[index].id);
                                                          print("cD[index].id: " +
                                                              cD[index]
                                                                  .id
                                                                  .toString());
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      },
                                                      child:
                                                          const ConfirmButton(
                                                              title: 'Xác nhận',
                                                              width: 70.0),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const ConfirmButton(
                                                        title: 'Quay Lại',
                                                        width: 70.0,
                                                      ),
                                                    ),
                                                  ]),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              color: buttonColor,
                                              borderRadius:
                                                  BorderRadius.circular(45)),
                                          child: const Center(
                                              child: Text(
                                            'Xác nhận',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 10,
                                decoration: const BoxDecoration(color: divince),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  }
                  return const SizedBox();
                });
          }
        }
        return const Center(
          child: Text('Error'),
        );
      },
    );
  }

  //Main Schedule Field
  Widget _contractFiled(String title, String des) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title + ': ',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            Text(
              des,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget _contractFiled2(String title, String des) {
    return Column(
      children: [
        Row(
          children: [
            Text(title + ': ',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            Text(
              des,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }

  //List Working follow weekday
  Widget _ScheduleFollowWeek() {
    DateTime now = DateTime.now();
    String weekday = getWeekday(now.weekday);
    String titleTime = weekday +
        ', ' +
        now.day.toString() +
        '-' +
        now.month.toString() +
        '-' +
        now.year.toString();
    print(titleTime);
    var size = MediaQuery.of(context).size;
    return CanlenderComponent();
  }

  //List main category
  List<String> tab = [('Hôm nay'), ('Lịch làm việc'), ('Lịch sử')];

  //List today category
  List<String> tabToday = [('Tất cả'), ('Đã xong'), ('Chưa xong')];

  //List Working follow weekday
  List<String> dayOfWeek = [
    ('Thứ 2'),
    ('Thứ 3'),
    ('Thứ 4'),
    ('Thứ 5'),
    ('Thứ 6'),
    ('Thứ 7'),
    ('Chủ Nhật')
  ];

  //List weekday (get by DateTime.now)
  String getWeekday(int weekday) {
    switch (weekday) {
      case 1:
        return 'Thứ 2';
      case 2:
        return 'Thứ 3';
      case 3:
        return 'Thứ 4';
      case 4:
        return 'Thứ 5';
      case 5:
        return 'Thứ 6';
      case 6:
        return 'Thứ 7';
      case 7:
        return 'Chủ Nhật';
      default:
        return '';
    }
  }
}
