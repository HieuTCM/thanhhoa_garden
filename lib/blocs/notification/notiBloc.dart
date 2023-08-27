import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:thanhhoa_garden/blocs/notification/notiEvent.dart';
import 'package:thanhhoa_garden/blocs/notification/notiState.dart';
import 'package:thanhhoa_garden/providers/notification/notification_Provider.dart';

class NotificationBloc {
  final NotificationProvider _notificationProvider;

  final StreamController<NotificationState> _notiStateController =
      StreamController<NotificationState>();

  Stream<NotificationState> get notificationStream =>
      _notiStateController.stream.asBroadcastStream();

  StreamController get notificationContronller => _notiStateController;

  NotificationBloc({required NotificationProvider notificationProvider})
      : _notificationProvider = notificationProvider {
    _notiStateController.add(NotificationInitial());
  }

  NotificationBloc._internal(this._notificationProvider);

  static final NotificationBloc instance =
      NotificationBloc._internal(NotificationProvider());

  void send(NotificationEvent event) async {
    switch (event.runtimeType) {
      case GetAllNotificationEvent:
        _notiStateController.add(NotificationLoading());

        await _notificationProvider.getAllNotification().then((value) {
          if (value) {
            final listNoti = _notificationProvider.list;
            final count = _notificationProvider.countNotRead;
            _notiStateController
                .add(ListNotificationSuccess(listNotification: listNoti));
          } else {
            _notiStateController.add(
                NotificationFailure(errorMessage: 'Không tìm thấy thông báo'));
          }
        });
        break;
      case CheckAllNotificationEvent:
        // _notiStateController.add(NotificationLoading());

        await _notificationProvider.checkAllNotification().then((value) {
          if (value) {
            final listNoti = _notificationProvider.list;
            _notiStateController
                .add(ListNotificationSuccess(listNotification: listNoti));
            OverlayLoadingProgress.stop();
          } else {
            // _notiStateController.add(
            //     NotificationFailure(errorMessage: 'Không tìm thấy thông báo'));
            OverlayLoadingProgress.stop();
            Fluttertoast.showToast(
                msg: "Lỗi hệ thống",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        });
        break;
    }
  }

  void dispose() {
    _notiStateController.close();
  }
}
