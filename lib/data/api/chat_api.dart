import 'package:dio/dio.dart';

import 'api.dart';

class ChatAPI {
  Future<List<Map<String, dynamic>>?> getConversation({
    required int offerId,
    required int userId,
    int page = 1,
  }) async {
    String apiUrl = '$api/api/conversation/$offerId/$userId/?page=$page';

    Response response = await dio
        .get(
      apiUrl,
      options: options,
    )
        .onError<DioError>(
      (error, stackTrace) {
        throw error;
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response);
    }
    return [...response.data['results']];
  }

  Future<List<Map<String, dynamic>>?> getOffersByMessages() async {
    String apiUrl = '$api/api/chat/offers/';

    Response response = await dio
        .get(
      apiUrl,
      options: options,
    )
        .onError<DioError>(
      (error, stackTrace) {
        throw error;
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response);
    }
    return [...response.data];
  }

  Future<Map<String, dynamic>?> sendMessage({
    /// if withOffer is true then offerId dosen't metter
    required int offerId,
    required int userId,
    required dynamic data,
    bool withOffer = false,
  }) async {
    String apiUrl = '$api/api/conversation/$offerId/$userId/';

    if (withOffer) {
      apiUrl = '$api/api/new-message/new-offer/$userId/';
    }
    Response response = await dio
        .post(
      apiUrl,
      data: data,
      options: options,
    )
        .onError<DioError>(
      (error, stackTrace) {
        throw error;
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response);
    }
    return response.data;
  }
}
