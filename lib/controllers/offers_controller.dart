import 'package:ekrilli_app/controllers/pagination_controller.dart';
import 'package:ekrilli_app/data/repositories/offer_repository.dart';
import 'package:ekrilli_app/models/user.dart';
import 'package:ekrilli_app/utils/constants.dart';
import 'package:get/get.dart';

import '../data/api/api.dart';
import '../models/city.dart';
import '../models/house.dart';
import '../models/municipality.dart';
import '../models/offer.dart';
import '../models/picture.dart';

class OfferController extends PaginationController with OfferRepository {
  List<Offer> offers = [];
  List<Offer> offersByCity = [];
  List<Offer> offersByHouse = [];
  bool isGettingOfferByHouse = true;

  final String offerInfoWidgetId = 'offerInfoWidgetId';
  final String offersByHouseId = 'offerByHouseId';

  bool get isEmpty => offers.isEmpty;

  @override
  Future<void> getData({required int page, Parameters? parameters}) async {
    // changeLoadingState(true);

    List<Offer>? resualt = await super.getOffers(
      page: page,
      cityId: parameters?.cityId,
    );

    if (parameters?.cityId == null) {
      offers.addAll(resualt ?? []);
    } else {
      offersByCity.addAll(resualt ?? []);
    }
    // changeLoadingState(false);
  }

  @override
  Future<void> initData({Parameters? parameters}) async {
    List<Offer>? resualt = await super.getOffers(
      cityId: parameters?.cityId,
    );
    if (parameters?.cityId == null) {
      offers = resualt ?? [];
    } else {
      offersByCity = resualt ?? [];
    }
  }

  @override
  Future<Offer?> getOfferInfo(
    int offerId, {
    Function(Offer)? returnOffer,
  }) async {
    Offer? offer = await super.getOfferInfo(offerId);
    if (offer != null && returnOffer != null) {
      returnOffer(offer);
    }
    update([offerInfoWidgetId]);
    return offer;
  }

  Future<List<House>?> getoffersByHouse(int houseId) async {
    isGettingOfferByHouse = true;
    update([offersByHouseId]);
    offersByHouse = (await super.getOffers(houseId: houseId)) ?? [];
    offersByHouse = offersByHouse.reversed.toList();
    isGettingOfferByHouse = false;
    update([offersByHouseId]);
  }

  @override
  Future<Offer?> updateOfferInfo({
    required int offerId,
    required Offer offer,
  }) async {
    await super.updateOfferInfo(
      offerId: offerId,
      offer: offer,
    );
    await refreshData();
  }

  @override
  Future<Offer?> createOffer(Offer offer) async {
    await super.createOffer(offer);
    refreshData();
  }

  Offer? get offerWithPublishStatus => offersByHouse.firstWhere(
        (offer) =>
            offer.status == statusPublished ||
            offer.status == statusWaittingForAccepte,
      );
}

///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
List offerData = [
  Offer(
    pricePerDay: 3000,
    status: 'PUBLISHED',
    house: House(
      title: 'Come to titree',
      locationLatitude: 36.26417,
      locationLongitude: 2.75393,
      municipality: Municipality(
        name: 'Ouled Bouachra',
        city: City(name: 'Medea'),
      ),
      owner: User(
        username: 'Brahim CHOUIH',
        picture: '$api/media/users/5_pictuer_2022-04-29-150027.864713.png',

        /// firebase
        // picture:
        //     'https://firebasestorage.googleapis.com/v0/b/fir-project-be9a2.appspot.com/o/5_pictuer_2022-04-29-150027.864713.png?alt=media&token=dd6fa134-042a-4ef0-90bb-bb7cdf97af85',
      ),
      rooms: 4,
      kitchens: 3,
      bathrooms: 2,
      bedrooms: 2,
      stars: 23,
      numReviews: 5,
      description:
          """I'd like to implement a hero animation for an image on my main screen while presenting an AlertDialog widget with the same image in the dialog's content.I'd like the presentation to appear as in the screenshot below. When I tap the image in the bottom left, I'd like the hero animation and an inset preview of the image along with a transparent overlay that can be tapped to dismiss.I'd like to implement a hero animation for an image on my main screen while presenting an AlertDialog widget with the same image in the dialog's content.I'd like the presentation to appear as in the screenshot below. When I tap the image in the bottom left, I'd like the hero animation and an inset preview of the image along with a transparent overlay that can be tapped to dismiss.""",
      pictures: [
        Picture(
          picture:
              '$api/media/houses/Come_to_Titree_2022-03-29-105836.813969.jpg',

          /// firebase
          // picture:
          //     'https://firebasestorage.googleapis.com/v0/b/fir-project-be9a2.appspot.com/o/Come_to_Titree_2022-03-29-105836.813969.jpg?alt=media&token=07e17d5d-c5c5-4041-955c-5f96e38ce7f8',
        ),
        Picture(
          picture:
              '$api/media/houses/Come_to_Titree_2022-03-29-105846.882861.jpg',

          /// firebase
          // picture:
          //     'https://firebasestorage.googleapis.com/v0/b/fir-project-be9a2.appspot.com/o/Come_to_Titree_2022-03-29-105846.882861.jpg?alt=media&token=91d77bf7-f999-4303-a379-e122794d857c',
        ),
      ],
    ),
  ),
];
