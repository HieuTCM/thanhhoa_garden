abstract class ServiceEvent {
  String? serviceID;

  String? get id => serviceID;
}

class GetAllServiceEvent extends ServiceEvent {}

class GetByIDServiceEvent extends ServiceEvent {
  GetByIDServiceEvent({String? serviceID}) : super();
}
