import 'package:thanhhoa_garden/models/store/store.dart';

abstract class StoreState {}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreSuccess extends StoreState {
  List<Store> list;
  StoreSuccess({required this.list});
}

class StoreFailure extends StoreState {
  final String errorMessage;
  StoreFailure({required this.errorMessage});
}
