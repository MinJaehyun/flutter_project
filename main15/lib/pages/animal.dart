import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:main15/model/animal.dart';

class AnimalPage extends StatelessWidget {
  const AnimalPage({Key? key, required this.animal}) : super(key: key);
  final Animal animal;

  @override
  Widget build(BuildContext context) {
    double buttonSize = 35.0;
    bool isLiked = false;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Info page'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(animal.imagePath, height: 300),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(animal.animalName + ': ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50)),
                  Text(animal.location, style: TextStyle(fontSize: 30)),
                ],
              ),
              LikeButton(
                size: buttonSize,
                circleColor: CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                bubblesColor: BubblesColor(
                  dotPrimaryColor: Color(0xff33b5e5),
                  dotSecondaryColor: Color(0xff0099cc),
                ),
                likeCount: 1,
                isLiked: isLiked,
                // note: isLiked 의 색상 또는 아이콘을 변경하는 코드
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.heart_broken,
                    color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
                    size: buttonSize,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// todo: 추 후, 서버에 저장된 isLiked, likeCount 를 활용하여 데이터를 가져오고, 데이터를 보내는 과정 코드로 작성하기