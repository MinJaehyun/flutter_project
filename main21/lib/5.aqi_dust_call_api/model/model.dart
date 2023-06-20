import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Model {
  // note: 날씨 상태 문자열로 받기위한 변수
  late String? conditionString;

  // note: Widget 타입 설정
  Widget getWeatherCondition(id) {
    if(id >= 200 && id <= 232) {
      conditionString = 'Cloud-Lightning-Moon';
      return SvgPicture.asset('assets/svg/Cloud-Lightning-Moon.svg');
    } else if(id >= 300 && id <= 321) {
      conditionString = 'Cloud-Drizzle';
      return SvgPicture.asset('assets/svg/Cloud-Drizzle.svg');
    } else if(id >= 500 && id <= 531) {
      conditionString = 'Cloud-Rain';
      return SvgPicture.asset('assets/svg/Cloud-Rain.svg');
    } else if(id >= 600 && id <= 622) {
      conditionString = 'Cloud-Snow';
      return SvgPicture.asset('assets/svg/Cloud-Snow.svg');
    } else if(id == 800) {
      conditionString = 'sun';
      return SvgPicture.asset('assets/svg/sun.svg');
    } else if(id >= 801 && id <= 804) {
      conditionString = 'Cloud';
      return SvgPicture.asset('assets/svg/Cloud.svg');
    }
    conditionString = 'Thermometer-75';
    return SvgPicture.asset('assets/svg/Thermometer-75.svg');
  }
}

// note: Model 에 멤버변수와 생성자가 있는 경우와 Model 에 함수만 있는 경우의 차이점 이해
// 부모는 인스턴스 생성자에 인자 넣는 경우와 인스턴스 내에 메서드에 인자 넣는 경우의 차이이다.
// 자식는 위 경우에 따라 멤버변수를 설정할지, 함수 내 매개변수를 설정할지 선택해서 사용하면 된다.

/* openweathermap - condition id
200~232: Thunderstorm
300~321: Drizzle
500~531: Rain
600~622: Snow
701~781: Atmosphere: 대기질 관련
800: Clear
801~804: Clouds
* */

/* 날씨 상태 문자열로도 나타내기 위해 변수에 담는다
 - 이는 부모가 자식의 멤버변수 가져오면 된다
* */