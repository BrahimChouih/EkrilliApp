import 'package:dio/dio.dart';
import 'package:ekrilli_app/data/repositories/rating_repository.dart';
import 'package:ekrilli_app/models/house.dart';
import 'package:ekrilli_app/models/offer.dart';
import 'package:ekrilli_app/models/rating.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('RatingRepository get House Ratings', () async {
    //// get instence
    RatingRepository ratingRepository = RatingRepository();

    //// get House Ratings
    List<Rating>? data = await ratingRepository.getHouseRatings(
      houseId: 1,
    );
    print('allRatings.length: ${data?.length}');
  });

  test('RatingRepository Rating house', () async {
    //// get instence
    RatingRepository ratingRepository = RatingRepository();

    ///// Rating house
    try {
      Rating? data = await ratingRepository.ratingOnHouse(
        rating: Rating(
          offer: Offer(id: 25, house: House()),
          stars: 5.0,
          comment: 'greate',
        ),
      );
      print(data?.toJson());
      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, anyOf(404, 400));
    }
  });
}
