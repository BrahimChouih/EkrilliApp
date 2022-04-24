import 'package:dio/dio.dart';
import 'api.dart';

class FavoriteAPI {
  Future<List<Map<String, dynamic>>?> getFavorites() async {
    String apiUrl = '$api/api/favorites/';

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
    return [...response.data];
  }

  Future<Map<String, dynamic>?> addFavorite(int houseId) async {
    String apiUrl = '$api/api/favorites/';

    Response response = await dio
        .post(
      apiUrl,
      data: {'house': houseId},
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

  Future<Response> deleteFavoriteItem(int favoriteId) async {
    String apiUrl = '$api/api/favorites/$favoriteId/';

    Response response = await dio
        .delete(
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
    return response;
  }
}
