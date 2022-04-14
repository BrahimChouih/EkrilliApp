import 'package:dio/dio.dart';

import 'api.dart';

class APIHouse {
  Future<List<Map<String, dynamic>>?> getHouses(
      {int page = 1, int? cityId}) async {
    String apiUrl = '$api/api/houses/';

    if (cityId != null) apiUrl += 'city/$cityId/';

    apiUrl += '?page=$page';

    Response response = await dio
        .get(
      apiUrl,
      options: options,
    )
        .onError<DioError>(
      (error, stackTrace) {
        // print(error.response.data);
        throw error;
      },
    );

    if (response.statusCode != 200) {
      throw Exception(response);
    }
    final List<Map<String, dynamic>> houses = [...response.data['results']];
    return houses;
  }

  //// API Methods: GET , PATCH , DELETE
  Future<Map<String, dynamic>?> houseInfo(
    int houseId, {
    Method method = GET,
    FormData? data,
  }) async {
    String apiUrl = '$api/api/houses/$houseId/';

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
    } else if (method == DELETE) {
      //////////////////////// delete
      response = await dio
          .delete(
        apiUrl,
        options: options,
      )
          .onError<DioError>(
        (error, stackTrace) {
          throw error;
        },
      );
    }
    if (response?.statusCode != 200) {
      throw Exception(response);
    }

    return response?.data;
  }

  Future<Map<String, dynamic>?> createNewHouse(FormData data) async {
    String apiUrl = '$api/api/houses/';

    Response response = await dio
        .post(
      apiUrl,
      data: data,
      options: options,
    )
        .onError<DioError>(
      (error, stackTrace) {
        // print(error.response.data);
        throw error;
      },
    );

    if (response.statusCode != 200) {
      throw Exception(response);
    }

    return response.data;
  }

  Future<List<Map<String, dynamic>>?> getCities() async {
    String apiUrl = '$api/api/cities/';

    Response response = await dio
        .get(
      apiUrl,
      options: options,
    )
        .onError<DioError>(
      (error, stackTrace) {
        // print(error.response.data);
        throw error;
      },
    );

    if (response.statusCode != 200) {
      throw Exception(response);
    }

    return [...response.data];
  }
}
