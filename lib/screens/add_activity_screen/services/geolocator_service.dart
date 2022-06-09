import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  Future<Position> getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      return Position(
          accuracy: 0.0,
          longitude: 28.898272,
          latitude: 41.047867,
          timestamp: null,
          altitude: 1,
          heading: 1,
          speed: 1,
          speedAccuracy: 0.0);
    }
    return await Geolocator.getCurrentPosition();
  }
}
