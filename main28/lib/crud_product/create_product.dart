import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CreateProduct {
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('products');
  TextEditingController _productController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  void showModalSheet(context) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Container(
          padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              TextField(
                controller: _productController,
                decoration: InputDecoration(labelText: 'product', hintText: '상품을 입력해 주세요'),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'price', hintText: '가격을 입력해 주세요'),
              ),
              ButtonBar(
                children: [
                  ElevatedButton(onPressed: () async {
                    try {
                      await collectionReference.add({
                        'product': _productController.text,
                        'price': _priceController.text,
                      });
                      Navigator.of(context).pop();
                      _productController.text = '';
                      _priceController.text = '';
                    } catch(e) {
                      print(e);
                    }
                  }, child: Text('생성')),
                  ElevatedButton(onPressed: () {
                    Navigator.of(context).pop();
                  }, child: Text('취소')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}