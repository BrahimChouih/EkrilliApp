import 'package:ekrilli_app/models/favorite.dart';
import 'package:get/get.dart';
import 'package:ekrilli_app/data/repositories/favorite_repository.dart';

import '../data/api/api.dart';
import '../models/city.dart';
import '../models/house.dart';
import '../models/offer.dart';
import '../models/picture.dart';
import '../models/user.dart';

class FavoriteController extends GetxController with FavoriteRepository {
  List<Favorite> favorites = [
    Favorite(
      offer: Offer(
        house: House(
          owner: User(username: 'Brahim CHOUIH'),
          title: 'Come to titree',
          location: '3ème Boulevard Péripherique',
          city: City(name: 'Oran'),
          rooms: 4,
          kitchens: 1,
          bathrooms: 1,
          bedrooms: 1,
          stars: 23,
          numReviews: 5,
          pictures: [
            Picture(
              picture:
                  '$api/media/houses/Come_to_Titree_2022-03-29-105846.882861.jpg',
            ),
            Picture(
              picture:
                  '$api/media/houses/Come_to_Titree_2022-03-29-105836.813969.jpg',
            ),
          ],
        ),
      ),
    )
  ];

  bool get isEmpty => favorites.isEmpty;
}
