import 'package:flutter/material.dart';
import 'package:main29/screen/json_api_call.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: JsonApiCall(),
    );
  }
}
