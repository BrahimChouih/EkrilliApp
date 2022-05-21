import 'package:ekrilli_app/controllers/auth_controller.dart';
import 'package:ekrilli_app/controllers/pagination_controller.dart';
import 'package:ekrilli_app/data/repositories/chat_repository.dart';
import 'package:ekrilli_app/models/chat_item_model.dart';
import 'package:ekrilli_app/models/message.dart';
import 'package:ekrilli_app/models/offer.dart';
import 'package:ekrilli_app/models/offer_sended.dart';
import 'package:ekrilli_app/models/user.dart';
import 'package:ekrilli_app/utils/constants.dart';
import 'package:get/get.dart';

import '../models/house.dart';

class MessagesController extends PaginationController with ChatRepository {
  List<Message> messages = [];
  OfferSended? offerSended;
  Parameters? parameters;
  final AuthController authController = Get.find<AuthController>();

  bool get isEmpty => messages.isEmpty;
  final String offerSendedId = 'offerSendedId';

  bool isMe(Message message) {
    if (message.messageType == messageTypeRequest) {
      if (authController.currentUser!.id != message.offer!.house.owner!.id) {
        return true;
      } else {
        return false;
      }
    } else if (message.messageType == messageTypeResponse) {
      if (authController.currentUser!.id == message.offer!.house.owner!.id) {
        return true;
      } else {
        return false;
      }
    }
    return true;
  }

  String messageType(ChatItemModel chatItemModel) {
    if (chatItemModel.offer!.house.owner!.id ==
        authController.currentUser!.id) {
      return messageTypeResponse;
    }
    return messageTypeRequest;
  }

  @override
  Future<Message?> sendMessage({
    required int offerId,
    required int userId,
    required Message message,
  }) async {
    await super.sendMessage(
      offerId: offerId,
      userId: userId,
      message: message,
    );
    await initData(
      parameters: Parameters(
        offer: Offer(id: offerId, house: House()),
        user: User(id: userId),
      ),
    );
    changeLoadingState(false);
  }

  @override
  Future<void> getData({required int page, Parameters? parameters}) async {
    // changeLoadingState(true);

    List<Message>? resualt = await super.getConversation(
      userId: parameters!.user!.id!,
      offerId: parameters.offer!.id!,
      page: page,
    );

    messages.addAll(resualt ?? []);

    // changeLoadingState(false);
  }

  @override
  Future<void> initData({Parameters? parameters}) async {
    List<Message>? resualt = await super.getConversation(
      userId: parameters!.user!.id!,
      offerId: parameters.offer!.id!,
    );
    messages = resualt ?? [];
  }

  Future<void> chatOfferSended({required Parameters parameters}) async {
    offerSended = await super.getChatOfferSended(
      offerId: parameters.offer!.id!,
      userId: parameters.user!.id!,
    );
    update([offerSendedId]);
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
///
// List<Message> messagesData = [
//   Message(
//     user: User(id: 2, username: 'test'),
//     messageType: 'REQUEST',
//     message: 'Hi brahim ,I hope you have a nice day.',
//     offer: Offer(
//       house: House(
//         owner: User(username: 'Brahim CHOUIH'),
//         title: 'Come to titree',
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
//   ),
// ];
