import 'package:flutter/material.dart';

class ShowPopup extends StatefulWidget {
  // ★★★ note: () 안에는 this. 접근하고 , {} 안에는 required this. 으로 접근한다
  const ShowPopup(BuildContext context, this.jobInfo, {Key? key, required this.userJob, required this.userImage}) : super(key: key);
  final String userJob;
  final String jobInfo;
  final String userImage;

  @override
  State<ShowPopup> createState() => _ShowPopupState();
}

class _ShowPopupState extends State<ShowPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Center(
        child: Column(
          children: [
            ClipRect(
              child: Image.asset(widget.userImage),
            ),
            Card(
              child: ListTile(
                title: Text(widget.userJob),
                subtitle: Text(widget.jobInfo),
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
  }
}

