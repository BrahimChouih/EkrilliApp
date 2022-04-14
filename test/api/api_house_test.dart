import 'package:dio/dio.dart';
import 'package:ekrilli_app/api/api.dart';
import 'package:ekrilli_app/api/api_house.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('APIHouse get houses', () async {
    //// get instence
    APIHouse apiHouse = APIHouse();

    ///// get all houses
    List<Map<String, dynamic>>? data = await apiHouse.getHouses();
    expect(data?.length != null, true);

    //// get houses by city
    data = await apiHouse.getHouses(cityId: 1);
    expect(data?.length != null, true);
  });

  test('APIHouse get house info', () async {
    //// get instence
    APIHouse apiHouse = APIHouse();

    ///// get house info
    Map<String, dynamic>? data = await apiHouse.houseInfo(1);
    expect(data != null, true);
  });

  test('APIHouse create new house', () async {
    //// get instence
    APIHouse apiHouse = APIHouse();

    //// create new house
    Map<String, dynamic>? data = await apiHouse.createNewHouse(
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

  test('APIHouse update house info', () async {
    //// get instence
    APIHouse apiHouse = APIHouse();

    //// update house info
    Map<String, dynamic>? data = await apiHouse.houseInfo(
      1,
      method: PATCH,
      data: FormData.fromMap({"title": "Come to Titree"}),
    );
    expect(data != null, true);
  });

  test('APIHouse delete a house', () async {
    //// get instence
    APIHouse apiHouse = APIHouse();

    //// delete a house
    Map<String, dynamic>? data = await apiHouse.houseInfo(
      6,
      method: DELETE,
    );
    expect(data != null, true);
  });

  test('APICities', () async {
    //// get instence
    APIHouse apiHouse = APIHouse();

    //// delete a house
    List<Map<String, dynamic>>? data = await apiHouse.getCities();

    print(data);
    expect(data != null, true);
  });
}
