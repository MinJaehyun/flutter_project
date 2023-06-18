import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({required this.products});
  final products;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
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
            Column(
              children: [
                Text('weather: ${widget.products?['weather'][0]['description']}'),
                Text('wind: ${widget.products?['wind']['speed']}'),
                Text('id: ${widget.products?['weather'][0]['id']}'),
                Text('temp: ${(widget.products?['name'])}'),
                Text('temp: ${((widget.products?['main']['temp']).round())}'),
              ],
            ),
          ],
        ),
      ),
    );;
  }
}

// todo: widget.products 로 UI 를 구성하는 것과, State 이하에 변수로 설정하여 UI 에서 가져오는 방법의 차이점은 ?
