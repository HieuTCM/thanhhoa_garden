import 'package:thanhhoa_garden/models/report/report.dart';

abstract class ReportState {}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

class ListReportSuccess extends ReportState {
  final List<ReportModel>? listReport;
  ListReportSuccess({required this.listReport});
}

class ReportFailure extends ReportState {
  final String errorMessage;
  ReportFailure({required this.errorMessage});
}
