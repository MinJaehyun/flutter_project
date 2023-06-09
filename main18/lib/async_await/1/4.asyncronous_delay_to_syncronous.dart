import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // note: 흐름 1.
    showData();
    return MaterialApp(
      home: Scaffold(body: Text('4.async_await')),
    );
  }
}

void showData() async {
  // note: 흐름 2.
  startTask();
  // note: 흐름 3. Future.delayed 된 비동기 방식을 await 처리하여 동기 방식으로 변환하였으므로 실행순서를 뒤로 미루지 않는다
  int account = await accessData();
  // note: 흐름 4.
  fetchData(account);
}

void startTask() {
  String info1 = '시작';
  debugPrint(info1);
}

Future<int> accessData() async {
  int account = 0;
  Duration time = const Duration(seconds: 10);
  await Future.delayed(time, () {
    account = 8500;
    debugPrint(account.toString());
  });

  return account;
}

void fetchData(int account) {
  String info3 = '잔액은 $account만원 입니다.';
  debugPrint(info3);
}

// note: sleep(duration) 함수는 인자를 duration 만 받을 수 있는 동기적 함수이므로, 다른 인자를 넣을 수 없어 다양하게 처리할 수 있는 Future.delayed 에 await 처리하여 사용한다