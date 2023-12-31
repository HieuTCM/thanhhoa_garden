// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thanhhoa_garden/blocs/report/reportBloc.dart';
import 'package:thanhhoa_garden/blocs/report/reportEvent.dart';
import 'package:thanhhoa_garden/blocs/report/reportState.dart';
import 'package:thanhhoa_garden/components/appBar.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/report/report.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  late ReportBloc reportBloc;
  late Stream<ReportState> reporttream;

  @override
  void initState() {
    // TODO: implement initState
    reportBloc = Provider.of<ReportBloc>(context, listen: false);
    reporttream = reportBloc.reportStream;
    reportBloc.send(GetAllReportEvent());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    reportBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: background,
          body: Container(
              height: size.height,
              child: Column(children: [
                const SizedBox(
                  height: 35,
                ),
                //search Bar
                AppBarWiget(
                  title: 'Báo cáo của bạn',
                ),
                const SizedBox(
                  height: 5,
                ),
                Center(
                  child: Container(
                    height: 1,
                    width: 250,
                    decoration: const BoxDecoration(color: buttonColor),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(child: _reportList()),
              ]))),
    );
  }

  Widget _reportList() {
    return StreamBuilder<ReportState>(
      stream: reporttream,
      initialData: ReportInitial(),
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state is ReportLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ListReportSuccess) {
          List<ReportModel> list = [...state.listReport!];
          return list.isEmpty
              ? const Center(
                  child: Text('Bạn chưa gửi báo cáo nào'),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const ScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return _reportTab(list[index]);
                  },
                );
        } else if (state is ReportFailure) {
          return Text(state.errorMessage);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _reportTab(ReportModel model) {
    var size = MediaQuery.of(context).size;
    return Container(
      constraints: const BoxConstraints(minHeight: 70),
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          border: Border.all(color: buttonColor, width: 3.0),
          color: Colors.white),
      child: Column(children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: size.width - 46,
              child: AutoSizeText(
                'Dịch vụ : ' + model.showServiceModel!.name,
                style: const TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        _inforRow('Mã hợp đồng', model.contractID, null),
        _inforRow(
            'Ngày làm việc',
            getDate(model.showWorkingDateModel!.workingDate!).substring(0, 10),
            null),
        _inforRow('Nhân viên', model.showStaffModel!.fullName, null),
        _inforRow('Nội dung', model.description, null),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              alignment: Alignment.centerRight,
              width: size.width - 46,
              child: AutoSizeText(getDate(model.createdDate)),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ]),
    );
  }

  Widget _inforRow(String title, String value, Color? colorValue) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(
            minWidth: size.width,
          ),
          child: Row(
            children: [
              SizedBox(
                width: size.width * 0.3,
                child: AutoSizeText(
                  '$title : ',
                  maxLines: 2,
                  style: const TextStyle(
                      color: darkText,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: size.width - 180,
                child: AutoSizeText(
                  value,
                  maxLines: 4,
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
}
