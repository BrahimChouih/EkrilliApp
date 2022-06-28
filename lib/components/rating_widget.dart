import 'package:ekrilli_app/components/chat_item.dart';
import 'package:ekrilli_app/components/rating_item.dart';
import 'package:ekrilli_app/components/stars_widget.dart';
import 'package:ekrilli_app/controllers/pagination_controller.dart';
import 'package:ekrilli_app/controllers/rating_controller.dart';
import 'package:ekrilli_app/models/offer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class RatingWidget extends StatefulWidget {
  RatingWidget({
    Key? key,
    required this.offer,
    this.scrollController,
  }) : super(key: key);

  final Offer offer;
  ScrollController? scrollController;

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  RatingController ratingController = Get.put(RatingController());

  Parameters? parameters;

  @override
  void initState() {
    parameters = Parameters(offer: widget.offer);
    ratingController.parameters = parameters;

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 150));
      await ratingController.refreshData(parameters: parameters);
    });
    if (widget.scrollController == null) {
      widget.scrollController = ScrollController();
      widget.scrollController!.addListener(() {
        if ((widget.scrollController!.position.maxScrollExtent * 0.9) <
            widget.scrollController!.position.pixels) {
          ratingController.getNextPage();
        }
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    ratingController.ratings = [];
    widget.scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RatingController>(
      builder: (context) {
        return ratingController.isLoading
            ? const ChatLoader()
            : ratingController.isEmpty
                ? const SizedBox()
                : ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: ratingController.ratings.length,
                    itemBuilder: (BuildContext context, int index) =>
                        RatingItem(
                      rating: ratingController.ratings[index],
                    ),
                  );
      },
    );
  }
}
