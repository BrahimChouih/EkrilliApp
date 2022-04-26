import 'package:ekrilli_app/models/house.dart';
import 'package:ekrilli_app/models/user.dart';

class Favorite {
  int? id;
  DateTime? createdAt;
  House? house;
  User? user;

  Favorite({this.id, this.createdAt, this.house, this.user});

  Favorite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = DateTime.parse(json['created_at']);
    house = House.fromJson(json['house']);
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['house'] = house;
    data['user'] = user;
    return data;
  }
}
