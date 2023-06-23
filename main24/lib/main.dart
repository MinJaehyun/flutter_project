import 'package:flutter/material.dart';
import 'package:main24/painter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatApp(),
    );
  }
}

class ChatApp extends StatefulWidget {
  const ChatApp({super.key});

  @override
  State<ChatApp> createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ===================== 배경 이미지 =====================
          Positioned(
            child: Container(
              child: Image.asset(
                'assets/images/background.jpg',
                fit: BoxFit.fill,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          ),
          // ===================== 메인 환영 문구 =====================
          Positioned(
            top: 50,
            child: Container(
              padding: EdgeInsets.only(top: 10, left: 30),
              child: RichText(
                text: TextSpan(
                  text: 'Multi N-Back',
                  style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold, fontSize: 25, letterSpacing: 0.5),
                  children: [
                    TextSpan(text: ' Game with', style: TextStyle(color: Colors.black54)),
                    TextSpan(text: ' Chat!', style: TextStyle(color: Colors.pinkAccent, letterSpacing: 0.5)),
                  ],
                ),
              ),
            ),
          ),
          // ===================== 로그인/회원가입 입력창 =====================
          Positioned(
            // duration: Duration(seconds: 1),
            top: 100,
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              height: isLogin ? 220 : 310,
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [
                BoxShadow(
                  color: Colors.yellow.withOpacity(0.5),
                  // note: 그림자 테두리가 흐려지고 크기가 더 커지면서 색상이 밝아지지만
                  blurRadius: 15,
                  // note: 그림자 효과의 반경, 설정 값이 높을 수록 넓어진다
                  spreadRadius: 5,
                ),
              ]),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // ===================== login/signup =====================
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // NOTE: LOGIN
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isLogin = true;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    color: isLogin ? Palette.activeColor : Palette.textColor1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                if (isLogin)
                                  Container(
                                    height: 3,
                                    width: 60,
                                    decoration: BoxDecoration(color: Colors.orange),
                                  ),
                              ],
                            ),
                          ),
                          // NOTE: SIGNUP
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isLogin = false;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  'SIGNUP',
                                  style: TextStyle(
                                    color: isLogin ? Palette.textColor1 : Palette.activeColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                if (!isLogin)
                                  Container(
                                    height: 3,
                                    width: 70,
                                    decoration: BoxDecoration(color: Colors.orange),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ===================== TextFormField =====================
                    Container(
                      // margin: EdgeInsets.only(top: 5),
                      margin: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          // ===================== Email =====================
                          TextFormField(
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Palette.textColor1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Palette.textColor1),
                              ),
                              labelText: 'Email',
                              // note: 입력창 크기 줄임
                              contentPadding: EdgeInsets.all(10),
                              prefixIcon: Icon(Icons.mail),
                              hintText: '@을 포함한 이메일을 입력해 주세요.',
                            ),
                          ),
                          SizedBox(height: 10),
                          // ===================== Password =====================
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Palette.textColor1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Palette.textColor1),
                              ),
                              labelText: 'Password',
                              contentPadding: EdgeInsets.all(10),
                              prefixIcon: Icon(Icons.password),
                              hintText: 'Password 를 입력해 주세요.',
                            ),
                          ),
                          SizedBox(height: 10),
                          // ===================== Name =====================
                          if (!isLogin)
                          TextFormField(
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              labelText: 'Name',
                              contentPadding: EdgeInsets.all(10),
                              prefixIcon: Icon(Icons.person),
                              hintText: '이름을 입력해 주세요.',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // ===================== LoginBtn =====================
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            top: isLogin ? 290 : 370,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                // duration: Duration(seconds: 1),
                // note: Postioned 위젯 내에서 Container 안에 또다른 Container 를 넣는 방법
                padding: EdgeInsets.all(10),
                height: 60,
                width: 160,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 3,
                      blurRadius: 2,
                      color: Colors.black.withOpacity(0.3),
                    )
                  ],
                ),
                child: Container(
                  child: IconButton(
                    onPressed: () {
                      // todo: login 성공하면 새페이지로 이동하기
                    },
                    icon: Icon(Icons.login),
                    // style: IconButton.styleFrom(),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.yellow[500],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(spreadRadius: 3, blurRadius: 2, color: Colors.black.withOpacity(0.3), offset: Offset(0, 9))],
                  ),
                ),
              ),
            ),
          ),
          // ===================== Google Btn =====================
          Positioned(
            top: 550,
            left: 0,
            right: 0,
            child: Container(
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // todo: 클릭 시, 구글로 로그인
                    },
                    icon: Icon(Icons.add),
                    label: Text('Google'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white70,
                      minimumSize: Size(150, 40),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // todo: 클릭 시, 페이스북으로 로그인
                    },
                    icon: Icon(Icons.add),
                    label: Text('FaceBook'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      minimumSize: Size(150, 40),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// note: Text('${MediaQuery.of(context).size.width}') 는 가로 전체 크기를 의미한다.
// note: how to check MediaQuery size: Text('${MediaQuery.of(context).size.width}')
/* 로그인/회원가입에서
Container 크기는 변경되므로 AnimatedContainer 처리하고,
Positioned 위치는 변경되지 않으므로 애니메이션 처리하지 않는다.

* 로그인 버튼은
Positined 위치가 변경되므로 (top: isLogin ? 290 : 370) AnimatedPositined 처리하고,
Container 크기는 변경되지 않으므로 애니메이션 처리하지 않는다.
*/
