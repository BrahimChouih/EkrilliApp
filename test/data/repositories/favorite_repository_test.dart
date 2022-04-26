import 'package:dio/dio.dart';
import 'package:ekrilli_app/data/repositories/favorite_repository.dart';
import 'package:ekrilli_app/models/favorite.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('FavoriteRepository get favorites', () async {
    //// get instence
    FavoriteRepository favoriteRepository = FavoriteRepository();

    //// get favorites
    List<Favorite>? data = await favoriteRepository.getFavorites();
    print('allRatings.length: ${data?.length}');
  });

  test('FavoriteRepository add an item', () async {
    //// get instence
    FavoriteRepository favoriteRepository = FavoriteRepository();

    ///// add new item
    try {
      Favorite? data = await favoriteRepository.addFavorite(1);
      print(data?.toJson());
      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, anyOf(404, 400));
    }
  });

  test('FavoriteRepository Delete an item', () async {
    //// get instence
    FavoriteRepository favoriteRepository = FavoriteRepository();

    ///// delete an item
    try {
      bool? data = await favoriteRepository.deleteFavoriteItem(16);
      print(data);
      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, anyOf(404, 400));
    }
  });
}
