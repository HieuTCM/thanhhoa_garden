import 'package:thanhhoa_garden/models/feedback/feedback.dart';

abstract class FeedbackEvent {
  String? _plantID;
  String? get plantID => _plantID;

  int? _pageNo;
  int? get pageNo => _pageNo;

  int? _pageSize;
  int? get pageSize => _pageSize;

  String? _sortBy;
  String? get sortBy => _sortBy;

  bool? _sortAsc;
  bool? get sortAsc => _sortAsc;

  List<FeedbackModel>? _listFeedback;
  List<FeedbackModel>? get listFeedback => _listFeedback;
}

class GetAllFeedbackEventByPlantID extends FeedbackEvent {
  String plantID;
  int pageNo;
  int pageSize;
  String sortBy;
  bool sortAsc;
  List<FeedbackModel> listFeedback;

  GetAllFeedbackEventByPlantID(
      {required this.plantID,
      required this.pageNo,
      required this.pageSize,
      required this.sortBy,
      required this.sortAsc,
      required this.listFeedback})
      : super();
}

class GetAllFeedbackEvent extends FeedbackEvent {
  int pageNo;
  int pageSize;
  String sortBy;
  bool sortAsc;
  List<FeedbackModel> listFeedback;

  GetAllFeedbackEvent(
      {required this.pageNo,
      required this.pageSize,
      required this.sortBy,
      required this.sortAsc,
      required this.listFeedback})
      : super();
}
