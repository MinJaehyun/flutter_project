import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:main21/5.aqi_dust_call_api/model/model.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({required this.products, required this.pollutionData});

  final pollutionData;
  final products;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String? cityName;
  double? temp;
  int? id;
  Widget? icon;
  String? conditionStr;
  Widget? aqiIcon;
  String? airPollutionStr;
  double? pm2_5;
  double? pm10;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    updateData(widget.products, widget.pollutionData);
  }

  // note: 앱 실행 즉시 widget.products 의 내용을 State 내 생성한 변수에 담는다
  void updateData(dynamic weatherData, dynamic pollutionData) {
    cityName = weatherData?['name'];
    temp = weatherData?['main']['temp'];
    id = weatherData?['weather'][0]['id'];
    // print(weatherData);
    // note: 인스턴스 가져와서 메서드 내에 위젯 가져와서 icon 변수에 담고 UI에 나타내기
    Model model = Model();
    icon = model.getWeatherCondition(id);
    conditionStr = model.conditionString;

    // note: air pullution info
    // print(pollutionData);
    int aqiIndex = pollutionData['list'][0]['main']['aqi'];
    // note: aqiIndex 을 model 활용해서 이미지 위젯 가져오기 (함수로만 사용)
    aqiIcon = model.getAirPollution(aqiIndex);
    airPollutionStr = model.airPollutionString;
    pm2_5 = pollutionData['list'][0]['components']['pm2_5'];
    pm10 = pollutionData['list'][0]['components']['pm10'];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(color: Colors.white, letterSpacing: .5);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.account_circle))],
      ),
      body: Stack(
        children: [
          Container(
            child: Image.asset(
              'assets/images/background2.jpg',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
                  // ========== 지역 이름 ==========
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 150.0),
                      Text(
                        // note: null 아니면 출력한다
                        cityName!,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.white,
                            letterSpacing: .5,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // ========== 시간, 요일, 날짜 ==========
                      Row(
                        children: [
                          Text(
                            DateFormat('yyyy년 MMM d일', 'ko').format(DateTime.now()).toString(),
                            style: style,
                          ),
                          SizedBox(width: 5),
                          Text(DateFormat('EEEE', 'ko').format(DateTime.now()).toString(), style: style),
                          SizedBox(width: 5),
                          TimerBuilder.periodic(
                            Duration(seconds: 1),
                            builder: (context) {
                              return Text(DateFormat('a h:mm:ss', 'ko').format(DateTime.now()).toString(), style: style);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // ========== 온도 ==========
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        '${temp?.toInt()}\u00B0',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.white,
                            letterSpacing: .5,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      // ========== svg ==========
                      Row(
                        children: [
                          icon!,
                          Text('${conditionStr.toString()}', style: style),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 5, color: Colors.redAccent),
                // ========== 하단 대기질 관련 ==========
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // ========== AQI ==========
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('AQI(대기질 지수)',style:style),
                          SizedBox(height: 11),
                          // note: 대기질은 평가 기준 활용, air polution api (1~5)
                          aqiIcon!,
                          SizedBox(height: 11),
                          Text('$airPollutionStr', style:style),
                        ],
                      ),
                    ),
                    // ========== 미세 먼지 ==========
                    Container(
                      height: 140,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('미세 먼지', style:style),
                          Text('$pm10', style: TextStyle(color: Colors.greenAccent)),
                          Text('㎍/㎥', style:style),
                        ],
                      ),
                    ),
                    // ========== 초미세 먼지 ==========
                    Container(
                      height: 140,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('초미세 먼지', style:style),
                          Text('$pm2_5', style: TextStyle(color: Colors.greenAccent)),
                          Text('㎍/㎥', style:style),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
