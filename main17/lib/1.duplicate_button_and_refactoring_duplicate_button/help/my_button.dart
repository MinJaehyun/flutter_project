import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {Key? key,
        required this.image,
        required this.color,
        required this.radius,
        required this.loginText})
      : super(key: key);
  final Widget image;
  final Color color;
  final double radius;
  final Widget loginText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // note: Image 와 Text 위젯 받기
          image,
          loginText,
          // note: 비어있는 이미지를 설정하기위한 아무 png 설정
          Opacity(
            opacity: 0.0,
            // todo: 경로 수정하기
            child: Image.asset('assets/images/glogo.png'),
          ),
        ],
      ),
    );
  }
}
