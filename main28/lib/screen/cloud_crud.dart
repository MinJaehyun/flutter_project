import 'package:flutter/material.dart';
import 'package:main28/crud_product/create_product.dart';
import 'package:main28/crud_product/delete_product.dart';
import 'package:main28/crud_product/update_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudCRUD extends StatefulWidget {
  const CloudCRUD({super.key});

  @override
  State<CloudCRUD> createState() => _CloudCRUDState();
}

class _CloudCRUDState extends State<CloudCRUD> {
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text('create'),
        icon: Icon(Icons.save),
        // note: product create 기능
        onPressed: () {
          CreateProduct createProduct = CreateProduct();
          createProduct.showModalSheet(context);
        },
        // note: 모바일은 long press 해야 tooltip 나타난다
        tooltip: '상품 저장하기',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(title: Text('Cloud CRUD'), centerTitle: true),
      body: StreamBuilder(
        stream: collectionReference.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('${snapshot.hasError}');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
              return Card(
                child: ListTile(
                  title: Text('상품: ${snapshot.data!.docs[index]['product']}'),
                  subtitle: Text('가격: ${snapshot.data!.docs[index]['price']}'),
                  contentPadding: EdgeInsets.all(20),
                  trailing: FittedBox(
                    fit: BoxFit.fill,
                    child: Row(
                      children: [
                        // note: update
                        IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              UpdateProduct updateProduct = UpdateProduct();
                              updateProduct.update(context, documentSnapshot);
                              // 분리 전: _update(context, documentSnapshot);
                            }),
                        // note: delete
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            DeleteProduct deleteProduct = DeleteProduct();
                            deleteProduct.delete(context, documentSnapshot);
                          },
                        ),
                      ],
                    ),
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
