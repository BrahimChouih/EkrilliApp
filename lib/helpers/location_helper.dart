import 'package:geolocator/geolocator.dart';

class LocationHelper {
  Future<Position?> getCurrentLocation() async {
    //// permission
    await hasLocationPermission();

    //// Location service
    // await isLocationServiceEnabled();

    Position? position = await Geolocator.getCurrentPosition();
    return position;
  }

  Future<bool> hasLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    return true;
  }

  Future<bool> isLocationServiceEnabled() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
    }
    return true;
  }
}
