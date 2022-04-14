import 'package:dio/dio.dart';
import 'package:ekrilli_app/api/api.dart';
import 'package:ekrilli_app/api/api_offer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('APIOffer get offers', () async {
    //// get instence
    APIOffer apiOffer = APIOffer();

    ///// get my offers
    List<Map<String, dynamic>>? data = await apiOffer.getOffers();
    // print(data);
    expect(data?.length != null, true);
  });

  test('APIOffer create new offers', () async {
    //// get instence
    APIOffer apiOffer = APIOffer();

    //// create new house
    Map<String, dynamic>? data = await apiOffer.createOffer(
      FormData.fromMap({
        "house": 9,
        "user": 2,
      }),
    );

    print(data);
    expect(data != null, true);
  });

  test('APIOffer get offer info', () async {
    //// get instence
    APIOffer apiOffer = APIOffer();

    //// create new house
    Map<String, dynamic>? data = await apiOffer.offerInfo(16);

    print(data);
    expect(data != null, true);
  });

  test('APIOffer update offer info', () async {
    //// get instence
    APIOffer apiOffer = APIOffer();

    //// create new house
    Map<String, dynamic>? data = await apiOffer.offerInfo(
      16,
      method: PATCH,
      data: FormData.fromMap({
        "total_price": 9000,
      }),
    );

    print(data);
    expect(data != null, true);
  });

  test('APIOffer change offer status', () async {
    //// get instence
    APIOffer apiOffer = APIOffer();

    //// create new house
    Map<String, dynamic>? data = await apiOffer.changeStatus(
      offerId: 16,
      status: 'WAITING_FOR_ACCEPTE',
    );

    print(data);
    expect(data != null, true);
  });
}
