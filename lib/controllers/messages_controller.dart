import 'package:ekrilli_app/controllers/auth_controller.dart';
import 'package:ekrilli_app/controllers/pagination_controller.dart';
import 'package:ekrilli_app/data/repositories/chat_repository.dart';
import 'package:ekrilli_app/models/message.dart';
import 'package:get/get.dart';

class MessagesController extends PaginationController with ChatRepository {
  List<Message> messages = [];
  final AuthController authController = Get.find<AuthController>();

  bool get isEmpty => messages.isEmpty;

  bool isMe(Message message) {
    if (message.messageType == 'REQUEST') {
      if (authController.currentUser!.id != message.offer!.house.owner!.id) {
        return true;
      } else {
        return false;
      }
    }
    {
      if (authController.currentUser!.id == message.offer!.house.owner!.id) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  Future<void> getData({required int page, Parameters? parameters}) async {
    // changeLoadingState(true);

    List<Message>? resualt = await super.getConversation(
      userId: parameters!.userId!,
      offerId: parameters.offerId!,
      page: page,
    );

    messages.addAll(resualt ?? []);

    // changeLoadingState(false);
  }

  @override
  Future<void> initData({Parameters? parameters}) async {
    List<Message>? resualt = await super.getConversation(
      userId: parameters!.userId!,
      offerId: parameters.offerId!,
    );
    messages.addAll(resualt ?? []);
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
