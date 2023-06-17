abstract class CategoryEvent {
  // String? _id;

  // String? get id => _id;
}

class GetAllCategoryEvent extends CategoryEvent {}

class GetByIDCategoryEvent extends CategoryEvent {
  @override
  String? id;
  GetByIDCategoryEvent({this.id}) : super();
}
