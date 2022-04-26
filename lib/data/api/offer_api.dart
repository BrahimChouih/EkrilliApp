import 'package:dio/dio.dart';
import 'package:ekrilli_app/data/api/api.dart';

class OfferAPI {
  Future<List<Map<String, dynamic>>?> getOffers({
    int page = 1,
    int? cityId,
  }) async {
    String apiUrl = '$api/api/offers/';

    if (cityId != null) apiUrl += 'city/$cityId/';

    apiUrl += '?page=$page';

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

  Future<Map<String, dynamic>?> createOffer(FormData data) async {
    String apiUrl = '$api/api/offers/';

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

  //// API Methods: GET , PATCH
  Future<Map<String, dynamic>?> offerInfo(
    int offerId, {
    Method method = GET,
    FormData? data,
  }) async {
    String apiUrl = '$api/api/offers/$offerId/';

    Response? response;
    if (method == GET) {
      //////////////////////// get data
      response = await dio
          .get(
        apiUrl,
        options: options,
      )
          .onError<DioError>(
        (error, stackTrace) {
          throw error;
        },
      );
    } else if (method == PATCH) {
      //////////////////////// update data
      response = await dio
          .patch(
        apiUrl,
        data: data,
        options: options,
      )
          .onError<DioError>(
        (error, stackTrace) {
          throw error;
        },
      );
    }
    if (response?.statusCode != 200 && response?.statusCode != 201) {
      throw Exception(response);
    }

    return response?.data;
  }

  Future<Map<String, dynamic>?> changeStatus({
    required int offerId,
    required String status,
  }) async {
    String apiUrl = '$api/api/offers/$offerId/';

    Response response = await dio
        .patch(
      apiUrl,
      data: {'status': status},
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
