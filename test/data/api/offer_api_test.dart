import 'package:dio/dio.dart';
import 'package:ekrilli_app/data/api/api.dart';
import 'package:ekrilli_app/data/api/offer_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('OfferAPI get offers', () async {
    //// get instence
    OfferAPI offerAPI = OfferAPI();

    ///// get my offers
    List<Map<String, dynamic>>? data = await offerAPI.getOffers(
      houseId: 1,
    );
    print(data);
    expect(data?.length != null, true);
  });

  test('OfferAPI create new offers', () async {
    //// get instence
    OfferAPI offerAPI = OfferAPI();

    //// create new offer
    try {
      Map<String, dynamic>? data = await offerAPI.createOffer(
        FormData.fromMap({
          "house": 9,
          "user": 2,
        }),
      );

      print(data);
      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, 400);
    }
  });

  test('OfferAPI get offer info', () async {
    //// get instence
    OfferAPI offerAPI = OfferAPI();

    //// create new house
    try {
      Map<String, dynamic>? data = await offerAPI.offerInfo(15);

      print(data);
      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, 404);
    }
  });

  test('OfferAPI update offer info', () async {
    //// get instence
    OfferAPI offerAPI = OfferAPI();

    //// create new house
    try {
      Map<String, dynamic>? data = await offerAPI.offerInfo(
        15,
        method: PATCH,
        data: FormData.fromMap({
          "total_price": 9000,
        }),
      );

      print(data);
      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, anyOf(404, 400));
    }
  });

  test('OfferAPI change offer status', () async {
    //// get instence
    OfferAPI offerAPI = OfferAPI();

    //// create new house
    try {
      Map<String, dynamic>? data = await offerAPI.changeStatus(
        offerId: 15,
        status: 'WAITING_FOR_ACCEPTE',
      );

      print(data);
      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, anyOf(404, 400));
    }
  });

  test('OfferAPI search on an offer', () async {
    //// get instence
    OfferAPI offerAPI = OfferAPI();

    ///// search
    List<Map<String, dynamic>>? data = await offerAPI.search(
      inversOrdering: false,
      search: 'Titree',
      orderBy: 'stars',
    );
    // print(data);
    data?.forEach((d) {
      print('id:${d['id']}');
      print('stars:${d['house']['stars']}');
    });
    expect(data?.length != null, true);
  });
}
