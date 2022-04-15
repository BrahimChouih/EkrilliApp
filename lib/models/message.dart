import 'package:ekrilli_app/models/offer.dart';

class Message {
  int? id;
  String? messageType;
  String? contentType;
  String? message;
  String? image;
  DateTime? createdAt;
  Offer? offer;

  Message(
      {this.id,
      this.messageType,
      this.contentType,
      this.message,
      this.image,
      this.createdAt,
      this.offer});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    messageType = json['message_type'];
    contentType = json['content_type'];
    message = json['message'];
    image = json['image'];
    createdAt = DateTime.parse(json['created_at']);
    offer = Offer.fromJson(json['offer']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message_type'] = messageType;
    data['content_type'] = contentType;
    data['message'] = message;
    data['image'] = image;
    data['created_at'] = createdAt?.toIso8601String();
    data['offer'] = offer?.id;
    return data;
  }
}
