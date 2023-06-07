import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';

class Dice extends StatefulWidget {
  const Dice({Key? key}) : super(key: key);

  @override
  State<Dice> createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  late int dice1 = 1;
  late int dice2 = 1;

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width * 0.7) / 2;

    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: const Text('Dice Page'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // NOTE: 가로, 세로 최대폭 Expanded 설정하면 편리
                // Expanded(child: Image.asset('assets/main16/dice/dice1.png', width: width),flex: 2,),
                // const SizedBox(width: 15),
                // Expanded(child: Image.asset('assets/main16/dice/dice2.png', width: width),flex: 1),

                // NOTE: MediaQuery 사용하여 사이즈 조정
                Image.asset('assets/main16/dice/dice$dice1.png', width: width),
                const SizedBox(width: 15),
                Image.asset('assets/main16/dice/dice$dice2.png', width: width),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // 주사위값 변경
                setState(() {
                  dice1 = Random().nextInt(6) + 1;
                  dice2 = Random().nextInt(6) + 1;
                });
                // toast msg 에 선택된 주사위 숫자를 문자형으로 출력
                showToast("left: $dice1 , right: $dice2");
              },
              child: const Text('mix the dice'),
            ),
          ],
        ),
      ),
    );
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 22.0);
  }
}