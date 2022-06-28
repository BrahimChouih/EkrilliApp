import 'package:ekrilli_app/models/house.dart';
import 'package:ekrilli_app/models/user.dart';

class Offer {
  int? id;
  String? status;
  double? pricePerDay;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? createdAt;
  bool? rated;
  late House house;
  User? user;

  Offer(
      {this.id,
      this.status,
      this.pricePerDay,
      this.startDate,
      this.endDate,
      this.createdAt,
      this.rated,
      required this.house,
      this.user});

  Offer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    pricePerDay = json['price_per_day'];

    if (json['start_date'] != null) {
      startDate = DateTime.parse(json['start_date']);
    }
    if (json['end_date'] != null) {
      endDate = DateTime.parse(json['end_date']);
    }
    if (json['created_at'] != null) {
      createdAt = DateTime.parse(json['created_at']);
    }

    rated = json['rated'];
    house = House.fromJson(json['house']);
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['price_per_day'] = pricePerDay;
    data['start_date'] = startDate?.toIso8601String();
    data['end_date'] = endDate?.toIso8601String();
    data['rated'] = rated;
    data['house'] = house.id;
    data['user'] = user?.id;
    return data;
  }
}
