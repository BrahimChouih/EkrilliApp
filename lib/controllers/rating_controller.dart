import 'package:ekrilli_app/models/rating.dart';
import 'package:ekrilli_app/models/user.dart';
import 'package:get/get.dart';
import '../data/api/api.dart';
import '../data/repositories/rating_repository.dart';
import '../models/house.dart';
import '../models/offer.dart';

class RatingController extends GetxController with RatingRepository {
  List<Rating> ratings = [
    Rating(
      offer: Offer(
        house: House(id: 1),
        user: User(
          username: 'Mohamed Elabass',
          picture: '$api/media/users/6_pictuer_2022-04-29-150204.168265.jpg',

          /// firebase
          // picture:
          //     'https://firebasestorage.googleapis.com/v0/b/fir-project-be9a2.appspot.com/o/6_pictuer_2022-04-29-150204.168265.jpg?alt=media&token=613c31b3-8c6b-42b9-9799-44a439bb0654',
        ),
      ),
      comment: 'It is beatufall house ,I hight recommend it.',
      stars: 5,
    )
  ];

  bool get isEmpty => ratings.isEmpty;
}
