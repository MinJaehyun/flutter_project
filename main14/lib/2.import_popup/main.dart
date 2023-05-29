import 'package:flutter/material.dart';
import 'package:main14/2.import_popup/popup/show_popup.dart';

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
                          // note: 부모, 자식간에 넘겨주는 형태 기억하기
                          // note: ShowPopup(context, jobInfo[index], userJob: userJob[index], userImage: userImage[index]);
                          // note: 위처럼 즉시 import 하여 사용하지 않고, builder 이하 내용을 다른 파일에 설정하여 가져와 실행한다
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
    showDialog(
      context: context,
      builder: (context) {
        // note: builder 이하 내용을 다른 파일에 설정하여 가져와 실행한다 (return 받기위한 구조)
        return ShowPopup(context, jobInfo, userJob: userJob, userImage: userImage);
      },
    );
  }
}
