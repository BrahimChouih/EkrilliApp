import 'package:ekrilli_app/models/house.dart';
import 'package:get/get.dart';
import '../data/api/api.dart';
import '../data/repositories/house_repository.dart';
import '../models/city.dart';
import '../models/picture.dart';
import '../models/user.dart';

class HouseController extends GetxController with HouseRepository {
  List<House> houses = [
    House(
      owner: User(
        username: 'Brahim CHOUIH',
        picture: '$api/media/users/5_pictuer_2022-04-29-150027.864713.png',

        /// firebase
        // picture:
        //     'https://firebasestorage.googleapis.com/v0/b/fir-project-be9a2.appspot.com/o/5_pictuer_2022-04-29-150027.864713.png?alt=media&token=dd6fa134-042a-4ef0-90bb-bb7cdf97af85',
      ),
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
  ];

  bool get isEmpty => houses.isEmpty;
}
