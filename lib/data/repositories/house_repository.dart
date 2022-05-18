import 'dart:io';
import 'package:ekrilli_app/models/municipality.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:ekrilli_app/data/api/house_api.dart';
import 'package:ekrilli_app/models/city.dart';
import 'package:ekrilli_app/models/house.dart';

import '../../models/picture.dart';
import '../api/api.dart';

class HouseRepository {
  HouseAPI houseAPI = HouseAPI();
  Future<List<House>?> getHouses({
    int page = 1,
    int? cityId,
    bool myHouses=false,
  }) async {
    List<Map<String, dynamic>>? data = await houseAPI.getHouses(
      page: page,
      cityId: cityId,
      myHouses: myHouses,
    );
    List<House> houses = [];
    data?.forEach((element) {
      houses.add(House.fromJson(element));
    });

    return houses;
  }

  Future<House?> createHouse(House house) async {
    Map<String, dynamic> data = house.toJson();
    data['pictures'] = [];

    for (int i = 0; i < house.pictures.length; i++) {
      if (!house.pictures[i].isUrl) {
        MultipartFile multipartFile = await MultipartFile.fromFile(
          house.pictures[i].picture,
          filename: basename(house.pictures[i].picture),
        );
        data['pictures'].add({'picture': multipartFile});
      }
    }

    FormData formdata = FormData.fromMap(data, ListFormat.multiCompatible);

    Map<String, dynamic>? responseData =
        await houseAPI.createNewHouse(formdata);
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
    List<Picture> deletedPictures = const [],
  }) async {
    // FormData data = FormData.fromMap(house.toJson());

    Map<String, dynamic> data = house.toJson();
    data['pictures'] = [];

    for (int i = 0; i < house.pictures.length; i++) {
      if (house.pictures[i].isUrl) {
        MultipartFile multipartFile = await MultipartFile.fromFile(
          house.pictures[i].picture,
          filename: basename(house.pictures[i].picture),
        );
        data['pictures'].add({'picture': multipartFile});
      }
    }

    try {
      for (int i = 0; i < deletedPictures.length; i++) {
        await houseAPI.deletePicture(deletedPictures[i].id!);
      }
    } on DioError catch (e) {
      print(e.response?.data);
    }

    FormData formdata = FormData.fromMap(data, ListFormat.multiCompatible);

    Map<String, dynamic>? responseData = await houseAPI.houseInfo(
      houseId,
      method: PATCH,
      data: formdata,
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

  Future<List<Municipality>?> getMunicipalities({int cityId = 1}) async {
    List<Map<String, dynamic>>? data = await houseAPI.getMunicipalities(
      cityId: cityId,
    );
    List<Municipality> municipalities = [];
    data?.forEach((element) {
      municipalities.add(Municipality.fromJson(element));
    });

    return municipalities;
  }
}
