import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:main21/3.real_openweathermap_call_api/data/my_location.dart';
import 'package:main21/3.real_openweathermap_call_api/screens/weather_screen.dart';

const apiKey = '1ae4e47decbc93f14c67ba3b4049e59b';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetLocation(),
    );
  }
}

class GetLocation extends StatefulWidget {
  const GetLocation({super.key});

  @override
  State<GetLocation> createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  Map<String, dynamic>? products;
  double? latitude3;
  double? longitude3;

  void getLocation() async {
    // 위도와 경도 가져오기 위해 변수 설정하기, 그 전에 이를 다른 파일로 분리하기
    // 다른 파일에서 인스턴스로 가져오기 위한 설정하기
    MyLocation myLocation = MyLocation();
    await myLocation.getCurrentLocation();
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;

    // 위도와 경도와 apiKey를 적용하여 실제 openweathermap 에 currentUserLocation 정보를 가져오기
    https: //api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
    String url = 'https://api.openweathermap.org/data/2.5/weather?lat=${latitude3}&lon=${longitude3}&appid=${apiKey}&units=metric';
    http.Response response = await http.get(Uri.parse(url));
    // print(response.body);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      // print(jsonData);
      setState(() {
        products = jsonData;
      });
    }

    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return WeatherScreen(products: products);
    }));
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

// note: 69: 같은 화면을 또 나타내고 있다 - 첫 페이지에 로딩 띄우고, initState 에 의해 weather_screen 을 띄우도록 설정하였다
// note: weather_screen 생성자 맞게 설정
// note: 최초 Scaffold 페이지에 로딩 띄워서, null 값이 나타나는 화면 제거함
