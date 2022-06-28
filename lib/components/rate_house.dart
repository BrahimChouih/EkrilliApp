import 'package:ekrilli_app/components/blur_widget.dart';
import 'package:ekrilli_app/components/stars_widget.dart';
import 'package:ekrilli_app/controllers/messages_controller.dart';
import 'package:ekrilli_app/controllers/rating_controller.dart';
import 'package:ekrilli_app/models/rating.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/offer.dart';

class RateHouse extends StatelessWidget {
  RateHouse({required this.offer});
  double stars = 3.5;
  Offer offer;

  TextEditingController commentController = new TextEditingController();

  RatingController ratingController = Get.put(RatingController());

  @override
  Widget build(BuildContext context) {
    ratingController.isLoading = false;
    return BlurWidget(
      child: AlertDialog(
        title: const Text(
          'Rating',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
        content: GetBuilder<RatingController>(
          id: ratingController.rateWidgetId,
          builder: (_) {
            return ratingController.isLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                    ],
                  )
                : SizedBox(
                    width: Get.width * 0.8,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 11),
                        TextField(
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: 'Write your comment here',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          controller: commentController,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            pmButton(Icons.remove),
                            StarsWidget(stars: stars),
                            pmButton(Icons.add),
                          ],
                        ),
                        Text(stars.toString()),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon:
                                  const Icon(Icons.check, color: Colors.green),
                              onPressed: () async {
                                Rating? rating =
                                    await ratingController.ratingOnHouse(
                                  rating: Rating(
                                    comment: commentController.text,
                                    stars: stars,
                                    offer: offer,
                                  ),
                                );
                                if (rating != null) Get.back();
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.red),
                              onPressed: () {
                                Get.back();
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget pmButton(IconData icon) {
    return IconButton(
      icon: Icon(icon),
      onPressed: () {
        if (icon == Icons.add) {
          if (stars < 5) stars += 0.5;
        } else {
          if (stars > 0) stars -= 0.5;
        }
        ratingController.update([ratingController.rateWidgetId]);
      },
    );
  }
}
