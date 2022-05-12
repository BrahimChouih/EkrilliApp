import 'package:ekrilli_app/models/house.dart';
import 'package:ekrilli_app/models/user.dart';

import 'offer.dart';

class Favorite {
  int? id;
  DateTime? createdAt;
  Offer? offer;
  User? user;

  Favorite({this.id, this.createdAt, this.offer, this.user});

  Favorite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = DateTime.parse(json['created_at']);
    offer = Offer.fromJson(json['offer']);
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['offer'] = offer?.id;
    data['user'] = user?.id;
    return data;
  }
}
