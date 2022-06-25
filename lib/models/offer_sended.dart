import 'package:ekrilli_app/models/city.dart';
import 'package:ekrilli_app/models/message.dart';
import 'package:ekrilli_app/models/offer.dart';
import 'package:ekrilli_app/models/user.dart';

import '../data/api/api.dart';

class OfferSended {
  Message? message;
  DateTime? startDate;
  DateTime? endDate;

  OfferSended({
    this.message,
    this.endDate,
    this.startDate,
  });

  OfferSended.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      message = Message.fromJson(json['message']);
    }

    startDate = DateTime.tryParse(json['start_date']);
    endDate = DateTime.tryParse(json['end_date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message?.id;

    data['start_date'] = startDate?.toIso8601String();
    data['end_date'] = endDate?.toIso8601String();
    return data;
  }
}
