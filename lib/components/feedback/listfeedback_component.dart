import 'dart:ffi';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/feedback/feedback.dart';

class ListFeebback extends StatefulWidget {
  List<FeedbackModel> listData;
  String? wherecall;
  ListFeebback({super.key, required this.listData, this.wherecall});

  @override
  State<ListFeebback> createState() => _ListFeebbackState();
}

class _ListFeebbackState extends State<ListFeebback> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<FeedbackModel> listFeedback = widget.listData;
    return ListView.builder(
      physics: (widget.wherecall != null)
          ? const ScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: listFeedback.length,
      itemBuilder: (context, index) {
        return _FeedbackTab(listFeedback[index]);
      },
    );
  }

  Widget _FeedbackTab(FeedbackModel feedback) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
            height: 130,
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(feedback.imgurl))),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 275,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 145,
                            child: AutoSizeText(
                              feedback.name_creater,
                              maxLines: 1,
                              style: const TextStyle(
                                  color: darkText,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ),
                          const Spacer(),
                          for (int i = 0; i < int.parse(feedback.rating); i++)
                            const Icon(Icons.star, color: Colors.yellow),
                          for (int i = 0;
                              i < 5 - int.parse(feedback.rating);
                              i++)
                            const Icon(Icons.star_border_outlined,
                                color: Colors.yellow),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 275,
                          child: AutoSizeText(
                            feedback.description.toString().substring(
                                0,
                                (feedback.description.toString().length >= 100)
                                    ? 100
                                    : feedback.description.toString().length),
                            maxLines: 3,
                            style:
                                const TextStyle(color: darkText, fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          feedback.create_date,
                          maxLines: 1,
                          style: const TextStyle(
                              color: darkText,
                              // fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ],
                    )
                  ],
                )
              ],
            )),
        Center(
          child: Container(
            // margin: const EdgeInsets.all(8),
            height: 1.5,
            width: size.width,
            decoration: const BoxDecoration(color: divince),
          ),
        ),
      ],
    );
  }
}
