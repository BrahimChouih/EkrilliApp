import 'package:dio/dio.dart';
import 'package:ekrilli_app/data/api/chat_api.dart';

import '../../models/message.dart';

class ChatRepository {
  ChatAPI chatAPI = ChatAPI();

  Future<List<Message>?> getConversation({
    required int offerId,
    required int userId,
    int page = 1,
  }) async {
    List<Map<String, dynamic>>? data = await chatAPI.getConversation(
      offerId: offerId,
      userId: userId,
      page: 1,
    );
    List<Message> conversation = [];
    data?.forEach((element) {
      conversation.add(Message.fromJson(element));
    });

    return conversation;
  }

  Future<Message?> sendMessage({
    required int offerId,
    required int userId,
    required Message message,
  }) async {
    FormData data = FormData.fromMap(message.toJson());
    Map<String, dynamic>? responseData = await chatAPI.sendMessage(
      offerId: offerId,
      userId: userId,
      data: data,
    );
    if (responseData != null) {
      Message responseMessage = Message.fromJson(responseData);
      return responseMessage;
    }
  }
}
