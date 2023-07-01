import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:thanhhoa_garden/models/bonsaiImg.dart';
import 'package:thanhhoa_garden/models/feedback/feedback.dart';

class FeedbackProvider extends ChangeNotifier {
  FeedbackModel? _feedback;
  List<FeedbackModel>? _listFeedback;

  FeedbackModel? get feedback => _feedback;
  List<FeedbackModel>? get listFeedback => _listFeedback;

  Future<bool> getAllFeedback() async {
    bool result = false;
    List<FeedbackModel> list = [];
    int status = 404;
    try {
      // Simulate an asynchronous API call
      await Future.delayed(const Duration(seconds: 2))
          .then((value) => {status = 200});
      if (status == 200) {
        if (feedbackList.isNotEmpty) {
          for (var data in feedbackList) {
            List<ImageURL> listImg = [];
            var imgData = data["listImg"];
            if (imgData is List) {
              for (var img in imgData) {
                listImg.add(ImageURL.fromJson(img));
              }
            }
            _feedback = FeedbackModel.fromJson(data, listImg);
            list.add(_feedback!);
          }
        }
        _listFeedback = list;
        result = true;
        notifyListeners();
      } else {
        result = false;
        notifyListeners();
      }
    } on HttpException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    return result;
  }
}
