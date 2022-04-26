import 'package:ekrilli_app/models/offer.dart';

class Rating {
  int? id;
  String? comment;
  double? stars;
  DateTime? createdAt;
  Offer? offer;

  Rating({this.id, this.comment, this.stars, this.createdAt, this.offer});

  Rating.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    stars = json['stars'];
    createdAt = DateTime.parse(json['created_at']);
    offer = Offer.fromJson(json['offer']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['comment'] = comment;
    data['stars'] = stars;
    data['created_at'] = createdAt?.toIso8601String();
    data['offer'] = offer?.id;
    return data;
  }
}
