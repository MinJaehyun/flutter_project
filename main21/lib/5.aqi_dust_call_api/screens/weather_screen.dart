import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:main21/5.aqi_dust_call_api/model/model.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({required this.products});

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

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    updateData(widget.products);
  }

  // note: 앱 실행 즉시 widget.products 의 내용을 State 내 생성한 변수에 담는다
  void updateData(dynamic weatherData) {
    cityName = weatherData?['name'];
    temp = weatherData?['main']['temp'];
    id = weatherData?['weather'][0]['id'];
    // print(weatherData);
    print(id);
    // note: 인스턴스 가져와서 메서드 내에 위젯 가져와서 icon 변수에 담고 UI에 나타내기
    Model model = Model();
    icon = model.getWeatherCondition(id);
    conditionStr = model.conditionString;
  }

  @override
  Widget build(BuildContext context) {
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
          Image.asset(
            'assets/images/background2.jpg',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),

          // ========== 지역 이름 ==========
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
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
                          Text(DateFormat('yyyy년 MMM d일', 'ko').format(DateTime.now()).toString()),
                          SizedBox(width: 5),
                          Text(DateFormat('EEEE', 'ko').format(DateTime.now()).toString()),
                          SizedBox(width: 5),
                          TimerBuilder.periodic(
                            Duration(seconds: 1),
                            builder: (context) {
                              return Text(DateFormat('a h:mm:ss', 'ko').format(DateTime.now()).toString());
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
                          Text('${conditionStr.toString()}'),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('AQI(대기질 지수)'),
                        // fixme: 날씨 SVG 는 id 에 따라 달라져야 한다
                        Image.asset(
                          'assets/images/good.png',
                          height: 100,
                        ),
                        Text('좋음'),
                      ],
                    ),
                    // SizedBox(width: 40),
                    Container(
                      height: 140,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('미세먼지'),
                          Text('20'),
                          Text('좋음'),
                        ],
                      ),
                    ),
                    // SizedBox(width: 40),
                    Container(
                      height: 140,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('초미세먼지'),
                          Text('15'),
                          Text('좋음'),
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
