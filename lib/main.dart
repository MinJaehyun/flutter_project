import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              // 카드 높이
              height: 250,
              child: PageView(
                // note: 마지막 페이지 끝에 애니메이션 튕김 처리됨
                physics: BouncingScrollPhysics(),
                children: [
                  buildContainer(firstColor: Colors.grey, secondColor: Colors.white, mindState: '우울함'),
                  buildContainer(firstColor: Colors.orange, secondColor: Colors.yellow, mindState: '행복함'),
                  buildContainer(firstColor: Colors.blue, secondColor: Colors.green, mindState: '상쾌함'),
                  buildContainer(firstColor: Colors.red, secondColor: Colors.black, mindState: '화남'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildContainer({required firstColor, required secondColor, required String mindState}) {
    return Container(
      margin: EdgeInsets.all(24.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [firstColor, secondColor],
        ),
      ),
      child: Text(
        mindState,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
