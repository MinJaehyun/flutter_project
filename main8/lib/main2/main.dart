import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyPage(),
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const iconSize = 50.0;
    return SafeArea(
      child: Scaffold(
        // note: MainAxisSize.min 속성 특징
        // body: Container(
        //   color: Colors.yellow,
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       Icon(Icons.star),
        //       Icon(Icons.star),
        //       Icon(Icons.star),
        //     ],
        //   ),
        // ),

        // note: IntrinsicWidth() 위젯 특징
        // body: Center(
        //   child: IntrinsicWidth(
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.stretch,
        //       children: [
        //         ElevatedButton(onPressed: (){}, child: Text('test1')),
        //         ElevatedButton(onPressed: (){}, child: Text('test2 test2')),
        //         ElevatedButton(onPressed: (){}, child: Text('test3 test3 test3')),
        //       ],
        //     ),
        //   ),
        // ),

        // note: Stack 와 Positioned 위젯 내에 속성의 특징
        // body: Container(
        //   color: Colors.yellow,
        //   child: Stack(
        //     fit: StackFit.expand,
        //     children: [
        //       Positioned(
        //         // height: 0,
        //         // width: 0,
        //         // top: 0,
        //         child: Icon(Icons.star, size: 150),
        //       ),
        //       Positioned(
        //         height: 1250,
        //         width: 750,
        //         child: Icon(Icons.phone),
        //       ),
        //     ],
        //   ),
        // ),

        // note: 상위/하위 값을 추측하고 싶지 않다면 ?
        // note: 최상단에 iconSize 설정
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Material(color: Colors.yellowAccent),
                Positioned(
                  top: 0,
                  child: Icon(Icons.star, size: iconSize),
                ),
                Positioned(
                  top: constraints.maxHeight - iconSize,
                  left: constraints.maxWidth - iconSize,
                  child: Icon(Icons.phone, size: iconSize),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
