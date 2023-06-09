import 'package:flutter/material.dart';
import 'dart:io';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(child: MyWidget()),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // note: 흐름 1.
    showData();
    return Text('2.sync_sleep');
  }
}

// note: 흐름 2.
void showData() {
  startTask();
  accessData();
  fetchData();
}

// note: 흐름 3.
void startTask() {
  String info1 = '시작';
  debugPrint(info1);
}

// note: 흐름 4.
void accessData() {
  Duration time = const Duration(seconds: 5);
  sleep(time);
  String info2 = '데이터 접속 중';
  debugPrint(info2);
}

// note: 흐름 5.
void fetchData() {
  String info3 = '잔액은 8,500만원 입니다.';
  debugPrint(info3);
}