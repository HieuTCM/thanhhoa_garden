import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:thanhhoa_garden/components/appBar.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thanhhoa_garden/models/feedback/feedback.dart';
import 'package:thanhhoa_garden/providers/feedback/feedback_provider.dart';
import 'package:thanhhoa_garden/providers/img_provider.dart';
import 'package:thanhhoa_garden/screens/feedback/listFeedbackScreen.dart';

class FeedbackScreen extends StatefulWidget {
  final String orderrDetailID;
  final String plantID;
  FeedbackScreen(
      {super.key, required this.orderrDetailID, required this.plantID});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  FeedbackProvider feedbackProvider = FeedbackProvider();

  int score = 5;
  TextEditingController _messageFeedback = TextEditingController();
  final ImagePicker picker = ImagePicker();
  List<Rating> _listRating = [];
  Rating rating = Rating(id: 'RT005', description: '5.0');
  @override
  void initState() {
    // TODO: implement initState
    getRating();
    super.initState();
  }

  getRating() {
    feedbackProvider.getRating().then((value) {
      setState(() {
        _listRating = feedbackProvider.listRating!;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: [
          SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 35,
              ),
              AppBarWiget(
                title: 'Đánh giá',
              ),
              Center(
                child: Container(
                  height: 1,
                  width: 250,
                  decoration: const BoxDecoration(color: buttonColor),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    'Bạn hài lòng về Thanh Hoa chứ? Hãy cho chúng tôi biết ý kiến của bạn.'),
              ),
              Container(
                height: 10,
                decoration: const BoxDecoration(color: divince),
              ),
              (_listRating.isNotEmpty)
                  ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 140,
                            child: AutoSizeText(
                              scoreFeedback(score),
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                          for (int i = 0; i < score; i++)
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    score = i + 1;
                                    rating = _listRating[score - 1];
                                  });
                                },
                                icon: const Icon(Icons.star,
                                    color: Colors.yellow, size: 35)),
                          for (int i = 0; i < 5 - score; i++)
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    score = score + i + 1;
                                    rating = _listRating[score - 1];
                                  });
                                },
                                icon: const Icon(Icons.star_border_outlined,
                                    color: Colors.yellow, size: 35)),
                        ],
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
              TextFormField(
                controller: _messageFeedback,
                maxLength: 150,
                minLines: 6,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                  labelText: 'Để lại đánh giá của bạn',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 10,
                decoration: const BoxDecoration(color: divince),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      const Text(
                        'Thêm hình ảnh',
                        style: TextStyle(fontSize: 20),
                      ),
                      const Spacer(),
                      Text(
                        '${imgURL.length}/5',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  )),
              SizedBox(
                width: size.width,
                height: 300,
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () async {
                          (listFile.length >= 5)
                              ? Fluttertoast.showToast(
                                  msg: "Bạn đã chọn đủ 5 hình",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: buttonColor,
                                  textColor: Colors.white,
                                  fontSize: 16.0)
                              : _pickImage(ImageSource.gallery);
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              border: Border.all(
                                color: buttonColor,
                                width: 2,
                              )),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: buttonColor,
                            size: 100,
                          ),
                        ),
                      ),
                    ),
                    for (int i = 0; i < listFile.length; i++)
                      GridTile(
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              width: 120,
                              height: 120,
                              child: Image.file(listFile[i], fit: BoxFit.fill),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    listFile.removeAt(i);
                                    imgURL.removeAt(i);
                                  });
                                },
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: HintIcon.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: const Text(
                                    'X',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          )),
          Positioned(
              bottom: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  Map<String, dynamic> json = {};
                  json['description'] = _messageFeedback.text;
                  json['plantID'] = widget.plantID;
                  json['ratingID'] = rating.id;
                  json['orderDetailID'] = widget.orderrDetailID;
                  json['listURL'] = imgURL;
                  OverlayLoadingProgress.start(context);
                  feedbackProvider.createFeedback(json).then((value) {
                    if (value) {
                      Fluttertoast.showToast(
                          msg: "Đã gửi đánh giá",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const ListFeedbackScreen(),
                      ));
                      OverlayLoadingProgress.stop();
                    } else {
                      Fluttertoast.showToast(
                          msg: "Gữi đánh giá thất bại",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  });
                },
                child: Container(
                    alignment: Alignment.center,
                    width: 100,
                    height: 45,
                    decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: const Text(
                      'Gửi',
                      style: TextStyle(
                          color: lightText,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
              ))
        ],
      ),
    );
  }

  List<String> imgURL = [];
  List<File> listFile = [];
  Future _pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    // final image = await ImagePicker().pickMedia();
    if (image == null) return;
    File? img = File(image.path);
    OverlayLoadingProgress.start(context);
    ImgProvider().upload(img).then((value) {
      setState(() {
        imgURL.add(value);
        listFile.add(img);
      });
      OverlayLoadingProgress.stop();
    });

    // ImgProvider().upload(img);
  }
}
