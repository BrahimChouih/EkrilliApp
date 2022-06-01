import 'package:ekrilli_app/models/city.dart';

import '../data/api/api.dart';

class Municipality {
  int? id;
  String? name;
  City? city;

  Municipality({this.id, this.name, this.city});

  Municipality.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = City.fromJson(json['city']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['city'] = city?.id;
    return data;
  }

  @override
  String toString() {
    return name ?? super.toString();
  }
}
