import 'package:dio/dio.dart';
import 'package:ekrilli_app/data/api/api.dart';

class APIRating {
  Future<List<Map<String, dynamic>>?> getHouseRatings({
    required int houseId,
    int page = 1,
  }) async {
    String apiUrl = '$api/api/ratings-of-house/$houseId/?page=$page';

    Response response = await dio
        .get(
      apiUrl,
      options: options,
    )
        .onError<DioError>(
      (error, stackTrace) {
        throw error;
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response);
    }
    return [...response.data['results']];
  }

  Future<Map<String, dynamic>?> ratingOnHouse({
    required FormData data,
  }) async {
    String apiUrl = '$api/api/rating-on-house/';

    Response response = await dio
        .post(
      apiUrl,
      data: data,
      options: options,
    )
        .onError<DioError>(
      (error, stackTrace) {
        throw error;
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response);
    }
    return response.data;
  }
}
