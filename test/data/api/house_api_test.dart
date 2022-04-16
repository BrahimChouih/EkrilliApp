import 'package:dio/dio.dart';
import 'package:ekrilli_app/data/api/api.dart';
import 'package:ekrilli_app/data/api/house_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('HouseAPI get houses', () async {
    //// get instence
    HouseAPI houseAPI = HouseAPI();
    try {
      ///// get all houses
      List<Map<String, dynamic>>? data = await houseAPI.getHouses();
      expect(data?.length != null, true);

      //// get houses by city
      data = await houseAPI.getHouses(cityId: 1);
      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, 404);
    }
  });

  test('HouseAPI get house info', () async {
    //// get instence
    HouseAPI houseAPI = HouseAPI();

    ///// get house info
    try {
      Map<String, dynamic>? data = await houseAPI.houseInfo(1);
      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, 404);
    }
  });

  test('HouseAPI create new house', () async {
    //// get instence
    HouseAPI houseAPI = HouseAPI();

    //// create new house
    Map<String, dynamic>? data = await houseAPI.createNewHouse(
      FormData.fromMap({
        "houseType": "VILLA",
        "title": "House from test",
        "description": "testetsetstsetstsetsets",
        "price_per_day": 3000.0,
        "location_latitude": 36.26417,
        "location_longitude": 2.75393,
        "city": 1,
        "pictures": [],
      }),
    );

    print(data);
    expect(data != null, true);
  });

  test('HouseAPI update house info', () async {
    //// get instence
    HouseAPI houseAPI = HouseAPI();

    //// update house info
    try {
      Map<String, dynamic>? data = await houseAPI.houseInfo(
        20,
        method: PATCH,
        data: FormData.fromMap({"title": "Come to Titree testetste"}),
      );

      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, anyOf(404, 400));
    }
  });

  test('HouseAPI delete a house', () async {
    //// get instence
    HouseAPI houseAPI = HouseAPI();

    //// delete a house
    try {
      Map<String, dynamic>? data = await houseAPI.houseInfo(
        12,
        method: DELETE,
      );
      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, anyOf(404, 400));
    }
  });

  test('CitiesAPI', () async {
    //// get instence
    HouseAPI houseAPI = HouseAPI();

    //// delete a house
    List<Map<String, dynamic>>? data = await houseAPI.getCities();

    print(data);
    expect(data != null, true);
  });
}
