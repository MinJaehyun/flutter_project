import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {

  // note: width 는 [] 으로 옵셔널 지정
  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0, color:  Colors.grey, fontWeight: FontWeight.bold);
    var pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.green[100],
      imagePadding: EdgeInsets.all(20),

    );

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: IntroductionScreen(
            // note: You cannot set 'showBackButton' and 'showSkipButton' to true. Only one, or both false.
            // showSkipButton: true,
            showDoneButton: true,
            showBackButton: true,
            back: Text('이 전 페이지'),
            // note: showNextButton: false, 속성 next 설정하지 않으면 이 부분을 false 로 설정해야 한다
            showNextButton: true,
            next: Text('다음 페이지'),
            done: const Text("온보딩 종료"),
            onDone: () {
              // todo: done 클릭 시, main page 로 이동하기
            },
            // skip: const Text('끝 페이지로 넘기기'),
            dotsDecorator: const DotsDecorator(
              size: Size(10.0, 10.0),
              color: Colors.cyan,
              activeSize: Size(22.0, 10.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              activeColor: Colors.redAccent
            ),
            curve: Curves.fastLinearToSlowEaseIn,
            pages: [
              // note: 단일 board 는 listPagesViewModel 을 사용하고, 둘 이상의 board 는 PageViewModel 를 사용한다
              PageViewModel(
                title: "PURCHASE ONLINE",
                body: "Welcome to the app! This is a description of how it works.",
                image: _buildImage('first.png'),
                // note: image: Image.asset('assets/images/first.png'), // 대신 중복되는 _buildImage 메서드로 개선
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "TRACK YOUR ORDER",
                body: "Welcome to the app! This is a description of how it works.",
                image: _buildImage('second.png'),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "GET YOUR ORDER",
                body: "Welcome to the app! This is a description of how it works.",
                image: _buildImage('third.png'),
                decoration: pageDecoration,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
