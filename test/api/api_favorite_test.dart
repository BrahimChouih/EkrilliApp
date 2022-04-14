import 'package:ekrilli_app/api/api_favorite.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('APIFavorite get favorites', () async {
    //// get instence
    APIFavorite apiFavorite = APIFavorite();

    ///// get all favorite
    List<Map<String, dynamic>>? data = await apiFavorite.getFavorites();
    // print(data);
    expect(data?.length != null, true);
  });

  test('APIFavorite add favorite', () async {
    //// get instence
    APIFavorite apiFavorite = APIFavorite();

    ///// add favorite
    Map<String, dynamic>? data = await apiFavorite.addFavorite(1);
    print(data);
    expect(data?.length != null, true);
  });

  test('APIFavorite delete favorite', () async {
    //// get instence
    APIFavorite apiFavorite = APIFavorite();

    ///// add favorite
    Map<String, dynamic>? data = await apiFavorite.deleteFavoriteItem(12);
    print(data);
    expect(data?.length != null, true);
  });
}
