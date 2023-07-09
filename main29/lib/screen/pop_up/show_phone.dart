import 'package:flutter/material.dart';

class ShowPopupPhone {
  void showPopupPhone(context, user, index) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: ListTile(
            title: Text('번호:'),
            subtitle: Text('${user[index].phone}'),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.phone),
              tooltip: '전화 걸기',
            ),
          ),
        );
      },
    );
  }
}

