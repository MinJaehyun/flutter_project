import 'package:flutter/material.dart';
import 'package:main29/helper/service.dart';
import 'package:main29/model/user.dart';
import 'package:main29/screen/pop_up/show_phone.dart';

class JsonApiCall extends StatefulWidget {
  const JsonApiCall({super.key});

  @override
  State<JsonApiCall> createState() => _JsonApiCallState();
}

class _JsonApiCallState extends State<JsonApiCall> {
  Service service = Service();
  List<User> user = <User>[];

  @override
  void initState() {
    super.initState();
    Service.getTest().then((value) {
      setState(() {
        user = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: user.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('${user[index].username}'),
                subtitle: Text('${user[index].company.name}'),
                trailing: IconButton(
                    onPressed: () {
                      ShowPopupPhone showPopupPhone = ShowPopupPhone();
                      showPopupPhone.showPopupPhone(context, user, index);
                    },
                    icon: Icon(Icons.phone_android_sharp)),
              ),
            );
          },
        ),
      ),
    );
  }
}

// note: http 통해 api 접근해서, model 직접 만들고, 만든 model 의 데이터를 List<User> 로 담기
