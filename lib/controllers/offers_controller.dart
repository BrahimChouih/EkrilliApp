import 'package:ekrilli_app/data/repositories/offer_repository.dart';
import 'package:ekrilli_app/models/user.dart';
import 'package:get/get.dart';

import '../data/api/api.dart';
import '../models/city.dart';
import '../models/house.dart';
import '../models/offer.dart';
import '../models/picture.dart';

class OfferController extends GetxController with OfferRepository {
  List<Offer> offers = [
    Offer(
      pricePerDay: 3000,
      house: House(
        title: 'Come to titree',
        location: '3ème Boulevard Péripherique',
        locationLatitude: 36.26417,
        locationLongitude: 2.75393,
        city: City(name: 'Oran'),
        owner: User(
          username: 'Brahim CHOUIH',
          picture: '$api/media/users/5_pictuer_2022-04-29-150027.864713.png',
        ),
        rooms: 4,
        kitchens: 3,
        bathrooms: 2,
        bedrooms: 2,
        stars: 23,
        numReviews: 5,
        description:
            """I'd like to implement a hero animation for an image on my main screen while presenting an AlertDialog widget with the same image in the dialog's content.I'd like the presentation to appear as in the screenshot below. When I tap the image in the bottom left, I'd like the hero animation and an inset preview of the image along with a transparent overlay that can be tapped to dismiss.I'd like to implement a hero animation for an image on my main screen while presenting an AlertDialog widget with the same image in the dialog's content.I'd like the presentation to appear as in the screenshot below. When I tap the image in the bottom left, I'd like the hero animation and an inset preview of the image along with a transparent overlay that can be tapped to dismiss.""",
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
