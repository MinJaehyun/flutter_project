import 'package:flutter/material.dart';

class DicePage extends StatelessWidget {
  const DicePage ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('dice page'),
        centerTitle: true,
      ),
      body: Text('dice page 입니다'),
    );
  }
}
