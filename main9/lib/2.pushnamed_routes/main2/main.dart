import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '23',
      // home: MyPage(),
      initialRoute: '/',
      routes: {
        '/': (context) => MyPage(),
        '/b': (context) => ScreenB(),
        '/c': (context) => ScreenC(),
      },
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScreenA'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/b');
              },
              child: Text('Go to ScreenB'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/c');
              },
              child: Text('Go to ScreenC'),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenB extends StatelessWidget {
  const ScreenB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ScreenB')),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('screenB page 에 입장하셨습니다.'),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            child: Text('Go to ScreenA'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/c');
            },
            child: Text('Go to ScreenC'),
          ),
        ]),
      ),
    );
  }
}

class ScreenC extends StatelessWidget {
  const ScreenC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ScreenC')),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('screenC page 에 입장하셨습니다.'),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            child: Text('Go to ScreenA'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/b');
            },
            child: Text('Go to ScreenB'),
          ),
        ]),
      ),
    );
  }
}
