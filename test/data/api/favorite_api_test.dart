import 'package:dio/dio.dart';
import 'package:ekrilli_app/data/api/favorite_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('FavoriteAPI get favorites', () async {
    //// get instence
    FavoriteAPI favoriteAPI = FavoriteAPI();

    ///// get all favorite
    List<Map<String, dynamic>>? data = await favoriteAPI.getFavorites();
    // print(data);
    expect(data != null, true);
  });

  test('FavoriteAPI add favorite', () async {
    //// get instence
    FavoriteAPI favoriteAPI = FavoriteAPI();

    ///// add favorite
    try {
      Map<String, dynamic>? data = await favoriteAPI.addFavorite(200);
      print(data);
      expect(data?.length != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, 400);
    }
  });

  test('FavoriteAPI delete favorite', () async {
    //// get instence
    FavoriteAPI favoriteAPI = FavoriteAPI();

    ///// add favorite
    try {
      Map<String, dynamic>? data = await favoriteAPI.deleteFavoriteItem(13);
      print(data);
      expect(data?.length != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, anyOf(404, 400));
    }
  });
}
