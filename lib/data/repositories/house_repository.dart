import 'package:dio/dio.dart';
import 'package:ekrilli_app/data/api/house_api.dart';
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

  Future<House?> getHouseInfo(int houseId) async {
    Map<String, dynamic>? houseJson = await houseAPI.houseInfo(houseId);
    House? houseData = House.fromJson(houseJson!);
    return houseData;
  }
}
