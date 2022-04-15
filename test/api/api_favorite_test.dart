import 'package:dio/dio.dart';
import 'package:ekrilli_app/api/api_favorite.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('APIFavorite get favorites', () async {
    //// get instence
    APIFavorite apiFavorite = APIFavorite();

    ///// get all favorite
    List<Map<String, dynamic>>? data = await apiFavorite.getFavorites();
    // print(data);
    expect(data != null, true);
  });

  test('APIFavorite add favorite', () async {
    //// get instence
    APIFavorite apiFavorite = APIFavorite();

    ///// add favorite
    try {
      Map<String, dynamic>? data = await apiFavorite.addFavorite(200);
      print(data);
      expect(data?.length != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, 400);
    }
  });

  test('APIFavorite delete favorite', () async {
    //// get instence
    APIFavorite apiFavorite = APIFavorite();

    ///// add favorite
    try {
      Map<String, dynamic>? data = await apiFavorite.deleteFavoriteItem(13);
      print(data);
      expect(data?.length != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, anyOf(404, 400));
    }
  });
}
