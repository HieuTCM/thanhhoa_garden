import 'package:thanhhoa_garden/models/bonsai/bonsai.dart';

abstract class BonsaiEvent {
  String? _id;
  String? get id => _id;

  String? _plantName;
  String? get plantName => _plantName;

  String? _categoryID;
  String? get categoryID => _categoryID;

  double? _min;
  double? get min => _min;

  double? _max;
  double? get max => _max;

  int? _pageNo;
  int? get pageNo => _pageNo;

  int? _pageSize;
  int? get pageSize => _pageSize;

  String? _sortBy;
  String? get sortBy => _sortBy;

  bool? _sortAsc;
  bool? get sortAsc => _sortAsc;

  List<Bonsai>? _listBonsai;
  List<Bonsai>? get listBonsai => _listBonsai;
}

class GetAllBonsaiEvent extends BonsaiEvent {
  String? plantName;
  String? categoryID;
  double? min;
  double? max;
  int pageNo;
  int pageSize;
  String sortBy;
  bool sortAsc;
  List<Bonsai> listBonsai;

  GetAllBonsaiEvent(
      {this.plantName,
      this.categoryID,
      this.min,
      this.max,
      required this.pageNo,
      required this.pageSize,
      required this.sortBy,
      required this.sortAsc,
      required this.listBonsai})
      : super();
}

class GetByIDBonsaiEvent extends BonsaiEvent {
  @override
  String? id;
  GetByIDBonsaiEvent({this.id}) : super();
}
