import 'package:ekrilli_app/data/repositories/offer_repository.dart';
import 'package:get/get.dart';

import '../data/api/api.dart';
import '../models/city.dart';
import '../models/house.dart';
import '../models/offer.dart';
import '../models/picture.dart';

class OfferController extends GetxController with OfferRepository {
  List<Offer> offers = [
    Offer(
      house: House(
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
                '$api/media/houses/Come_to_Titree_2022-03-29-105836.813969.jpg',
          ),
          Picture(
            picture:
                '$api/media/houses/Come_to_Titree_2022-03-29-105846.882861.jpg',
          ),
        ],
      ),
    ),
  ];

  bool get isEmpty => offers.isEmpty;
}
