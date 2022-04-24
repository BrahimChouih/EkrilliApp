import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ekrilli_app/data/repositories/house_repository.dart';
import 'package:ekrilli_app/models/city.dart';
import 'package:ekrilli_app/models/house.dart';
import 'package:ekrilli_app/models/picture.dart';
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

  test('HouseRepository create house', () async {
    //// get instence
    HouseRepository houseRepository = HouseRepository();
    File picture = File('test_resources/image.jpg');

    ///// create new house
    try {
      House? data = await houseRepository.createHouse(
        House(
          city: City(id: 1),
          description: 'fdsfdsa',
          title: 'test repository',
          houseType: 'VILLA',
          pricePerDay: 1324,
          pictures: [
            Picture(
              isUrl: false,
              picture: picture.path,
            ),
            Picture(
              isUrl: false,
              picture: picture.path,
            ),
          ],
        ),
      );
      print(data?.toJson());
      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, 404);
    }
  });

  test('HouseRepository update offer', () async {
    //// get instence
    HouseRepository houseRepository = HouseRepository();
    File picture = File('test_resources/image.jpg');

    ///// update house info
    try {
      House? data = await houseRepository.updateHouseInfo(
        houseId: 38,
        house: House(title: 'test repository update', pictures: [
          Picture(
            isUrl: false,
            picture: picture.path,
          ),
        ]),
        deletedPictures: [
          Picture(id: 16),
          Picture(id: 17),
          Picture(id: 18),
          Picture(id: 19),
        ],
      );
      print(data?.toJson());
      expect(data != null, true);
    } on DioError catch (e) {
      print(e.response?.data);
      expect(e.response?.statusCode, anyOf(404, 400));
    }
  });

  test('CityRepository get Cities', () async {
    //// get instence
    HouseRepository houseRepository = HouseRepository();

    //// get all Cities
    List<City>? data = await houseRepository.getCities();
    print('allCities.length: ${data?.length}');
  });
}
