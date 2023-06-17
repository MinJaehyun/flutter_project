import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

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

  // note: 위도, 경도 가져오기 위한 패키지 설정
  void getLocation() async {
    // note: 권한 요청
    await Geolocator.requestPermission();
    // note: getCurrentPosition 는 Future<Position> 이므로 await 처리하고, 앞에 position 은 Position 타입이지만 Future 는 아니므로 Future<Postion> 으로 적지 않는다고 이해함
    // Position 종류: longitude, latitude, timestamp, accuracy, altitude, heading, speed, speedAccuracy
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
  }

  void fetchData() async{
    // 샘플 사이트는 사용
    http.Response response = await http.get(Uri.parse('https://samples.openweathermap.org/data/2.5/weather?q=London&appid=b1b15e88fa797225412429c1c50c122a1'));
    if(response.statusCode == 200) {
      // note: json data
      // print(response.body);
      var jsonData = jsonDecode(response.body);
      // note: decodeData
      print(jsonData);
      // note: 앱 실행 즉시 데이터를 받기위한 설정: initState() 에서 처리하고 있으면 setState 처리할 필요 없다 생각했지만 아니라,
      // note: 앱 실행 즉시 처리하는건 맞지만, 화면을 rebuild 하지 않았다. rebuild 하기 위해서는 setState 로 변경해야 한다.
      setState(() {
        products = jsonData;
        // print(products.runtimeType);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetLocation'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // note: 버튼을 실행하면 getLocation 정보를 가져온다
                getLocation();
              },
              child: Text('GetLocation btn'),
            ),
            Divider(),
            Column(
              children: [
                Text('weather: ${products?['weather'][0]['description']}'),
                Text('wind: ${products?['wind']['speed']}'),
                Text('id: ${products?['weather'][0]['id']}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
