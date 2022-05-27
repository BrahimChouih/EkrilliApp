import 'package:ekrilli_app/models/offer.dart';

class OfferHelper {
  static double getTotalPrice({
    required DateTime startDate,
    required DateTime endDate,
    required double pricePerDay,
  }) {
    int days = (endDate.day + (endDate.month * 30) + (endDate.year * 365)) -
        (startDate.day + (startDate.month * 30) + (startDate.year * 365));
    return pricePerDay * days;
  }
}
