import 'dart:convert';

import 'package:flutter/material.dart';
import 'model/model.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late final Future<List<Bank>> info;

  @override
  void initState() {
    // todo: 이 부분 다시보기
    fetchData().then((val) {
      setState(() {
        info = val as Future<List<Bank>>;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: info,
          builder: (context, snapshot) {
            print(snapshot.data);
            if(snapshot.hasData) {
              return Column(
                children: [
                  // Text('${snapshot.data?.id}'),
                  // Text('${snapshot.data?.fullName}'),
                  // Text('${snapshot.data?.account}'),
                  // Text('${snapshot.data?.balance}'),
                ],
              );
            } else if(snapshot.hasError) {
              // return Text("${snapshot.hasError}");
              return Text('hasError');
            }
            return CircularProgressIndicator();
          },
        )
      ),
    );
  }
}

Future<List<Bank>> fetchData() async {
  final response = await http.get(Uri.parse('https://my.api.mockaroo.com/first_test.json?key=6745d5e0'));
  if(response.statusCode == 200) {
    // return Bank.fromJson(json.decode(response.body));
    var bank = bankFromJson(json.decode(response.body));
    return bank;
  } else {
    throw Exception('정보를 불러오는데 실패하였습니다');
  }
}