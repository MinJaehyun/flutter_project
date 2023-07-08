import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class UpdateProduct {
  TextEditingController _productController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('products');

  // note: update
  void update(context, documentSnapshot) {
    _productController.text = documentSnapshot['product'];
    _priceController.text = documentSnapshot['price'].toString();

    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Container(
          // note: ★☆★ 텍스트필드를 감싸고 있는 컨테이너에 bottom sheet 를 키보드 눌렀을 때 가리지 않게 설정하는 방법 ★☆★
          padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
          // _productController.text = collectionReference.doc(documentSnapshot.id)['product'], // 서버값 넣기 documentSnapshot.id 의 product
          color: Colors.white70,
          child: Column(
            // note: 입력창 크기만큼 공간을 차지하게 설정
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _productController,
                decoration: InputDecoration(
                  labelText: 'product',
                  hintText: '변경할 상품명을 입력해 주세요',
                ),
              ),
              TextField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: 'price',
                    hintText: '변경할 가격을 입력해 주세요',
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _updateCheck(documentSnapshot);
                      Navigator.of(context).pop();
                    },
                    child: Text('Update'),
                  ),
                  SizedBox(width: 15),
                  ElevatedButton(onPressed: () => _updateCancelShowDialog(context), child: Text('Cancel')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // note: 업데이트 확인 기능
  void _updateCheck(documentSnapshot) {
    collectionReference.doc(documentSnapshot.id).set({
      'product': _productController.text,
      'price': _priceController.text,
    });
  }

  // note: 업데이트 cancel 기능
  void _updateCancelShowDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        // note: Container 삭제하면 알림창 뒤에 화면 보여준다
        return Container(
          color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Dialog(
                child: Column(
                  children: [
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.notifications),
                        title: Text('업데이트를 취소 하시겠습니까?'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: Text('Yes')),
                        SizedBox(width: 15),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('No')),
                        SizedBox(width: 5),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
