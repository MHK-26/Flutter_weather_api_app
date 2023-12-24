import 'package:location/location.dart';

class LocationHelper {
  double? longitude;
  double? latitude;

  Future<void> getCurrentLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionStatus;
    LocationData _locationData;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
      _permissionStatus = await location.hasPermission();
      if (_permissionStatus == PermissionStatus.denied) {
        _permissionStatus = await location.requestPermission();
      }
      if (_permissionStatus != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    longitude = _locationData.longitude;
    latitude = _locationData.latitude;
  }
}
