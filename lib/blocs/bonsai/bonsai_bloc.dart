// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:thanhhoa_garden/blocs/bonsai/bonsai_event.dart';
import 'package:thanhhoa_garden/blocs/bonsai/bonsai_state.dart';
import 'package:thanhhoa_garden/models/bonsai/bonsai.dart';
import 'package:thanhhoa_garden/providers/bonsai/bonsai_provider.dart';

class BonsaiBloc {
  final BonsaiProvider _BonsaiProvider;
  final StreamController<BonsaiState> _BonsaiStateController =
      StreamController<BonsaiState>();

  Stream<BonsaiState> get authStateStream =>
      _BonsaiStateController.stream.asBroadcastStream();
  StreamController<BonsaiState> get authStateController =>
      _BonsaiStateController;

  BonsaiBloc({required BonsaiProvider BonsaiProvider})
      : _BonsaiProvider = BonsaiProvider {
    _BonsaiStateController.add(BonsaiInitial());
  }
  void send(BonsaiEvent event) async {
    switch (event.runtimeType) {
      case GetAllBonsaiEvent:
        if (event.pageNo == 0) {
          _BonsaiStateController.add(BonsaiLoading());
        }
        await _BonsaiProvider.fetchBonsaiList(event).then((value) {
          if (value) {
            final listBonsai = _BonsaiProvider.listBonsai;
            List<Bonsai> fetchBonsaiList = [
              ...event.listBonsai!,
              ...listBonsai!
            ];
            _BonsaiStateController.add(
                ListBonsaiSuccess(listBonsai: fetchBonsaiList));
          } else {
            _BonsaiStateController.add(
                BonsaiFailure(errorMessage: 'Get Bonsai List Failed'));
          }
        });
        break;
      case SearchBonsaiEvent:
        _BonsaiStateController.add(BonsaiLoading());
        await _BonsaiProvider.searchBonsai().then((value) {
          if (value) {
            final listBonsai = _BonsaiProvider.listBonsai;
            _BonsaiStateController.add(
                ListBonsaiSuccess(listBonsai: listBonsai));
          } else {
            _BonsaiStateController.add(
                BonsaiFailure(errorMessage: 'Get Bonsai List Failed'));
          }
        });
        break;
      case GetByIDBonsaiEvent:
        break;
    }
  }

  void dispose() {
    _BonsaiStateController.close();
  }
}
