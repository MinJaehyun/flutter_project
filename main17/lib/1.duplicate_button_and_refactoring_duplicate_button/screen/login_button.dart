import 'package:flutter/material.dart';
import 'package:main17/1.duplicate_button_and_refactoring_duplicate_button/help/my_button.dart';

class LoginButtons extends StatelessWidget {
  const LoginButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Login SNS'),
        centerTitle: true,
        elevation: 0.2,
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // note: 중복을 개선한 버튼
            MyButton(
              // note: 위젯 형태로 넣을 거면 아래처럼 처리하고
              image: Image.asset('assets/images/glogo.png'),
              // note: Color 형태로 넣을 거면 아래처럼 처리한다
              color: Colors.white,
              radius: 4.0,
              loginText: const Text('Login with Google', style: TextStyle(color: Colors.black87, fontSize: 15)),
            ),
            MyButton(
              image: Image.asset('assets/images/flogo.png'),
              // note: 에러 시, color: Colors.blue[900], 아래로 해결
              color: Colors.blue.shade900,
              radius: 4.0,
              loginText: const Text('Login with Facebook', style: TextStyle(color: Colors.white)),
            ),

            // note: 중복된 버튼 - 중복된 부분:
            // 1. onPressed: , // () {} 이 부분을 개선할 예정이지만 아직 미구현이므로 넣지 않는다
            // 2. style: ElevatedButton.styleFrom(backgroundColor: ), // Colors.green[600] 이 부분을 타입으로 개선할 예정
            // 3. const Text('Login with Email', style: TextStyle(color: Colors.white)), // Text 위젯 전체를 받아 개선할 예정
            // 4. 아래에는 없지만 image: Image.asset('assets/main17/flogo.png'), 을 위젯 타입으로 개선할 예정
            // 5. 아래에는 없지만 radius: 4.0 설정을 할 수도 있다
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green[600]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.email),
                  const Text('Login with Email', style: TextStyle(color: Colors.white)),
                  Opacity(opacity: 0.0, child: Image.asset('assets/main17/flogo.png')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
