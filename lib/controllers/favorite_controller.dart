import 'package:ekrilli_app/models/favorite.dart';
import 'package:get/get.dart';
import 'package:ekrilli_app/data/repositories/favorite_repository.dart';

import '../data/api/api.dart';
import '../models/city.dart';
import '../models/house.dart';
import '../models/municipality.dart';
import '../models/offer.dart';
import '../models/picture.dart';
import '../models/user.dart';

class FavoriteController extends GetxController with FavoriteRepository {
  List<Favorite> favorites = [];
  bool isLoading = false;
  final String favoriteIconId = 'favoriteIconId';

  bool get isEmpty => favorites.isEmpty;

  @override
  Future<List<Favorite>?> getFavorites() async {
    changeLoadingState(true);
    try {
      favorites = (await super.getFavorites()) ?? [];
    } catch (e) {
      print(e);
    }

    changeLoadingState(false);
    return favorites;
  }

  @override
  Future<Favorite?> addFavorite(int offerId) async {
    changeLoadingState(true);

    await super.addFavorite(offerId);
    await getFavorites();

    update([favoriteIconId]);
    changeLoadingState(false);
  }

  @override
  Future<bool?> deleteFavoriteItem(int favoriteId) async {
    bool isDeleted = false;

    try {
      isDeleted = (await super.deleteFavoriteItem(favoriteId)) ?? false;
      favorites = (await super.getFavorites()) ?? [];
    } catch (e) {
      print(e);
    }

    update([favoriteIconId]);
    changeLoadingState(false);
    return isDeleted;
  }

  bool contains(int offerId) =>
      favorites.indexWhere((element) => element.offer?.id == offerId) != -1;

  void changeLoadingState(bool state) {
    isLoading = state;
    update();
  }
}

///
///
///
///
///
///
///
///
///
///
///
///
///
// List<Favorite> favoritesData = [
//   Favorite(
//     offer: Offer(
//       house: House(
//         owner: User(
//           username: 'Brahim CHOUIH',
//           picture: '$api/media/users/5_pictuer_2022-04-29-150027.864713.png',

//           /// firebase
//           // picture:
//           //     'https://firebasestorage.googleapis.com/v0/b/fir-project-be9a2.appspot.com/o/5_pictuer_2022-04-29-150027.864713.png?alt=media&token=dd6fa134-042a-4ef0-90bb-bb7cdf97af85',
//         ),
//         title: 'Come to titree',
//         municipality: Municipality(
//           name: 'Ouled Bouachra',
//           city: City(name: 'Medea'),
//         ),
//         rooms: 4,
//         kitchens: 1,
//         bathrooms: 1,
//         bedrooms: 1,
//         stars: 23,
//         numReviews: 5,
//         pictures: [
//           Picture(
//             picture:
//                 '$api/media/houses/Come_to_Titree_2022-03-29-105836.813969.jpg',

//             /// firebase
//             // picture:
//             //     'https://firebasestorage.googleapis.com/v0/b/fir-project-be9a2.appspot.com/o/Come_to_Titree_2022-03-29-105836.813969.jpg?alt=media&token=07e17d5d-c5c5-4041-955c-5f96e38ce7f8',
//           ),
//           Picture(
//             picture:
//                 '$api/media/houses/Come_to_Titree_2022-03-29-105846.882861.jpg',

//             /// firebase
//             // picture:
//             //     'https://firebasestorage.googleapis.com/v0/b/fir-project-be9a2.appspot.com/o/Come_to_Titree_2022-03-29-105846.882861.jpg?alt=media&token=91d77bf7-f999-4303-a379-e122794d857c',
//           ),
//         ],
//       ),
//     ),
//   )
// ];
