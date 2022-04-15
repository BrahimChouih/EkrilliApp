import 'package:dio/dio.dart';
import 'package:ekrilli_app/api/api_rating.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('APIRating get house ratings', () async {
    //// get instence
    APIRating apiRating = APIRating();

    ///// get house ratings
    try {
      List<Map<String, dynamic>>? data = await apiRating.getHouseRatings(
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

  test('APIRating rating on house', () async {
    //// get instence
    APIRating apiRating = APIRating();

    ///// create a rate
    try {
      Map<String, dynamic>? data = await apiRating.ratingOnHouse(
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
