import 'package:dio/dio.dart';
import 'package:ekrilli_app/data/api/house_api.dart';
import 'package:ekrilli_app/models/city.dart';
import 'package:ekrilli_app/models/house.dart';

import '../api/api.dart';

class HouseRepository {
  HouseAPI houseAPI = HouseAPI();
  Future<List<House>?> getHouses({
    int page = 1,
    int? cityId,
  }) async {
    List<Map<String, dynamic>>? data = await houseAPI.getHouses(
      page: page,
      cityId: cityId,
    );
    List<House> houses = [];
    data?.forEach((element) {
      houses.add(House.fromJson(element));
    });

    return houses;
  }

  Future<House?> createHouse(House house) async {
    FormData data = FormData.fromMap(house.toJson());
    Map<String, dynamic>? responseData = await houseAPI.createNewHouse(data);
    if (responseData != null) {
      House responseOffer = House.fromJson(responseData);
      return responseOffer;
    }
  }

  Future<House?> getHouseInfo(int houseId) async {
    Map<String, dynamic>? houseJson = await houseAPI.houseInfo(houseId);
    House? houseData = House.fromJson(houseJson!);
    return houseData;
  }

  Future<House?> updateHouseInfo({
    required int houseId,
    required House house,
  }) async {
    FormData data = FormData.fromMap(house.toJson());
    Map<String, dynamic>? responseData = await houseAPI.houseInfo(
      houseId,
      method: PATCH,
      data: data,
    );
    if (responseData != null) {
      House responseOffer = House.fromJson(responseData);
      return responseOffer;
    }
  }

  Future<List<City>?> getCities() async {
    List<Map<String, dynamic>>? data = await houseAPI.getCities();
    List<City> cities = [];
    data?.forEach((element) {
      cities.add(City.fromJson(element));
    });

    return cities;
  }
}
