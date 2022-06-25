import 'package:ekrilli_app/models/offer.dart';
import 'package:ekrilli_app/models/user.dart';

class ChatItemModel {
  User? user;
  Offer? offer;
  ChatItemModel({
    this.user,
    this.offer,
  });

  ChatItemModel.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user']);
    offer = Offer.fromJson(json['offer']);
  }
}
