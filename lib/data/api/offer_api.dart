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
    int? userId,
    Map<String, dynamic>? offerData,
  }) async {
    String apiUrl = '$api/api/offers/status/$offerId/';

    Map<String, dynamic> data = {
      'status': status,
      'user': userId,
    };
    data.addAll(offerData ?? {});
    Response response = await dio
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

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response);
    }

    return response.data;
  }

  Future<List<Map<String, dynamic>>?> search({
    int page = 1,
    String? search,
    int? cityId,
    String? orderBy,
    bool inversOrdering = false,
  }) async {
    String apiUrl = '$api/api/offers/search/';
    apiUrl += '?page=$page';

    if (search != null) apiUrl += '&search=$search';
    if (cityId != null) apiUrl += '&city=$cityId';
    if (orderBy != null) {
      if (inversOrdering) orderBy = '-' + orderBy;
      apiUrl += '&order_by=$orderBy';
    }

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
}
