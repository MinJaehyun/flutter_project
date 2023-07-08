import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CloudCRUD(),
    );
  }
}

class CloudCRUD extends StatelessWidget {
  const CloudCRUD({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cloud CRUD'),
        centerTitle: true,
      ),
      // todo: StreamBuilder 의 제네릭 타입은 ?
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(), // C.R.snapshot()
        // todo: 인자 확인하기
        builder: (context, snapshot) {
          // print(snapshot.data!.docs);
          if (snapshot.hasError) {
            // todo: 에러 처리 내용 맞는지 ?
            print(snapshot.hasError);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              //
              return Card(
                child: ListTile(
                  title: Text('상품: ${snapshot.data!.docs[index]['product']}'),
                  subtitle: Text('가격: ${snapshot.data!.docs[index]['price']}'),
                  contentPadding: EdgeInsets.all(20),
                  trailing: FittedBox(
                    fit: BoxFit.fill,
                    child: Row(children: [
                      Icon(Icons.edit),
                      Icon(Icons.delete),
                    ]),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
