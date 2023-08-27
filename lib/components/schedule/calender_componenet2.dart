import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/contract/contact.dart';
import '../../providers/schedule/schedule_provider.dart';
import '../circular.dart';

class CanlenderComponent extends StatefulWidget {
  const CanlenderComponent({Key? key}) : super(key: key);

  @override
  State<CanlenderComponent> createState() => _CanlenderComponentState();
}

DateTime today = DateTime.now();
bool isSelected = false;

class _CanlenderComponentState extends State<CanlenderComponent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          TableCalendar(
            locale: 'vi_VN',
            rowHeight: 35,
            headerStyle:
                HeaderStyle(formatButtonVisible: false, titleCentered: true),
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) => isSameDay(day, today),
            onDaySelected: _onDateSelected,
            firstDay: DateTime.utc(
                DateTime.now().year, DateTime.now().month, DateTime.now().day),
            lastDay: DateTime.utc(
                DateTime.now().year + 1,
                DateTime.now().month,
                ((DateTime.now().month == 2) &&
                        ((DateTime.now().year % 4) == 0))
                    ? 29
                    : ((DateTime.now().month == 2) &&
                            ((DateTime.now().year % 4) != 0))
                        ? 28
                        : ((DateTime.now().month == 4) ||
                                (DateTime.now().month == 6) ||
                                (DateTime.now().month == 9) ||
                                (DateTime.now().month == 11))
                            ? 30
                            : 31),
            focusedDay: today,
            startingDayOfWeek: StartingDayOfWeek.monday,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 6,
            decoration: const BoxDecoration(color: divince),
          ),
          isSelected
              ? SizedBox(
                  height: 600,
                  child: FutureBuilder<List<ContactDetail>>(
                    future: fetchScheduleInWeek(today.toString().split(" ")[0],
                        today.toString().split(" ")[0]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Circular();
                      }
                      if (snapshot.hasData) {
                        List<ContactDetail> schedule = snapshot.data!
                            .where((element) =>
                                element.contactModel!.status == 'WORKING')
                            .toList();
                        if (snapshot.data == null) {
                          return const Center(
                            child: Text(
                              'Không có kết quả để hiển thị',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          );
                        } else if (schedule == null) {
                          return const Center(
                            child: Text(
                              'Chưa có hợp đồng đang hot động',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          );
                        }
                        if (count == 0) {
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                List days_list = (schedule[index]
                                    .timeWorking
                                    .toString()
                                    .split(", "));
                                for (int i = 0; i < days_list.length; i++) {
                                  if (days_list[i] ==
                                      getWeekday(today.weekday)) {
                                    count++;

                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Card(
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                top: 5, left: 10, right: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      '${schedule[index].contactModel!.title} - ',
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                      schedule[index]
                                                          .serviceModel!
                                                          .name
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                _contractFiled2(
                                                    'Khách hàng',
                                                    schedule[index]
                                                        .contactModel!
                                                        .fullName
                                                        .toString()),
                                                _contractFiled2(
                                                    'Địa chỉ',
                                                    schedule[index]
                                                        .contactModel!
                                                        .address
                                                        .toString()),
                                                _contractFiled2(
                                                    'Điện thoại',
                                                    schedule[index]
                                                        .contactModel!
                                                        .phone
                                                        .toString()),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 6,
                                          decoration: const BoxDecoration(
                                              color: divince),
                                        ),
                                      ],
                                    );
                                  }
                                }
                                return const SizedBox();
                              },
                              itemCount: schedule.length);
                        } else if (count > 0) {
                          return const Center(
                            child: Text(
                              'Hôm nay không có lịch làm việc',
                              style: TextStyle(fontSize: 16),
                            ),
                          );
                        }
                      }
                      return const Center(
                        child: Text('Lỗi'),
                      );
                    },
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  var count = 0;
  Future<void> _onDateSelected(DateTime day, DateTime focusedDay) async {
    setState(() {
      today = day;
      isSelected = true;
    });
  }

  Widget _contractFiled2(String title, String des) {
    return Column(
      children: [
        Row(
          children: [
            Text('$title: ',
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
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
