import 'dart:async';

import 'package:thanhhoa_garden/blocs/feedback/feedback_event.dart';
import 'package:thanhhoa_garden/blocs/feedback/feedback_state.dart';
import 'package:thanhhoa_garden/providers/feedback/feedback_provider.dart';

class FeedbackBloc {
  final FeedbackProvider _feedbackProvider;
  final StreamController<FeedbackState> _feedbackStateController =
      StreamController<FeedbackState>();

  Stream<FeedbackState> get feedbackStateStream =>
      _feedbackStateController.stream.asBroadcastStream();
  StreamController<FeedbackState> get feedbackStateController =>
      _feedbackStateController;

  FeedbackBloc({required FeedbackProvider feedbackProvider})
      : _feedbackProvider = feedbackProvider {
    _feedbackStateController.add(FeedbackInitial());
  }

  void send(FeedbackEvent event) async {
    switch (event.runtimeType) {
      case GetAllFeedbackEvent:
        _feedbackStateController.add(FeedbackLoading());
        await _feedbackProvider.getAllFeedback().then((value) {
          if (value) {
            final listFeedback = _feedbackProvider.listFeedback;
            _feedbackStateController
                .add(ListFeedbackSuccess(listFeedback: listFeedback));
          } else {
            _feedbackStateController
                .add(FeedbackFailure(errorMessage: 'Get Feedback List Failed'));
          }
        });
        break;
    }
  }

  void dispose() {
    _feedbackStateController.close();
  }
}
