import 'package:thanhhoa_garden/models/service/service.dart';

abstract class ServiceState {}

class ServiceInitial extends ServiceState {}

class ServiceLoading extends ServiceState {}

class ListServiceSuccess extends ServiceState {
  final List<Service>? listService;
  ListServiceSuccess({required this.listService});
}

class ServiceSuccess extends ServiceState {
  final Service? service;
  ServiceSuccess({required this.service});
}

class ServiceFailure extends ServiceState {
  final String errorMessage;
  ServiceFailure({required this.errorMessage});
}
