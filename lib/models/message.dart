import 'package:ekrilli_app/models/offer.dart';
import 'package:ekrilli_app/models/user.dart';

import '../data/api/api.dart';

class Message {
  int? id;
  String? messageType;
  String? contentType;
  String? message;
  String? image;
  DateTime? createdAt;
  Offer? offer;
  User? user;

  Message({
    this.id,
    this.messageType,
    this.contentType,
    this.message,
    this.image,
    this.createdAt,
    this.offer,
    this.user,
  });

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    messageType = json['message_type'];
    contentType = json['content_type'];
    message = json['message'];
    if (json['image'] != null) {
      image =
          !json['image'].contains(api) ? api + json['image'] : json['image'];
    }
    createdAt = DateTime.parse(json['created_at']);
    offer = Offer.fromJson(json['offer']);
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message_type'] = messageType;
    data['content_type'] = contentType;
    data['message'] = message;
    data['image'] = image;
    data['offer'] = offer?.id;
    data['user'] = user?.id;
    return data;
  }
}
