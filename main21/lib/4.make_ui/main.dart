import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:main21/4.make_ui/data/my_location.dart';
import 'package:main21/4.make_ui/screens/weather_screen.dart';

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
    MyLocation myLocation = MyLocation();
    await myLocation.getCurrentLocation();
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;

    String url = 'https://api.openweathermap.org/data/2.5/weather?lat=${latitude3}&lon=${longitude3}&appid=${apiKey}&units=metric';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
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