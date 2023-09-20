import 'dart:async';

import 'package:thanhhoa_garden/blocs/workingDate/workingDate_event.dart';
import 'package:thanhhoa_garden/blocs/workingDate/workingDate_state.dart';
import 'package:thanhhoa_garden/models/workingDate/working_date.dart';
import 'package:thanhhoa_garden/providers/schedule/workingProvider.dart';

class WorkingDateBloc {
  final WorkingDateProvider _WorkingDateProvider;
  final StreamController<WorkingDateState> _WorkingDateStateController =
      StreamController<WorkingDateState>();

  Stream<WorkingDateState> get WorkingDateStateStream =>
      _WorkingDateStateController.stream.asBroadcastStream();
  StreamController<WorkingDateState> get WorkingDateStateController =>
      _WorkingDateStateController;

  WorkingDateBloc({required WorkingDateProvider WorkingDateProvider})
      : _WorkingDateProvider = WorkingDateProvider {
    _WorkingDateStateController.add(WorkingDateInitial());
  }

  void send(WorkingDateEvent event) async {
    switch (event.runtimeType) {
      case GetWorkingDate:
        _WorkingDateStateController.add(WorkingDateLoading());

        await _WorkingDateProvider.getWorkingDate(event).then((value) {
          if (value) {
            var listWorkingDate = _WorkingDateProvider.listWorkingDate;
            _WorkingDateStateController.add(
                ListWorkingDateSuccess(listWorkingDate: listWorkingDate));
          } else {
            _WorkingDateStateController.add(
                WorkingDateFailure(errorMessage: 'Tải lịch làm việc thất bại'));
          }
        });
        break;
    }
  }

  void dispose() {
    _WorkingDateStateController.close();
  }
}
