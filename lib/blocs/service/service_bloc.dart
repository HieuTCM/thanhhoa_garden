import 'dart:async';
import 'package:thanhhoa_garden/blocs/service/service_event.dart';
import 'package:thanhhoa_garden/blocs/service/service_state.dart';

import 'package:thanhhoa_garden/providers/service/service_provider.dart';

class ServiceBloc {
  final ServiceProvider _serviceProvider;
  final StreamController<ServiceState> _serviceStateController =
      StreamController<ServiceState>();

  Stream<ServiceState> get authStateStream =>
      _serviceStateController.stream.asBroadcastStream();
  StreamController<ServiceState> get authStateController =>
      _serviceStateController;

  ServiceBloc({required ServiceProvider serviceProvider})
      : _serviceProvider = serviceProvider {
    _serviceStateController.add(ServiceInitial());
  }

  void send(ServiceEvent event) async {
    switch (event.runtimeType) {
      case GetAllServiceEvent:
        _serviceStateController.add(ServiceLoading());
        await _serviceProvider.getAllService().then((value) {
          if (value) {
            final listService = _serviceProvider.listService;
            _serviceStateController
                .add(ListServiceSuccess(listService: listService));
          } else {
            _serviceStateController
                .add(ServiceFailure(errorMessage: 'Get Service List Failed'));
          }
        });
        break;
      case GetByIDServiceEvent:
        break;
    }
  }

  void dispose() {
    _serviceStateController.close();
  }
}
