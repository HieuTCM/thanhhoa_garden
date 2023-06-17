import 'package:thanhhoa_garden/models/bonsai/bonsai.dart';

abstract class BonsaiState {}

class BonsaiInitial extends BonsaiState {}

class BonsaiLoading extends BonsaiState {}

class ListBonsaiSuccess extends BonsaiState {
  final List<Bonsai>? listBonsai;
  ListBonsaiSuccess({required this.listBonsai});
}

class BonsaiSuccess extends BonsaiState {
  final Bonsai? bonsai;
  BonsaiSuccess({required this.bonsai});
}

class BonsaiFailure extends BonsaiState {
  final String errorMessage;
  BonsaiFailure({required this.errorMessage});
}
