// note: dart:html 와 dart:io 둘 다 사용 시, io 의 File 함수를 사용 하면 둘 다 File 함수가 있으므로 에러가 난다. 해결: as 명시
// import 'dart:html';
import 'dart:io' as io;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ShowDialogProfile extends StatefulWidget {
  const ShowDialogProfile({super.key});

  @override
  State<ShowDialogProfile> createState() => _ShowDialogProfileState();
}

class _ShowDialogProfileState extends State<ShowDialogProfile> {
  final credential = FirebaseAuth.instance.currentUser!.uid;
  final userCollectionRef = FirebaseFirestore.instance.collection('user');
  final ImagePicker _picker = ImagePicker();
  io.File? _pickImage;
  String? pickImageUrl;

  Future<void> getUrl() async {
    var test = await userCollectionRef.doc(credential).get();
    var url = test.data()!['pick_image'];
    setState(() {
      pickImageUrl = url;
    });
  }

  @override
  void initState() {
    super.initState();
    getUrl();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(12),
        height: 400,
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 45,
                      // note: Storage 에서 가져오기 전, image_picker 로 가져온 사진 등록하기: backgroundImage: _pickImage != null ? FileImage(_pickImage!) : null,
                      // note: Storage 에 저장된 사진 url 을 로그인 한 user 의 pick_image 를 가져와서 본인의 이미지를 나타낸다
                      // note: pickImageUrl 가 비어있지 않으면 pickImageUrl 를 넣고, pickImageUrl 가 비어있으면 _pikImage 가 있는지 판단하여 있으면 _pikImage 를 넣고 없으면 null 처리한다
                      // error 해결: The argument type 'Object' can't be assigned to the parameter type 'ImageProvider<Object>' =>  as ImageProvider 선언
                      backgroundImage: pickImageUrl != null
                          ? NetworkImage(pickImageUrl!)
                          : _pickImage != null
                          ? FileImage(_pickImage!) as ImageProvider
                          : null,
                      // note: ★★★ child: FileImage(), // The argument type 'FileImage' can't be assigned to the parameter type 'Widget?' ★★★
                      //  "FileImage" 타입 인수는 "Widget?" 타입 매개변수에 할당할 수 없다. 즉, "FileImage"를 "Widget?"으로 변환할 수 없기 때문에 발생하는 오류
                    ),
                    SizedBox(width: 12),
                    // note: 버튼 클릭 시, image 를 갤러리에서 가져오거나 촬영하여 가져오기
                    Container(
                      height: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              setPickImage(ImageSource.gallery);
                            },
                            icon: Icon(Icons.change_circle),
                            label: Text('이미지 불러오기'),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              setPickImage(ImageSource.camera);
                            },
                            icon: Icon(Icons.change_circle),
                            label: Text('사진 찍기'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close_outlined),
                  label: Text('close')),
            ],
          ),
        ),
      ),
    );
  }

  void setPickImage(imageSourceType) async {
    final XFile? image = await _picker.pickImage(source: imageSourceType);
    setState(() {
      _pickImage = io.File(image!.path);
    });
    // note: 가져온 사진을 Storage 에 저장
    try {
      var mountainsRef = FirebaseStorage.instance.ref().child('images/${credential}.png');
      await mountainsRef.putFile(_pickImage!);
      // note:  Storage 에 url 가져오기
      final url = await mountainsRef.getDownloadURL();
      var docRefData = await userCollectionRef.doc(credential).get();
      await userCollectionRef.doc(credential).set({
        'useremail': docRefData.data()!['useremail'],
        'username': docRefData.data()!['username'],
        'pick_image': url,
      });
      setState(() {
        pickImageUrl = docRefData.data()!['pick_image'];
      });
    } catch(e) {
      print(e);
    }
  }

}
