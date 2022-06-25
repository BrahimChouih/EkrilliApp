import 'package:dio/dio.dart';
import 'package:ekrilli_app/data/repositories/chat_repository.dart';
import 'package:ekrilli_app/models/chat_item_model.dart';
import 'package:ekrilli_app/models/message.dart';
import 'package:ekrilli_app/models/offer.dart';
import 'package:ekrilli_app/models/offer_sended.dart';
import 'package:ekrilli_app/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ChatRepository get Conversation', () async {
    //// get instence
    ChatRepository chatRepository = ChatRepository();

    //// get conversation
    List<Message>? data = await chatRepository.getConversation(
      offerId: 1,
      userId: 2,
    );
    print('allMessage.length: ${data?.length}');
  });

  test('ChatRepository get chat items', () async {
    //// get instence
    ChatRepository chatRepository = ChatRepository();

    ///// get chat items

    List<ChatItemModel>? data = await chatRepository.getChatItems();
    print('offers.length: ${data?.length}');
    expect(data != null, true);
  });

  test('ChatRepository get OfferSended', () async {
    //// get instence
    ChatRepository chatRepository = ChatRepository();

    OfferSended? data = await chatRepository.getChatOfferSended(
      offerId: 1,
      userId: 5,
    );
    print(data?.toJson());
  });

  test('ChatRepository send message', () async {
    //// get instence
    ChatRepository chatRepository = ChatRepository();

    ///// send message
    try {
      Message? data = await chatRepository.sendMessage(
        offerId: 25,
        userId: 2,
        message: Message(
          message: 'hello',
          messageType: 'RESPONSE',
        ),
      );
      print(data?.toJson());
      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, 404);
    }
  });
}
