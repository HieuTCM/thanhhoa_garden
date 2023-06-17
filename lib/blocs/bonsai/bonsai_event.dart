abstract class BonsaiEvent {
  String? _id;
  String? get id => _id;
}

class GetAllBonsaiEvent extends BonsaiEvent {}

class SearchBonsaiEvent extends BonsaiEvent {}

class GetByIDBonsaiEvent extends BonsaiEvent {
  @override
  String? id;
  GetByIDBonsaiEvent({this.id}) : super();
}
