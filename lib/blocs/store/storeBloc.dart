import 'dart:async';

import 'package:thanhhoa_garden/blocs/store/storeEvent.dart';
import 'package:thanhhoa_garden/blocs/store/storeState.dart';
import 'package:thanhhoa_garden/providers/store/store_provider.dart';

class StoreBloc {
  final StoreProvider _storeProvider;
  final StreamController<StoreState> _storeStateController =
      StreamController<StoreState>();

  Stream<StoreState> get storeStream =>
      _storeStateController.stream.asBroadcastStream();

  StreamController<StoreState> get StoreStateController =>
      _storeStateController;

  StoreBloc({required StoreProvider storeProvider})
      : _storeProvider = storeProvider {
    _storeStateController.add(StoreInitial());
  }

  void send(StoreEvent event) async {
    switch (event.runtimeType) {
      case GetStore:
        _storeStateController.add(StoreLoading());
        await _storeProvider.getStore().then(
          (value) {
            if (value) {
              final list = _storeProvider.list;
              _storeStateController.add(StoreSuccess(list: list!));
            } else {}
          },
        );
        break;
    }
  }

  void dispose() {
    _storeStateController.close();
  }
}
