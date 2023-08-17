import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thanhhoa_garden/blocs/notification/notiBloc.dart';
import 'package:thanhhoa_garden/blocs/notification/notiEvent.dart';
import 'package:thanhhoa_garden/blocs/notification/notiState.dart';
import 'package:thanhhoa_garden/components/appBar.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/notification/notification.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationBloc notificationBloc;
  late Stream<NotificationState> notificationStream;

  @override
  void initState() {
    // TODO: implement initState
    notificationBloc = Provider.of<NotificationBloc>(context, listen: false);
    notificationStream = notificationBloc.notificationStream;
    notificationBloc.send(GetAllNotificationEvent());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    notificationBloc.dispose();
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
                    title: 'Thông Báo',
                    tail: IconButton(
                      icon: Icon(Icons.checklist_rtl_outlined),
                      color: buttonColor,
                      iconSize: 40,
                      onPressed: () {
                        notificationBloc.send(CheckAllNotificationEvent());
                      },
                    )),
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
                Expanded(child: _notiList()),
              ]))),
    );
  }

  Widget _notiList() {
    return StreamBuilder<NotificationState>(
      stream: notificationStream,
      initialData: NotificationInitial(),
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state is NotificationLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ListNotificationSuccess) {
          List<NotificationModel> list = [...state.listNotification!];
          return list.isEmpty
              ? const Center(
                  child: Text('Không có thông báo'),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const ScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return _notiTab(list[index]);
                  },
                );
        } else if (state is NotificationFailure) {
          return Text(state.errorMessage);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _notiTab(NotificationModel model) {
    var size = MediaQuery.of(context).size;
    return Container(
      constraints: const BoxConstraints(minHeight: 70),
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          border: Border.all(color: buttonColor, width: 3.0),
          color: model.isRead ? Colors.white : barColor),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: size.width - 46,
              child: AutoSizeText(model.title),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            SizedBox(
              width: size.width - 46,
              child: AutoSizeText(model.description),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              alignment: Alignment.centerRight,
              width: size.width - 46,
              child: AutoSizeText(getDate(model.date)),
            )
          ],
        )
      ]),
    );
  }
}
