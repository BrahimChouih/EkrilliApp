import 'package:ekrilli_app/models/rating.dart';
import 'package:ekrilli_app/models/user.dart';
import 'package:get/get.dart';
import '../data/api/api.dart';
import '../data/repositories/rating_repository.dart';
import '../models/offer.dart';

class RatingController extends GetxController with RatingRepository {
  List<Rating> ratings = [
    Rating(
      offer: Offer(
        user: User(
          username: 'Mohamed Elabass',
          picture: '$api/media/users/6_pictuer_2022-04-29-150204.168265.jpg',
        ),
      ),
      comment: 'It is beatufall house ,I hight recommend it.',
      stars: 5,
    )
  ];

  bool get isEmpty => ratings.isEmpty;
}