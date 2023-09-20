// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thanhhoa_garden/blocs/feedback/feedback_bloc.dart';
import 'package:thanhhoa_garden/blocs/feedback/feedback_event.dart';
import 'package:thanhhoa_garden/blocs/feedback/feedback_state.dart';
import 'package:thanhhoa_garden/components/appBar.dart';
import 'package:thanhhoa_garden/components/feedback/listfeedback_component.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/feedback/feedback.dart';

class FeedbackPlantScreen extends StatefulWidget {
  String PlantID;
  FeedbackPlantScreen({super.key, required this.PlantID});

  @override
  State<FeedbackPlantScreen> createState() => _FeedbackPlantScreenState();
}

class _FeedbackPlantScreenState extends State<FeedbackPlantScreen> {
  late FeedbackBloc feedbackBloc;

  @override
  void initState() {
    // TODO: implement initState
    feedbackBloc = Provider.of<FeedbackBloc>(context, listen: false);
    feedbackBloc.send(GetAllFeedbackEventByPlantID(
        plantID: widget.PlantID,
        listFeedback: [],
        pageNo: 0,
        pageSize: 10,
        sortBy: 'ID',
        sortAsc: false));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // feedbackBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        body: Column(children: [
          const SizedBox(
            height: 35,
          ),
          AppBarWiget(title: 'Đánh giá cây'),
          _feedback()
        ]));
  }

  Widget _feedback() {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      width: size.width,
      decoration: const BoxDecoration(),
      child: SizedBox(
          // height: 395,
          child: StreamBuilder<FeedbackState>(
              initialData: FeedbackInitial(),
              stream: feedbackBloc.feedbackStateStream,
              builder: (context, snapshot) {
                final state = snapshot.data;
                if (state is FeedbackLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ListFeedbackSuccess) {
                  return state.listFeedback!.isEmpty
                      ? const Center(
                          child: Text('Cây chưa có đánh giá'),
                        )
                      : _listFeedback(state.listFeedback!);
                } else if (state is FeedbackFailure) {
                  return Text(state.errorMessage);
                } else {
                  return Container();
                }
              })),
    );
  }

  Widget _listFeedback(List<FeedbackModel> listFeedback) {
    var size = MediaQuery.of(context).size;
    return Column(children: [
      Row(
        children: [
          const Text(
            'Điểm đánh giá: ',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Icon(Icons.star, color: Colors.yellow, size: 25),
          Text(
            listFeedback[0].avgRatingFeedback.toString(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 5),
          Text(
              '(${listFeedback[0].totalFeedback.toString().split('.')[0]} đánh giá)')
        ],
      ),
      Center(
        child: Container(
          margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
          height: 1.5,
          width: size.width,
          decoration: const BoxDecoration(color: divince),
        ),
      ),
      ListFeebback(
        listData: listFeedback,
      ),
    ]);
  }
}
