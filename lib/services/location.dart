import 'package:geolocator/geolocator.dart';

class Location {
  Position _position;
  double latitude;
  double longitude;
  String err;

  // ask the device for the current location, use low accuracy to save
  // battery power. return an error if we get one.
  Future<void> getCurrentLocation() async {
    try {
      _position = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      latitude = _position.latitude;
      longitude = _position.longitude;
    } on Exception catch (e) {
      print(e);
      err = e.toString();
    }
    print(_position);
  }
}
