import 'package:dio/dio.dart';
import 'package:ekrilli_app/data/api/api_chat.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('APIChat get conversation', () async {
    //// get instence
    APIChat apiChat = APIChat();

    ///// get Conversation
    try {
      List<Map<String, dynamic>>? data =
          await apiChat.getConversation(offerId: 1, page: 1);
      print('conversation.length: ${data?.length}');
      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, 404);
    }
  });

  test('APIChat send message', () async {
    //// get instence
    APIChat apiChat = APIChat();

    ///// send message
    try {
      Map<String, dynamic>? data = await apiChat.sendMessage(
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
  test('APIChat send message with new offer', () async {
    //// get instence
    APIChat apiChat = APIChat();

    ///// send message
    try {
      Map<String, dynamic>? data =
          await apiChat.sendMessage(offerId: 0, withOffer: true, data: {
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
