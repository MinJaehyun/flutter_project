import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Model {
  // note: 날씨 상태 문자열로 받기위한 변수
  late String? conditionString;
  late String? airPollutionString;

  // note: 날씨 상태를 SVG 위젯으로 출력 - Widget 타입 설정
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
      return SvgPicture.asset('assets/svg/Sun.svg');
    } else if(id >= 801 && id <= 804) {
      conditionString = 'Cloud';
      return SvgPicture.asset('assets/svg/Cloud.svg');
    }
    conditionString = 'Thermometer-75';
    return SvgPicture.asset('assets/svg/Thermometer-75.svg');
  }

  // note: 대기질 상태를 이미지 위젯으로 출력
  Widget getAirPollution(index) {
    if(index == 1) {
      airPollutionString = 'good';
      return Image.asset('assets/images/good.png');
    } else if(index == 2) {
      airPollutionString = 'fair';
      return Image.asset('assets/images/fair.png');
    } else if(index == 3) {
      airPollutionString = 'moderate';
      return Image.asset('assets/images/moderate.png');
    } else if(index == 4) {
      airPollutionString = 'poor';
      return Image.asset('assets/images/poor.png');
    } else {
      airPollutionString = 'bad';
      return Image.asset('assets/images/bad.png');
    }
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

// note: 대기질 상태 정보
// air_pollution: 1 = Good, 2 = Fair, 3 = Moderate, 4 = Poor, 5 = Very Poor.