import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.blueAccent
              ),
              child: Text('content'),
            ),
            IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    // note: 버튼 비활성화 방법
                    onPressed: null,
                    child: Text('btn set'),
                    style: ElevatedButton.styleFrom(
                      // note: 비활성화 된 버튼 색상 및 투명도 지정하는 방법
                      // onSurface: Colors.blueAccent, 대신 현재는 아래를 권장하고 있다.
                      disabledForegroundColor: Colors.blueAccent.withOpacity(0.38),
                      disabledBackgroundColor: Colors.blueAccent.withOpacity(0.12),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: Text('OutlinedBtn'),
                    style: OutlinedButton.styleFrom(
                      // minimumSize: Size(140, 40)
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Column(
              children: [
                ButtonBar(
                  children: [
                    ElevatedButton(
                      // note: 버튼 비활성화 방법
                      onPressed: null,
                      child: Text('btn set'),
                      style: ElevatedButton.styleFrom(
                        // note: 비활성화 된 버튼 색상 및 투명도 지정하는 방법
                        // onSurface: Colors.blueAccent, 대신 현재는 아래를 권장하고 있다.
                        disabledForegroundColor: Colors.blueAccent.withOpacity(0.38),
                        disabledBackgroundColor: Colors.blueAccent.withOpacity(0.12),
                        minimumSize: Size(114, 35),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: Text('OutlinedBtn'),
                      style: OutlinedButton.styleFrom(
                        // minimumSize: Size(140, 40)
                      ),
                    ),
                  ],
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
