import 'package:ekrilli_app/models/city.dart';
import 'package:ekrilli_app/models/offer.dart';
import 'package:ekrilli_app/models/user.dart';

import '../data/api/api.dart';

class OfferSended {
  int? messageId;
  Offer? offer;
  User? user;
  DateTime? startDate;
  DateTime? endDate;

  OfferSended({
    this.messageId,
    this.offer,
    this.user,
    this.endDate,
    this.startDate,
  });

  OfferSended.fromJson(Map<String, dynamic> json) {
    messageId = json['message_id'];
    offer = Offer.fromJson(json['offer']);
    user = User.fromJson(json['user']);
    startDate = DateTime.tryParse(json['start_date']);
    endDate = DateTime.tryParse(json['end_date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message_id'] = messageId;
    data['offer'] = offer?.id;
    data['user'] = user?.id;
    data['start_date'] = startDate?.toIso8601String();
    data['end_date'] = endDate?.toIso8601String();
    return data;
  }
}
