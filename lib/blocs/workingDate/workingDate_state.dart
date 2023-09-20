import 'package:thanhhoa_garden/models/workingDate/working_date.dart';

abstract class WorkingDateState {}

class WorkingDateInitial extends WorkingDateState {}

class WorkingDateLoading extends WorkingDateState {}

class ListWorkingDateSuccess extends WorkingDateState {
  final List<WorkingDate>? listWorkingDate;
  ListWorkingDateSuccess({required this.listWorkingDate});
}

class WorkingDateFailure extends WorkingDateState {
  final String errorMessage;
  WorkingDateFailure({required this.errorMessage});
}
