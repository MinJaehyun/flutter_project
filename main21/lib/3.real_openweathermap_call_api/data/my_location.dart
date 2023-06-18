import 'package:geolocator/geolocator.dart';

class MyLocation {
  // 변수
  double? latitude2;
  double? longitude2;
  // 생성자

  // 메서드
  Future<void> getCurrentLocation() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // print(position);
    latitude2 = position.latitude;
    longitude2 = position.longitude;
  }
}