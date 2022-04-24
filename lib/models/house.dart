import 'package:ekrilli_app/models/city.dart';
import 'package:ekrilli_app/models/picture.dart';
import 'package:ekrilli_app/models/user.dart';

class House {
  int? id;
  String? houseType;
  String? title;
  String? description;
  double? pricePerDay;
  double? locationLatitude;
  double? locationLongitude;
  bool? isAvailable;
  double? stars;
  int? numReviews;
  DateTime? createdAt;
  User? owner;
  City? city;
  List<Picture>? pictures = [];

  House({
    this.id,
    this.houseType,
    this.title,
    this.description,
    this.pricePerDay,
    this.locationLatitude,
    this.locationLongitude,
    this.isAvailable,
    this.stars,
    this.numReviews,
    this.createdAt,
    this.owner,
    this.city,
    this.pictures = const [],
  });

  House.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    houseType = json['houseType'];
    title = json['title'];
    description = json['description'];
    pricePerDay = json['price_per_day'];
    locationLatitude = json['location_latitude'];
    locationLongitude = json['location_longitude'];
    isAvailable = json['isAvailable'];
    stars = json['stars'];
    numReviews = json['numReviews'];
    createdAt = DateTime.parse(json['created_at']);
    city = City.fromJson(json['city']);
    owner = User.fromJson(json['owner']);
    for (var item in (json['pictures'] as List)) {
      pictures?.add(Picture.fromJson(item));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['houseType'] = houseType;
    data['title'] = title;
    data['description'] = description;
    data['price_per_day'] = pricePerDay;
    data['location_latitude'] = locationLatitude;
    data['location_longitude'] = locationLongitude;
    data['isAvailable'] = isAvailable;
    data['stars'] = stars;
    data['numReviews'] = numReviews;
    data['city'] = city?.id;
    data['pictures'] = [];
    pictures?.forEach((element) {
      data['pictures'].add(element.picture);
    });
    return data;
  }
}
