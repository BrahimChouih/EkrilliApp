import 'package:dio/dio.dart';
import 'package:ekrilli_app/controllers/pagination_controller.dart';
import 'package:ekrilli_app/models/rating.dart';
import 'package:ekrilli_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/api/api.dart';
import '../data/repositories/rating_repository.dart';
import '../models/house.dart';
import '../models/offer.dart';
import 'messages_controller.dart';

class RatingController extends PaginationController with RatingRepository {
  List<Rating> ratings = [];
  Parameters? parameters;
  bool canRate = false;
  bool isChecking = false;

  final String rateWidgetId = 'rateWidgetId';

  bool get isEmpty => ratings.isEmpty;

  @override
  Future<void> getData({required int page, Parameters? parameters}) async {
    // changeLoadingState(true);

    List<Rating>? resualt = await super.getHouseRatings(
      houseId: parameters!.offer!.house.id!,
      page: page,
    );

    ratings.addAll(resualt ?? []);

    // changeLoadingState(false);
  }

  @override
  Future<void> initData({Parameters? parameters}) async {
    List<Rating>? resualt = await super.getHouseRatings(
      houseId: parameters!.offer!.house.id!,
    );
    ratings = resualt ?? [];
  }

  @override
  Future<Rating?> ratingOnHouse({required Rating rating}) async {
    isLoading = true;
    update([rateWidgetId]);
    Rating? resualt;

    try {
      resualt = await super.ratingOnHouse(rating: rating);

      MessagesController messagesController = Get.find<MessagesController>();
      messagesController.parameters!.offer!.rated = true;
      await messagesController.initData(
        parameters: messagesController.parameters,
      );
      messagesController.changeLoadingState(false);
    } on DioError catch (e) {
      Get.snackbar(
        '',
        '',
        messageText: Text((e.response ?? '').toString()),
        titleText: const SizedBox(),
      );
    }

    isLoading = false;
    update([rateWidgetId]);
    return resualt;
  }
}
