import 'package:ekrilli_app/data/repositories/chat_repository.dart';
import 'package:ekrilli_app/models/municipality.dart';
import 'package:ekrilli_app/models/offer.dart';
import 'package:ekrilli_app/models/user.dart';
import 'package:get/get.dart';

import '../data/api/api.dart';
import '../models/city.dart';
import '../models/house.dart';
import '../models/picture.dart';

class ChatController extends GetxController with ChatRepository {
  List<Offer> offers = [
    Offer(
      house: House(
        owner: User(username: 'Brahim CHOUIH'),
        title: 'Come to titree',
        municipality: Municipality(
          name: 'Ouled Bouachra',
          city: City(name: 'Medea'),
        ),
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

            /// firebase
            // picture:
            //     'https://firebasestorage.googleapis.com/v0/b/fir-project-be9a2.appspot.com/o/Come_to_Titree_2022-03-29-105836.813969.jpg?alt=media&token=07e17d5d-c5c5-4041-955c-5f96e38ce7f8',
          ),
          Picture(
            picture:
                '$api/media/houses/Come_to_Titree_2022-03-29-105846.882861.jpg',

            /// firebase
            // picture:
            //     'https://firebasestorage.googleapis.com/v0/b/fir-project-be9a2.appspot.com/o/Come_to_Titree_2022-03-29-105846.882861.jpg?alt=media&token=91d77bf7-f999-4303-a379-e122794d857c',
          ),
        ],
      ),
    ),
  ];

  bool get isEmpty => offers.isEmpty;
}
