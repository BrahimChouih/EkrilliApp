import 'package:dio/dio.dart';
import 'package:ekrilli_app/data/api/api.dart';
import 'package:ekrilli_app/data/api/api_offer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('APIOffer get offers', () async {
    //// get instence
    APIOffer apiOffer = APIOffer();

    ///// get my offers
    List<Map<String, dynamic>>? data = await apiOffer.getOffers();
    print(data);
    expect(data?.length != null, true);
  });

  test('APIOffer create new offers', () async {
    //// get instence
    APIOffer apiOffer = APIOffer();

    //// create new offer
    try {
      Map<String, dynamic>? data = await apiOffer.createOffer(
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

  test('APIOffer get offer info', () async {
    //// get instence
    APIOffer apiOffer = APIOffer();

    //// create new house
    try {
      Map<String, dynamic>? data = await apiOffer.offerInfo(15);

      print(data);
      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, 404);
    }
  });

  test('APIOffer update offer info', () async {
    //// get instence
    APIOffer apiOffer = APIOffer();

    //// create new house
    try {
      Map<String, dynamic>? data = await apiOffer.offerInfo(
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

  test('APIOffer change offer status', () async {
    //// get instence
    APIOffer apiOffer = APIOffer();

    //// create new house
    try {
      Map<String, dynamic>? data = await apiOffer.changeStatus(
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
}
