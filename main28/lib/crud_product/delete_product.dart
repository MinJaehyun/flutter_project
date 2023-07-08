import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteProduct {
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('products');

  void delete(context, documentSnapshot) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                child: ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('상품을 삭제 하시겠습니까?'),
                ),
              ),
              ButtonBar(
                children: [
                  OutlinedButton(
                    onPressed: () async {
                      await collectionReference.doc(documentSnapshot.id).delete();
                      Navigator.of(context).pop();
                    },
                    child: Text('Yes', style: TextStyle(color: Colors.white)),
                    style: OutlinedButton.styleFrom(backgroundColor: Colors.redAccent),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('No'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}