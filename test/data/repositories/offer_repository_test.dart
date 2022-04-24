import 'package:dio/dio.dart';
import 'package:ekrilli_app/data/repositories/offer_repository.dart';
import 'package:ekrilli_app/models/house.dart';
import 'package:ekrilli_app/models/offer.dart';
import 'package:ekrilli_app/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('OfferRepository get offers', () async {
    //// get instence
    OfferRepository offerRepository = OfferRepository();

    //// get all offers
    List<Offer>? data = await offerRepository.getOffers();
    print('allOffers.length: ${data?.length}');

    //// get offers by city
    data = await offerRepository.getOffers(cityId: 1);
    print('offersByCity.length: ${data?.length}');
  });

  test('OfferRepository get offer info', () async {
    //// get instence
    OfferRepository offerRepository = OfferRepository();

    ///// get offer info
    try {
      Offer? data = await offerRepository.getOfferInfo(1);
      print(data?.toJson());
      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, 404);
    }
  });

  test('OfferRepository create offer', () async {
    //// get instence
    OfferRepository offerRepository = OfferRepository();

    ///// create new offer
    try {
      Offer? data = await offerRepository.createOffer(
        Offer(
          house: House(id: 1),
          user: User(id: 2),
        ),
      );
      print(data?.toJson());
      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, 404);
    }
  });

  test('OfferRepository update offer', () async {
    //// get instence
    OfferRepository offerRepository = OfferRepository();

    ///// update offer
    try {
      Offer? data = await offerRepository.updateOfferInfo(
        offerId: 25,
        offer: Offer(status: 'DONE'),
      );
      print(data?.toJson());
      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, 404);
    }
  });

  test('OfferRepository change status', () async {
    //// get instence
    OfferRepository offerRepository = OfferRepository();

    ///// change offer status to PUBLISHED
    try {
      Offer? data = await offerRepository.changeStatus(
        offerId: 25,
        status: 'PUBLISHED',
      );
      print(data?.toJson());
      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, 404);
    }
  });
}
