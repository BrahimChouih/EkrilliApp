import 'package:dio/dio.dart';
import 'package:ekrilli_app/data/api/rating_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('RatingAPI get house ratings', () async {
    //// get instence
    RatingAPI ratingAPI = RatingAPI();

    ///// get house ratings
    try {
      List<Map<String, dynamic>>? data = await ratingAPI.getHouseRatings(
        houseId: 1,
        page: 1,
      );
      print('ratings.length: ${data?.length}');
      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, 404);
    }
  });

  test('RatingAPI rating on house', () async {
    //// get instence
    RatingAPI ratingAPI = RatingAPI();

    ///// create a rate
    try {
      Map<String, dynamic>? data = await ratingAPI.ratingOnHouse(
        data: FormData.fromMap({
          "comment": "greate",
          "stars": 5.0,
          'offer': 2,
        }),
      );
      print(data);
      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, anyOf(404, 400));
    }
  });
}
