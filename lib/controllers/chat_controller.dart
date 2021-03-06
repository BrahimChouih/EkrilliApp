import 'package:ekrilli_app/models/chat_item_model.dart';

import '../data/repositories/chat_repository.dart';
import '../models/offer.dart';
import 'package:get/get.dart';

class ChatController extends GetxController with ChatRepository {
  List<ChatItemModel> chatItems = [];
  bool isLoading = false;

  bool get isEmpty => chatItems.isEmpty;

  @override
  Future<List<ChatItemModel>?> getChatItems({bool withWait = true}) async {
    if (withWait) changeLoadingState(true);
    List<ChatItemModel>? resualt = await super.getChatItems();
    chatItems = resualt ?? [];

    changeLoadingState(false);

    return resualt;
  }

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
// List<Offer> offerData = [
//   Offer(
//     house: House(
//       owner: User(username: 'Brahim CHOUIH'),
//       title: 'Come to titree',
//       municipality: Municipality(
//         name: 'Ouled Bouachra',
//         city: City(name: 'Medea'),
//       ),
//       rooms: 4,
//       kitchens: 1,
//       bathrooms: 1,
//       bedrooms: 1,
//       stars: 23,
//       numReviews: 5,
//       pictures: [
//         Picture(
//           picture:
//               '$api/media/houses/Come_to_Titree_2022-03-29-105836.813969.jpg',

//           /// firebase
//           // picture:
//           //     'https://firebasestorage.googleapis.com/v0/b/fir-project-be9a2.appspot.com/o/Come_to_Titree_2022-03-29-105836.813969.jpg?alt=media&token=07e17d5d-c5c5-4041-955c-5f96e38ce7f8',
//         ),
//         Picture(
//           picture:
//               '$api/media/houses/Come_to_Titree_2022-03-29-105846.882861.jpg',

//           /// firebase
//           // picture:
//           //     'https://firebasestorage.googleapis.com/v0/b/fir-project-be9a2.appspot.com/o/Come_to_Titree_2022-03-29-105846.882861.jpg?alt=media&token=91d77bf7-f999-4303-a379-e122794d857c',
//         ),
//       ],
//     ),
//   ),
// ];
