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
