import 'dart:async';
import '../models/user_location.dart';
import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  final StreamController<UserLocation> _locationStreamController =
      StreamController<UserLocation>();

  Stream<UserLocation> get locationStream => _locationStreamController.stream;

  LocationService() {
    location.requestPermission().then((permissionStatus) {
      if (permissionStatus == PermissionStatus.granted) {
        location.onLocationChanged.listen((locationData) {
          // do nothing if already disposed
          if (_isDisposed) {
            return;
          } else {
            _locationStreamController.add(UserLocation(
              latitude: locationData.latitude!.toDouble(),
              longitude: locationData.longitude!.toDouble(),
            ));
          }
        });
      }
    });
  }

  bool _isDisposed = false;
  void dispose() {
    _locationStreamController.close();
    _isDisposed = true;
  }
}
