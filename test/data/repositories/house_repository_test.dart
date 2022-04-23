import 'package:dio/dio.dart';
import 'package:ekrilli_app/data/repositories/house_repository.dart';
import 'package:ekrilli_app/models/house.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('HouseRepository get houses', () async {
    //// get instence
    HouseRepository houseRepository = HouseRepository();

    //// get all houses
    List<House>? data = await houseRepository.getHouses();
    print('allHouses.length: ${data?.length}');

    //// get houses by city
    data = await houseRepository.getHouses(cityId: 1);
    print('housesByCity.length: ${data?.length}');
  });

  test('HouseRepository get house info', () async {
    //// get instence
    HouseRepository houseRepository = HouseRepository();

    ///// get house info
    try {
      House? data = await houseRepository.getHouseInfo(1);
      print(data?.toJson());
      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, 404);
    }
  });
}
