import 'package:flutter/material.dart';
import 'package:main16/second/screen/dice_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        // primarySwatch: Colors.deepPurple,
      ),
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  TextEditingController textController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: textController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  label: Text('Enter ID: krism01'),
                ),
                onSubmitted: (String value) async {
                  await showDialog<void>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('success login'),
                        content: Text('You typed "$value", which has length ${value.characters.length}.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  label: Text('Enter Password: 1234'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // todo: 입력값 확인하고 맞으면 Dice 패이지 띄우기
                  if (textController.text == 'krism01' && passwordController.text == '1234') {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => DicePage()));
                  }
                },
                child: Text('로그인'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ★★★ note: TextField 와 TextFormField 의 차이점 ?
1. TextField 는 Form 위젯을 사용하지 않고, TextFormField 는 Form 위젯을 사용한다
2. TextField 는 Form 이 없어서 validation 기능을 사용할 수 없는데, 대신 입력받은 text 를 controller.text 로
 접근하여 validation 기능을 구현할 수 있다.
*/

/* 빼먹은 부분:
1. keyboardType: TextInputType.emailAddress
2. obscureText: true,
3. 로그인 성공 시, 하단에 로그인에 성공하셨습니다 메시지 띄우기
4. 입력창 외부 클릭 시 키보드 내리기: FocusScope.of(context).unfocus();
5. 키보드가 화면을 가릴 시 에러 나는데, 이를 스크롤 기능 추가하여 올릴 수 있게 만들기
6. Theme 위젯 사용하여 Column 내 TextField 들에 input 에 라벨 색상 설정
7.
* */
