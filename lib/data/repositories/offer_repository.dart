import 'package:dio/dio.dart';
import 'package:ekrilli_app/data/api/offer_api.dart';
import 'package:ekrilli_app/models/offer.dart';

import '../api/api.dart';

class OfferRepository {
  OfferAPI offerAPI = OfferAPI();
  Future<List<Offer>?> getOffers({
    int page = 1,
    int? cityId,
  }) async {
    List<Map<String, dynamic>>? data = await offerAPI.getOffers(
      page: page,
      cityId: cityId,
    );
    List<Offer> offers = [];
    data?.forEach((element) {
      offers.add(Offer.fromJson(element));
    });

    return offers;
  }

  Future<Offer?> getOfferInfo(int offerId) async {
    Map<String, dynamic>? offerJson = await offerAPI.offerInfo(offerId);
    Offer? offerData = Offer.fromJson(offerJson!);
    return offerData;
  }

  Future<Offer?> createOffer(Offer offer) async {
    FormData data = FormData.fromMap(offer.toJson());
    Map<String, dynamic>? responseData = await offerAPI.createOffer(data);
    if (responseData != null) {
      Offer responseOffer = Offer.fromJson(responseData);
      return responseOffer;
    }
  }

  Future<Offer?> updateOfferInfo({
    required int offerId,
    required Offer offer,
  }) async {
    FormData data = FormData.fromMap(offer.toJson());
    Map<String, dynamic>? responseData = await offerAPI.offerInfo(
      offerId,
      method: PATCH,
      data: data,
    );
    if (responseData != null) {
      Offer responseOffer = Offer.fromJson(responseData);
      return responseOffer;
    }
  }

  Future<Map<String, dynamic>?> changeStatus({
    required int offerId,
    required String status,
    int? userId,
    Map<String, dynamic>? offerData,
  }) async {
    Map<String, dynamic>? data = await offerAPI.changeStatus(
      offerId: offerId,
      status: status,
      userId: userId,
      offerData: offerData,
    );
    // if (data != null) {
    //   Offer offer = Offer.fromJson(data);
    //   return offer;
    // }

    return data;
  }

  Future<List<Offer>?> search({
    int page = 1,
    String search = '',
    int? cityId,
    String? orderBy,
    bool inversOrdering = false,
  }) async {
    List<Map<String, dynamic>>? data = await offerAPI.search(
      page: page,
      cityId: cityId,
      search: search,
      orderBy: orderBy,
      inversOrdering: inversOrdering,
    );
    List<Offer> offers = [];
    data?.forEach((element) {
      offers.add(Offer.fromJson(element));
    });

    return offers;
  }
}
