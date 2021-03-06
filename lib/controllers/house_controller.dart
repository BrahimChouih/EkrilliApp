import 'package:ekrilli_app/controllers/pagination_controller.dart';
import 'package:ekrilli_app/models/house.dart';
import 'package:ekrilli_app/models/municipality.dart';
import '../data/repositories/house_repository.dart';
import '../models/city.dart';
import '../models/picture.dart';

class HouseController extends PaginationController with HouseRepository {
  List<City> cities = [];
  List<Municipality> municipalities = [];
  List<House> myHouses = [];

  final String municipalitiesId = 'municipalitiesId';

  bool get isEmpty => myHouses.isEmpty;
  @override
  Future<List<City>?> getCities() async {
    cities = (await super.getCities()) ?? [];
    update([municipalitiesId]);
    return cities;
  }

  @override
  Future<List<Municipality>?> getMunicipalities({int cityId = 1}) async {
    municipalities = (await super.getMunicipalities(cityId: cityId)) ?? [];
    update([municipalitiesId]);
    return municipalities;
  }

  @override
  Future<void> getData({required int page, Parameters? parameters}) async {
    // changeLoadingState(true);

    List<House>? resualt = await super.getHouses(
      page: page,
      myHouses: parameters?.myHouses ?? false,
    );

    myHouses.addAll(resualt ?? []);

    // changeLoadingState(false);
  }

  @override
  Future<void> initData({Parameters? parameters}) async {
    List<House>? resualt = await super.getHouses(
      myHouses: parameters?.myHouses ?? false,
    );
    myHouses = resualt ?? [];
  }

  @override
  Future<void> deleteHouse(int houseId) async {
    await super.deleteHouse(houseId);
  }

  @override
  Future<House?> createHouse(House house) async {
    await super.createHouse(house);
    await refreshData(parameters: Parameters(myHouses: true));
  }

  @override
  Future<House?> updateHouseInfo({
    required int houseId,
    required House house,
    List<Picture> deletedPictures = const [],
  }) async {
    await super.updateHouseInfo(
      houseId: houseId,
      house: house,
      deletedPictures: deletedPictures,
    );
    await refreshData(parameters: Parameters(myHouses: true));
  }
}

////
///
///
///
///
///
///
///
// List<House> houseData = [
//   House(
//     owner: User(
//       username: 'Brahim CHOUIH',
//       picture: '$api/media/users/5_pictuer_2022-04-29-150027.864713.png',

//       /// firebase
//       // picture:
//       //     'https://firebasestorage.googleapis.com/v0/b/fir-project-be9a2.appspot.com/o/5_pictuer_2022-04-29-150027.864713.png?alt=media&token=dd6fa134-042a-4ef0-90bb-bb7cdf97af85',
//     ),
//     title: 'Come to titree',
//     rooms: 4,
//     kitchens: 1,
//     bathrooms: 1,
//     bedrooms: 1,
//     stars: 23,
//     numReviews: 5,
//     description:
//         """I'd like to implement a hero animation for an image on my main screen while presenting an AlertDialog widget with the same image in the dialog's content.I'd like the presentation to appear as in the screenshot below. When I tap the image in the bottom left, I'd like the hero animation and an inset preview of the image along with a transparent overlay that can be tapped to dismiss.I'd like to implement a hero animation for an image on my main screen while presenting an AlertDialog widget with the same image in the dialog's content.I'd like the presentation to appear as in the screenshot below. When I tap the image in the bottom left, I'd like the hero animation and an inset preview of the image along with a transparent overlay that can be tapped to dismiss.""",
//     pictures: [
//       Picture(
//         picture:
//             '$api/media/houses/Come_to_Titree_2022-03-29-105836.813969.jpg',

//         /// firebase
//         // picture:
//         //     'https://firebasestorage.googleapis.com/v0/b/fir-project-be9a2.appspot.com/o/Come_to_Titree_2022-03-29-105836.813969.jpg?alt=media&token=07e17d5d-c5c5-4041-955c-5f96e38ce7f8',
//       ),
//       Picture(
//         picture:
//             '$api/media/houses/Come_to_Titree_2022-03-29-105846.882861.jpg',

//         /// firebase
//         // picture:
//         //     'https://firebasestorage.googleapis.com/v0/b/fir-project-be9a2.appspot.com/o/Come_to_Titree_2022-03-29-105846.882861.jpg?alt=media&token=91d77bf7-f999-4303-a379-e122794d857c',
//       ),
//     ],
//   ),
// ];
