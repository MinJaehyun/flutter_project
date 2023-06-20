import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:main18/2.single_object_call_api/model/model.dart';

void main() => runApp(const MyApp());

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
  late Future<Bank> info;

  @override
  void initState() {
    super.initState();
    // note: initState 는 앱 실행 시 한 번 사용되므로 setState() 할 필요 없다
    info = _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: FutureBuilder<Bank>(
        future: info,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('id: ${snapshot.data?.id}'), // {id:'xxx', ...}
                  Text('fullName: ${snapshot.data?.fullName}'),
                  Text('account: ${snapshot.data?.account}'),
                  Text('balance: ${snapshot.data?.balance}'),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.hasError}");
          }
          return CircularProgressIndicator();
        },
      )),
    );
  }

  // note: 1 rows
  Future<Bank> _fetchData() async {
    String url = 'https://my.api.mockaroo.com/one_rows_schema.json?key=6745d5e0';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Bank.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load bank');
    }
  }
}

/* note: 흐름과 기능
1. initState() 로 api 즉시 호출하고
2. FutureBuilder 사용하여 future 의 속성으로 info 를 UI에 나타낸다
3. api 호출하므로 snapshot.connectionState 연결이 완료 됐는지 확인하고
4. 단일 객체의 데이터를 가져오므로 snapshot.data? 의 속성을 가져온다
5. 데이터가 없으면 hasError 를 발생하고, 가져오는 중이면 로딩 띄운다
6. 구문분석한 url 을 get 으로 가져오고, 상태가 200이면 잘 가져왔으므로 model 의 Bank class
 의 fromJson 을 통해서 단일 json data 를 넣어 단일 객체로 decode 한다
* */