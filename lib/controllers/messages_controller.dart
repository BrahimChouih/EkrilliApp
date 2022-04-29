import 'package:ekrilli_app/data/repositories/chat_repository.dart';
import 'package:ekrilli_app/models/message.dart';
import 'package:ekrilli_app/models/offer.dart';
import 'package:get/get.dart';

import '../data/api/api.dart';
import '../models/city.dart';
import '../models/house.dart';
import '../models/picture.dart';
import '../models/user.dart';

class MessagesController extends GetxController with ChatRepository {
  List<Message> messages = [
    Message(
      user: User(id: 2, username: 'test'),
      messageType: 'REQUEST',
      message: 'Hi brahim ,I hope you have a nice day.',
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
    ),
  ];
}
