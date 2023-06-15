import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:main18/3.multi_object_call_api/model/model.dart';

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
  late Future<List<Bank>> info;

  @override
  void initState() {
    super.initState();
    // note: initState 는 초기화 하면서 설정가져오는 것이므로 setState() 할 필요없다
    info = _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: FutureBuilder<List<Bank>>(
        future: info,
        builder: (context, AsyncSnapshot snapshot) {
          // note: 1row test
          // print('test: ${snapshot.data?.id}');

          // note: 10rows test
          // var test = snapshot.data;
          // for(Map x in test) {
          //   print(x);
          // }

          // note: info
          print('info: ${info}');
          print(snapshot.data);

          if (snapshot.hasData) {
            return Center(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${snapshot.data?[index].id}'), // [{id:'xxx', ...}, {...}]
                        Text('${snapshot.data?[index].fullName}'),
                        Text('${snapshot.data?[index].account}'),
                        Text('${snapshot.data?[index].balance}'),
                      ],
                    ),
                  );
                },
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

  // fixme: info 를 불러오지 못하고 있으므로 아래 살펴보기
  Future<List<Bank>> _fetchData() async {
    // note: 1 rows
    String url = 'https://my.api.mockaroo.com/one_rows_schema.json?key=6745d5e0';

    // note: 10 rows
    // String url = 'https://my.api.mockaroo.com/first_test.json?key=6745d5e0';

    final response = await http.get(Uri.parse(url));

    // note: response.body 테스트 방법
    // print('response: ${response.body}');

    if (response.statusCode == 200) {
      // note: 1 row
      // return Bank.fromJson(jsonDecode(response.body));

      // note: 10 rows
      // return Bank.fromJson(jsonDecode(response.body));
      return parseBanks(response.body);
    } else {
      throw Exception('Failed to load bank');
    }
  }

  List<Bank> parseBanks(String responseBody) {
    List<dynamic> body = jsonDecode(responseBody);
    List<Bank> allBank = body.map((dynamic item) => Bank.fromJson(item)).toList();
    print('allBank: $allBank');
    return allBank;

    // List<dynamic> body = json.decode(response.body);
    // List<Info> allInfo =
    // body.map((dynamic item) => Info.fromJson(item)).toList();

    // return bankFromJson
  }
}

/*
Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return parsePhotos(response.body);
}

List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

 */