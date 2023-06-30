import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:main25/screens/popup_profile.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  User? currentUser;
  String _textMessage = '';
  final a = FirebaseFirestore.instance.collection('chat').doc();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    var currentUser = FirebaseAuth.instance.currentUser;
    setState(() {
      currentUser = currentUser;
    });
  }

  void showPopupProfile() {
    showDialog(
      context: context,
      builder: (context) {
        return ShowDialogProfile();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.lightGreen,
        actions: [
          // =============== profile =================
          IconButton(
            onPressed: () {
              showPopupProfile();
            },
            icon: Icon(Icons.person),
          ),
          // =============== logout =================
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              // note: signOut 사용 시, 위젯 트리는 남아 있으므로 직접 제거하기
              // note: 아래 제거하여 로그아웃하면 블랙아웃되는 현상 해결
              // Navigator.of(context).pop();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Expanded(child: buildStreamBuilder()),
            // todo: class 다른 파일로 분리하기
            // note: 하단 채팅 입력창 및 전송 버튼
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.tealAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        maxLines: null,
                        controller: _controller,
                        onChanged: (value) => setState(() => _textMessage = value),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 17),
                          hintText: 'Send a message',
                          suffixIcon: Row(
                            // note: 여럿의 suffixIcon 을 설정 방법
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                // todo: 추 후, 검색어 넣고 search 찾는 기능 만들기
                                onPressed: () {},
                                icon: Icon(Icons.search),
                              ),
                              IconButton(
                                // note: 입력값 유무 판별 버튼
                                onPressed: () async {
                                  // note: 전송 누르면 입력 내용 서버에 전송
                                  var credential = FirebaseAuth.instance.currentUser!.uid;
                                  var userData = await FirebaseFirestore.instance.collection('user').doc(credential).get();

                                  FirebaseFirestore.instance.collection('chat').add({
                                    'text': _textMessage,
                                    'time': Timestamp.now(),
                                    'userID': FirebaseAuth.instance.currentUser!.uid,
                                    'name': userData.data()!['username'],
                                    // fixme: 230630. 18시 에러 진행 중....
                                    'pick_image': userData.data()!['pick_image'] ?? 'https://firebasestorage.googleapis.com/v0/b/n-back-with-chat.appspot.com/o/images%2Fserver_user.png?alt=media&token=3b5fc276-8489-406c-8cad-e4fbdb95af7c',
                                    // 'https://firebasestorage.googleapis.com/v0/b/n-back-with-chat.appspot.com/o/images%2Fserver_user.png?alt=media&token=3b5fc276-8489-406c-8cad-e4fbdb95af7c'
                                    // note: 에러난다 // print('no data(): ${userData['picked_image']}');
                                  });
                                  // note: 입력창 내용 지우기
                                  _controller.clear();
                                  // note: _controller.clear() 사용해도 변수는 내용 남아 있으므로 직접 지움
                                  setState(() => _textMessage = '');
                                },
                                icon: _textMessage.trim().isEmpty ? Opacity(opacity: 0.5) : Icon(Icons.send),
                                color: Colors.pink,
                              ),
                            ],
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> buildStreamBuilder() {
    return StreamBuilder(
      // note: chat 이하 여러 문서를 snapshots 으로 가져온다
      stream: FirebaseFirestore.instance.collection('chat').orderBy('time', descending: true).snapshots(),
      // note: snapshot 의 타입 주의
      builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        return ListView.builder(
          reverse: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            bool isMe = snapshot.data!.docs[index]['userID'] == FirebaseAuth.instance.currentUser!.uid;
            return Row(
              // note: 좌측: 본인 글, 우측: 타인의 글
              mainAxisAlignment: isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
              children: [
                // ============= my image ===============
                if (isMe) buildRow(snapshot.data!.docs[index]['pick_image']),
                // ============= Text ===============
                Container(
                  height: 55,
                  padding: EdgeInsets.all(8),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.blue[400] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '${snapshot.data!.docs[index]['name']}',
                          style: TextStyle(color: isMe ? Colors.white : Colors.black87, fontSize: 10),
                        ),
                        Text(
                          '${snapshot.data!.docs[index]['text']}',
                          style: TextStyle(color: isMe ? Colors.white : Colors.black87),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white54,
                  ),
                ),
                // ============= another image ===============
                if (!isMe) buildRow(snapshot.data!.docs[index]['pick_image']),
              ],
            );
          },
        );
      },
    );
  }

  Row buildRow(doc) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.all(3),
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: const LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [
                Color(0xff4dabf7),
                Color(0xffda77f2),
                Color(0xfff783ac),
              ],
            ),
          ),
          child: CircleAvatar(
            // backgroundImage: AssetImage('assets/images/default_user.png'),
            // todo: 본인의 이미지를 storage 에서 가져오기기

            backgroundImage: NetworkImage(doc),
            radius: 25,
          ),
        ),
      ],
    );
  }
}

/* note: chat/랜덤문서/ 속성에 userID 를 판별하기 위해,
 ListView.builder 내 snapshot.data!.docs[index]['userID'] 이,
 FirebaseAuth.instance.currentUser!.uid 인 현재 로그인 한 유저와
 같다면 본인이 쓴 글이다.
* */
