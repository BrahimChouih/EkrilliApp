import 'package:dio/dio.dart';
import 'package:ekrilli_app/data/api/chat_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ChatAPI get conversation', () async {
    //// get instence
    ChatAPI chatAPI = ChatAPI();

    ///// get Conversation
    try {
      List<Map<String, dynamic>>? data = await chatAPI.getConversation(
        offerId: 1,
        userId: 2,
        page: 1,
      );
      print('conversation.length: ${data?.length}');
      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, 404);
    }
  });

  test('ChatAPI get chat items', () async {
    //// get instence
    ChatAPI chatAPI = ChatAPI();

    ///// get chat items

    List<Map<String, dynamic>>? data = await chatAPI.getChatItems();
    print('offers.length: ${data?.length}');
    expect(data != null, true);
  });

  test('ChatAPI get OfferSended', () async {
    //// get instence
    ChatAPI chatAPI = ChatAPI();

    try {
      Map<String, dynamic>? data = await chatAPI.getChatOfferSended(
        offerId: 1,
        userId: 5,
      );
      print(data);
      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, 404);
    }
  });

  test('ChatAPI send message', () async {
    //// get instence
    ChatAPI chatAPI = ChatAPI();

    ///// send message
    try {
      Map<String, dynamic>? data = await chatAPI.sendMessage(
          offerId: 1,
          userId: 2,
          data: FormData.fromMap({
            "message_type": "REQUEST",
            "content_type": "MESSAGE",
            "message": "hello2",
          }));
      print(data);
      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, 404);
    }
  });
  test('ChatAPI send message with new offer', () async {
    //// get instence
    ChatAPI chatAPI = ChatAPI();

    ///// send message
    try {
      Map<String, dynamic>? data = await chatAPI.sendMessage(
        offerId: 0,
        userId: 2,
        withOffer: true,
        data: {
          "message_type": "REQUEST",
          "content_type": "MESSAGE",
          "message": "form test",
          "offer": {
            "total_price": 0.0,
            "house": 1,
          }
        },
      );
      print(data);
      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, 400);
    }
  });
}
