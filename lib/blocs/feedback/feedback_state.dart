import 'package:thanhhoa_garden/models/feedback/feedback.dart';

abstract class FeedbackState {}

class FeedbackInitial extends FeedbackState {}

class FeedbackLoading extends FeedbackState {}

class ListFeedbackSuccess extends FeedbackState {
  final List<FeedbackModel>? listFeedback;
  ListFeedbackSuccess({required this.listFeedback});
}

class FeedbackFailure extends FeedbackState {
  final String errorMessage;
  FeedbackFailure({required this.errorMessage});
}
