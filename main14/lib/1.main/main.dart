import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ViewUser(),
    );
  }
}

class ViewUser extends StatefulWidget {
  const ViewUser({Key? key}) : super(key: key);

  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  // fixme: List<String> 명칭 맞는지 확인하기
  List<String> userJob = [
    'Doctor',
    'Teacher',
    'Engineer',
    'Lawyer',
    'Accountant',
  ];

  List<String> jobInfo = [
    'A medical professional who diagnoses and treats illnesses, injuries, and diseases, often working in hospitals or clinics.',
    'An educator who imparts knowledge and instructs students in various subjects, typically working in schools or educational institutions.',
    'A professional who applies scientific and mathematical principles to design, develop, and construct structures, machines, systems, or processes.',
    'A legal professional who provides advice, represents clients, and advocates for their rights and interests in legal matters.',
    'A financial professional who maintains and examines financial records, prepares financial statements, and provides guidance on financial matters for individuals or organizations.',
  ];

  List<String> userImage = [
    'assets/images/user_image/job1.png',
    'assets/images/user_image/job2.png',
    'assets/images/user_image/job3.png',
    'assets/images/user_image/job4.png',
    'assets/images/user_image/job5.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView', style: TextStyle(color: Colors.grey)),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: userJob.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _showPopup(context, userJob[index], jobInfo[index], userImage[index]);
            },
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    title: Text(userJob[index]),
                    subtitle: Text(jobInfo[index], maxLines: 1),
                    leading: Image.asset(userImage[index]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          _showPopup(context, userJob[index], jobInfo[index], userImage[index]);
                        },
                        child: Text('Info'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showPopup(context, userJob, jobInfo, userImage) {
    // note: 클릭 시, 세부 정보를 팝업창으로 나타냄
    // fixme: 아래 함수를 다른 파일로 분리하기 (인자 4개 주고 받기)
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Center(
            child: Column(
              children: [
                ClipRect(
                  child: Image.asset(userImage),
                ),
                Card(
                  child: ListTile(
                    title: Text(userJob),
                    subtitle: Text(jobInfo),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close),
                  label: Text('CLOSE'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
