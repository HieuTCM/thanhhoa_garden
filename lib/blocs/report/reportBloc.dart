import 'dart:async';

import 'package:thanhhoa_garden/blocs/report/reportEvent.dart';
import 'package:thanhhoa_garden/blocs/report/reportState.dart';
import 'package:thanhhoa_garden/providers/report/report_provider.dart';

class ReportBloc {
  final ReportProvider _reportProvider;

  final StreamController<ReportState> _reportStateController =
      StreamController<ReportState>();

  Stream<ReportState> get reportStream =>
      _reportStateController.stream.asBroadcastStream();

  StreamController get notificationContronller => _reportStateController;

  ReportBloc({required ReportProvider reportProvider})
      : _reportProvider = reportProvider {
    _reportStateController.add(ReportInitial());
  }

  void send(ReportEvent event) async {
    switch (event.runtimeType) {
      case GetAllReportEvent:
        _reportStateController.add(ReportLoading());

        await _reportProvider.getAllReport().then((value) {
          if (value) {
            final listNoti = _reportProvider.list;

            _reportStateController.add(ListReportSuccess(listReport: listNoti));
          } else {
            _reportStateController
                .add(ReportFailure(errorMessage: 'Không tìm thấy thông báo'));
          }
        });
        break;
    }
  }

  void dispose() {
    _reportStateController.close();
  }
}
