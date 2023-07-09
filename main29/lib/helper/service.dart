import 'package:main29/model/user.dart';
import 'package:http/http.dart' as http;

class Service {
  static const String uri = 'https://jsonplaceholder.typicode.com/users';

  // note: 반환 타입 반드시 작성하기
  static Future<List<User>> getTest() async {
    try {
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        final List<User> user = userFromJson(response.body);
        return user;
      }
    } catch(e) {
      print(e);
    }
    return <User>[];
  }
}

// note: http 통해 api 접근해서, model 직접 만들고, 만든 model 의 데이터를 List<User> 로 담기