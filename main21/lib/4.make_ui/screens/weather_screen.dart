import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({required this.products});

  final products;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting();
    // daysFormat = new DateFormat.EEEE('ko'); // 요일 한글표현
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // note: 투명도 설정하고, 0 으로 조정
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
            // note: Image.asset 내 width 설정 가능
            width: double.infinity,
            // note: 이미지 하단에 흰색 공백 뜨는것은 이미지의 높이 최대 설정하여 해결
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
                        '${(widget.products?['name'])}',
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
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: 250),
                      Text(
                        '${(widget.products?['main']['temp']).round()}' + '\u00B0',
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
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset('assets/svg/Moon-Waxing-Crescent.svg'),
                          Text('Moon-Waxing-Crescent'),
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
                        Image.asset('assets/images/good.png', height: 100,),
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

