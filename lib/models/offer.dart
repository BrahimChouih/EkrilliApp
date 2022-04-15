import 'package:ekrilli_app/models/house.dart';
import 'package:ekrilli_app/models/user.dart';

class Offer {
  int? id;
  String? status;
  int? totalPrice;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? createdAt;
  House? house;
  User? user;

  Offer(
      {this.id,
      this.status,
      this.totalPrice,
      this.startDate,
      this.endDate,
      this.createdAt,
      this.house,
      this.user});

  Offer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    totalPrice = json['total_price'];
    startDate = DateTime.parse(json['start_date']);
    endDate = DateTime.parse(json['end_date']);
    createdAt = DateTime.parse(json['created_at']);
    house = House.fromJson(json['house']);
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['total_price'] = totalPrice;
    data['start_date'] = startDate?.toIso8601String();
    data['end_date'] = endDate?.toIso8601String();
    data['house'] = house?.id;
    data['user'] = user?.id;
    return data;
  }
}
