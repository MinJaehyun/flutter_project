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
    info = _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: FutureBuilder<List<Bank>>(
        future: info,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return DataTable(
                    // columns: [
                    //   DataColumn(label: Text('id')),
                    //   DataColumn(label: Text('fullName')),
                    //   DataColumn(label: Text('account')),
                    //   DataColumn(label: Text('balance')),
                    // ],
                    columns: [
                      DataColumn(label: Text('')),
                      DataColumn(label: Text('')),
                      DataColumn(label: Text('')),
                      DataColumn(label: Text('')),
                    ],

                    rows: [
                      DataRow(
                        selected: true,
                        cells: [
                          DataCell(Text('${snapshot.data?[index].id}')),
                          DataCell(Text('${snapshot.data?[index].fullName}')),
                          DataCell(Text('${snapshot.data?[index].account}')),
                          DataCell(Text('${snapshot.data?[index].balance}')),
                        ],
                      ),
                    ],
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

  // note: 10 rows
  Future<List<Bank>> _fetchData() async {
    String url = 'https://my.api.mockaroo.com/first_test.json?key=6745d5e0';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return parseBanks(response.body);
    } else {
      throw Exception('Failed to load bank');
    }
  }

  // note: 다중 json data 를 map 돌면서 하나씩 fromJson 에 넣는 방법
  // todo: model 에 bankFromJson(str) 넣어도 될 듯 ?
  List<Bank> parseBanks(String responseBody) {
    List<dynamic> body = jsonDecode(responseBody);
    List<Bank> allBank = body.map((dynamic item) => Bank.fromJson(item)).toList();
    print('allBank: $allBank');
    return allBank;
  }
}

/* note: DataTable 사용법
========================================================
1. 첫 줄 가로에 들어갈 내용을 설정
DataTable(
  columns: [
    DataColumn(label: Text('id')),
    DataColumn(label: Text('fullname')),
    DataColumn(label: Text('account')),
    DataColumn(label: Text('balance')),
  ]
)

========================================================
2. 세로에 들어갈 내용은 하나의 객체를 순서대로 넣기
  rows: [
    DataRow(
      selected: true, // 행이 선택 되도록 함
      cells: [

        DataCell(Text('58')),
        DataCell(Text('james')),
        DataCell(
          Text('58'),
          showEditIcon: true,  // icon 을 편집할 수 있다
        ),
        DataCell(Text('2')),
      ]
  ]
* */