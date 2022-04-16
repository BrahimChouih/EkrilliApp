import 'package:dio/dio.dart';
import 'package:ekrilli_app/data/api/chat_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ChatAPI get conversation', () async {
    //// get instence
    ChatAPI chatAPI = ChatAPI();

    ///// get Conversation
    try {
      List<Map<String, dynamic>>? data =
          await chatAPI.getConversation(offerId: 1, page: 1);
      print('conversation.length: ${data?.length}');
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
      Map<String, dynamic>? data =
          await chatAPI.sendMessage(offerId: 0, withOffer: true, data: {
        "message_type": "REQUEST",
        "content_type": "MESSAGE",
        "message": "form test",
        "offer": {
          "total_price": 0.0,
          "house": 1,
        }
      });
      print(data);
      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, 400);
    }
  });
}
