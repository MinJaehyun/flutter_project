import 'package:flutter/material.dart';
import 'package:main25/painter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:main25/screens/chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

bool shouldUseFirestoreEmulator = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (shouldUseFirestoreEmulator) {
    // note: Ideal time to initialize
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // note: MaterialApp 이하에 StreamBuilder 사용한 이유? authStateChanges 존재유무 판별하여 로그인화면을 보여주거나 로그인후 화면인 chat_screen을 보여주기 위해서다
      home: StreamBuilder(
        // stream: 인증 확인을 위해 authStateChanges 또는 idTokenChanges 를 이용하여 판별
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ChatScreen();
          }
          return ChatApp();
        },
      ),
    );
  }
}

class ChatApp extends StatefulWidget {
  const ChatApp({super.key});

  @override
  State<ChatApp> createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  TextEditingController _loginEmailController = TextEditingController();
  TextEditingController _loginPasswordController = TextEditingController();
  TextEditingController _signupEmailController = TextEditingController();
  TextEditingController _signupPasswordController = TextEditingController();
  TextEditingController _signupNameController = TextEditingController();

  // note: 앱 실행할 때마다 GlobalKey 생성
  final _formKey = GlobalKey<FormState>();
  bool isLogin = true;
  String? userEmail;
  String? userPassword;
  String? userName;
  bool _saving = false;

  // note: 함수명은 동사 또는 동명사로 지정한다
  void _tryValidation() {
    // note: final GlobalKey _formKey 로 설정하면 .validate 속성이 없다
    try {
      final isValid = _formKey.currentState!.validate();
      if (isValid) {
        _formKey.currentState!.save();
      }
    } catch (e) {
      print(e);
    }
    // print(userEmail);
    _loginEmailController.clear();
    _loginPasswordController.clear();
    _signupEmailController.clear();
    _signupPasswordController.clear();
    _signupNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    print('authStateChanges: ${FirebaseAuth.instance.authStateChanges()}');
    // print(MediaQuery.of(context).size.width);
    // note: 로그인/회원가입 버튼 클릭 시, setState 없이 값이 저장됐으므로 build 이하 내용은 실행되지 않는다 (print(userName);), 고로 함수 클릭한 시점에 print 테스트하기

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Stack(
              children: [
                // ===================== 배경 이미지 =====================
                Positioned(
                  child: Container(
                    child: Image.asset(
                      'assets/images/background.jpg',
                      fit: BoxFit.fill,
                      width: double.infinity,
                      // note: landscope 와 portrait 상태를 처리하기 위해 직접 높이 조정
                      // note: 가로전환 시, 아래로 스크롤하려면 높이 설정하기 위해 SingleChildScrollView 설정도 추가함
                      height: 684,
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
                      // note: Name 창의 에러 메시지가 키보드에 가려질 시 설정하기
                      // padding: EdgeInsets.only(bottom: 20),
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
                          // ===================== LOGIN/SIGNUP TextFormField =====================
                          Container(
                            margin: EdgeInsets.all(20),
                            child: isLogin
                                // ===================== LOGIN =====================
                                ? Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        // ===================== Email =====================
                                        TextFormField(
                                          controller: _loginEmailController,
                                          // note: onSaved 는 email 와 password 가 검증되지 않으면 email 값도 가져오지 못한다
                                          // note: onSaved 는 validate() 통과한 값만 가져올 수 있으므로, email 만을 정확히 입력하고 password 를 입력하지 않으면, 아예 입력창에 입력한 값을 가져올 수 없다
                                          onChanged: (value) {
                                            userEmail = value;
                                          },
                                          onSaved: (newValue) {
                                            userEmail = newValue;
                                          },
                                          validator: (value) {
                                            if (!value!.contains('@')) {
                                              return 'Please enter a valid email address';
                                            }
                                          },
                                          keyboardType: TextInputType.emailAddress,
                                          key: ValueKey(1),
                                          // note: autovalidateMode: , 기능은 ?
                                          decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              onPressed: _loginEmailController.clear,
                                              icon: Icon(Icons.clear),
                                              // note: tetsing... icon: userEmail?.length == 0 ? Icon(Icons.clear) : Opacity(opacity: 0),
                                            ),
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
                                          controller: _loginPasswordController,
                                          onChanged: (value) {
                                            userPassword = value;
                                          },
                                          onSaved: (newValue) {
                                            userPassword = newValue;
                                            // print(userEmail);
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty || value.length < 6) {
                                              return 'Please must be at least 6 characters long';
                                            }
                                            return null;
                                          },
                                          key: ValueKey(2),
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              onPressed: _loginPasswordController.clear,
                                              icon: Icon(Icons.clear),
                                            ),
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
                                      ],
                                    ),
                                  )
                                // ===================== SIGNUP =====================
                                : Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        // ===================== Email =====================
                                        TextFormField(
                                          controller: _signupEmailController,
                                          onChanged: (value) {
                                            userEmail = value;
                                          },
                                          onSaved: (newValue) {
                                            userEmail = newValue;
                                          },
                                          validator: (value) {
                                            if (!value!.contains('@')) {
                                              return 'Please enter a valid email address';
                                            }
                                          },
                                          keyboardType: TextInputType.emailAddress,
                                          key: ValueKey(3),
                                          // note: autovalidateMode: , 기능은 ?
                                          decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              onPressed: _signupEmailController.clear,
                                              icon: Icon(Icons.clear),
                                            ),
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
                                          controller: _signupPasswordController,
                                          onChanged: (value) {
                                            userPassword = value;
                                          },
                                          onSaved: (newValue) {
                                            userPassword = newValue;
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty || value.length < 6) {
                                              return 'Please must be at least 6 characters long';
                                            }
                                            return null;
                                          },
                                          key: ValueKey(4),
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              onPressed: _signupPasswordController.clear,
                                              icon: Icon(Icons.clear),
                                            ),
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
                                        TextFormField(
                                          controller: _signupNameController,
                                          onChanged: (value) {
                                            userName = value;
                                          },
                                          onSaved: (newValue) {
                                            userName = newValue;
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty || value.length < 4) {
                                              return 'Please enter at least 4 characters';
                                            }
                                            return null;
                                          },
                                          key: ValueKey(5),
                                          decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              onPressed: _signupNameController.clear,
                                              icon: Icon(Icons.clear),
                                            ),
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // ===================== LoginBtn/SignupBtn =====================
                AnimatedPositioned(
                  duration: Duration(seconds: 1),
                  top: isLogin ? 290 : 370,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
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
                          onPressed: () async {
                            // ===================== 회원 가입 =====================
                            if (!isLogin) {
                              _tryValidation();
                              setState(() {
                                _saving = true;
                              });
                              // note: 검증된 userEmail 와 userPassword 를 FirebaseAuth 에 저장
                              try {
                                // note: newUser 는 UserCredential
                                final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                  email: userEmail as String,
                                  password: userPassword as String,
                                );
                                // print(credential.user!.uid);
                                // note: firestore 이용하여 email 과 username 을 저장
                                FirebaseFirestore.instance.collection('user').doc(credential.user!.uid).set({
                                  'useremail': userEmail,
                                  'username': userName,
                                });

                                // note: validation 검증 및 login 검증되면 새 페이지로 이동하기
                                // note: 아래 삭제하여 2번 페이지 이동하는 현상 해결
                                // if (credential.user != null) {
                                //   Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                //     return ChatScreen();
                                //   }));
                                // }
                              } catch (e) {
                                print(e);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Please check email and password'),
                                    duration: Duration(seconds: 5),
                                  ),
                                );
                              }
                              // note: 회원 가입 실패 후ㅅ, 아래 코드 진행하여 로딩 중 문제 해결
                              setState(() {
                                _saving = false;
                              });
                            }
                            // ===================== 로그인 =====================
                            else {
                              _tryValidation();
                              setState(() {
                                _saving = true;
                              });
                              // note: login 접속하기 위한 기능 만들기
                              try {
                                final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: userEmail!,
                                  password: userPassword!,
                                );
                                // note: 아래 삭제하여 2번 페이지 이동하는 현상 해결
                                // if (credential.user != null) {
                                //   Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                //     return ChatScreen();
                                //   }));
                                // }
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  print('No user found for that email.');
                                } else if (e.code == 'wrong-password') {
                                  print('Wrong password provided for that user.');
                                }
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('잘못된 email 을 입력하셨거나, password 를 잘못 입력하셨습니다')));
                              }
                              setState(() {
                                _saving = false;
                              });
                            }
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
                  // fixme: landscope 시, 아래로 스크롤할 수 있게 만들기
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
          ),
        ),
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

// fixme: TextFormField 는 중복 코드가 있다. ValueKey(1) 는 email 로 공유하면 안되나 ?
// fixme: landscope 상태일 때, 하단 sns 로그인 버튼들이 잘린다
