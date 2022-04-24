import 'package:dio/dio.dart';
import 'package:ekrilli_app/data/api/rating_api.dart';
import 'package:ekrilli_app/models/rating.dart';

class RatingRepository {
  RatingAPI ratingAPI = RatingAPI();

  Future<List<Rating>?> getHouseRatings({
    required int houseId,
    int page = 1,
  }) async {
    List<Map<String, dynamic>>? data = await ratingAPI.getHouseRatings(
      houseId: houseId,
      page: 1,
    );
    List<Rating> ratings = [];
    data?.forEach((element) {
      ratings.add(Rating.fromJson(element));
    });

    return ratings;
  }

  Future<Rating?> ratingOnHouse({
    required Rating rating,
  }) async {
    FormData data = FormData.fromMap(rating.toJson());
    Map<String, dynamic>? responseData = await ratingAPI.ratingOnHouse(
      data: data,
    );
    if (responseData != null) {
      Rating responseRating = Rating.fromJson(responseData);
      return responseRating;
    }
  }
}
