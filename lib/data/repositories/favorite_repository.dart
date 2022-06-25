import 'package:dio/dio.dart';
import 'package:ekrilli_app/data/api/favorite_api.dart';
import 'package:ekrilli_app/models/favorite.dart';

class FavoriteRepository {
  FavoriteAPI favoriteAPI = FavoriteAPI();

  Future<List<Favorite>?> getFavorites() async {
    List<Map<String, dynamic>>? data = await favoriteAPI.getFavorites();
    List<Favorite> favorites = [];
    data?.forEach((element) {
      favorites.add(Favorite.fromJson(element));
    });

    return favorites;
  }

  Future<Favorite?> addFavorite(int offerId) async {
    Map<String, dynamic>? responseData = await favoriteAPI.addFavorite(offerId);
    if (responseData != null) {
      Favorite responseFavorite = Favorite.fromJson(responseData);
      return responseFavorite;
    }
  }

  Future<bool?> deleteFavoriteItem(int favoriteId) async {
    Response? response = await favoriteAPI.deleteFavoriteItem(favoriteId);
    return response.statusCode == 200 || response.statusCode == 201;
  }
}
