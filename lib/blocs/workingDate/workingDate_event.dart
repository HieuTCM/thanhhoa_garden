import 'package:thanhhoa_garden/models/workingDate/working_date.dart';

abstract class WorkingDateEvent {
  String? _contractDetailID;
  String? get contractDetailID => _contractDetailID;

  String? _from;
  String? get from => _from;

  String? _to;
  String? get to => _to;

  List<WorkingDate>? _listWorkingDate;
  List<WorkingDate>? get listWorkingDate => _listWorkingDate;
}

class GetWorkingDate extends WorkingDateEvent {
  String? contractDetailID;
  String from;
  String to;
  List<WorkingDate> listWorkingDate;

  GetWorkingDate(
      {required this.contractDetailID,
      required this.from,
      required this.to,
      required this.listWorkingDate})
      : super();
}
