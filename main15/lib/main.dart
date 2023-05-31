import 'package:flutter/material.dart';
import 'package:main15/model/animal.dart';
import 'package:main15/pages/animal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  // note: 변수 데이터 3개 설정
  static List<String> animalName = [
    'Bear',
    'Camel',
    'Deer',
    'Fox',
    'Kangaroo',
    'Koala',
    'Lion',
    'Tiger',
  ];
  static List<String> location = [
    'forest and mountain',
    'dessert',
    'forest',
    'snow mountain',
    'Australia',
    'Australia',
    'Africa',
    'Korea',
  ];

  // todo: 이미지 경로 중복되는 부분 개선하기
  // 참고: https://pub.dev/packages/introduction_screen - example - Widget _buildImage 검색
  static List<String> imagePath = [
    'assets/images/bear.png',
    'assets/images/camel.png',
    'assets/images/deer.png',
    'assets/images/fox.png',
    'assets/images/kangaroo.png',
    'assets/images/koala.png',
    'assets/images/lion.png',
    'assets/images/tiger.png',
  ];

  // todo: generate 설정
  // final growableList2 = List<int>.generate(3, (int index) => index * index, growable: true);
  final growableList = List<Animal>.generate(imagePath.length, (index) => Animal(animalName[index], location[index], imagePath[index]), growable: true);

  // testing...
  // Widget _buildImage(String assetName, [double width = 350]) {
  //   return Image.asset('assets/$assetName', width: width);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('list view', style: TextStyle(color: Colors.redAccent)),
        backgroundColor: Colors.white,
        elevation: 0.1,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: growableList.length,
                itemBuilder: (context, index) {
                  // print(growableList[index]);
                  // todo: 아래 var 개선하기
                  var animalListIndex = growableList[index];
                  return Card(
                    child: ListTile(
                      onTap: () {
                        // note: 새로운 페이지에서 전체 정보 나타내기
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return AnimalPage(animal: animalListIndex);
                            },
                          ),
                        );
                      },
                      title: Text(animalListIndex.animalName),
                      subtitle: Text(animalListIndex.location),
                      leading: Image.asset(animalListIndex.imagePath),
                      trailing: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AnimalPage(animal: animalListIndex),
                              ),
                            );
                          },
                          icon: Icon(Icons.info, color: Colors.blue)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
