import 'package:ai_dang/views/home.dart';
import 'package:ai_dang/views/predResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_charts/multi_charts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../dbHandler.dart';
import '../../session.dart';

var colorBlack = const Color(0xff535353);
var colorRed = const Color(0xffCF2525);
var colorLightGray = const Color(0xffF3F3F3);
var colorGray = const Color(0xffE0E0E0);
var colorDarkGray = const Color(0xffADADBE);
var colorOrange = const Color(0xffFBAA47);
var colorGreen = const Color(0xff8AD03C);

class statistics extends StatefulWidget {
  const statistics({Key? key}) : super(key: key);

  @override
  State<statistics> createState() => _statisticsState();
}

var dietInfo_cal = Session.instance.dietInfo['recom_cal'];
var dietInfo_hydrate = Session.instance.dietInfo['recom_hydrate'];
var dietInfo_protein = Session.instance.dietInfo['recom_protein'];
var dietInfo_fat = Session.instance.dietInfo['recom_fat'];
var dietInfo_sugar = Session.instance.dietInfo['recom_sugar'];

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final int y;
}

final List<ChartData> chartData = [
  ChartData(11, 35),
  ChartData(12, 23),
  ChartData(13, 34),
  ChartData(14, 25),
  ChartData(15, 40)
];

class EatChartData {
  EatChartData(this.x, this.y, this.y_user);
  final String x;
  final double? y;
  final double? y_user;
}

class BloodData {
  BloodData(this.x, this.y);
  final String x;
  final double? y;
}

class _statisticsState extends State<statistics> with TickerProviderStateMixin {
  final List<BloodData> bloodData = [
    BloodData('5월 26일', 120),
    BloodData('5월 27일', 110),
    BloodData('5월 28일', 108),
    BloodData('5월 29일', 125),
    BloodData('5월 30일', 121),
    BloodData('5월 31일', 105),
    BloodData('6월 01일', 80),
  ];

  final List<EatChartData> eatChartData = [
    EatChartData('최저', 118, 120),
    EatChartData('최고', 123, 115),
    EatChartData('평균', 107, 109),
  ];

  Widget infoWidget(label, value, {var labelColor = const Color(0xff535353)}) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              textScaleFactor: 1,
              style: TextStyle(color: labelColor, fontWeight: FontWeight.w500)),
          Text(value,
              textScaleFactor: 1.1,
              style: TextStyle(color: black, fontWeight: FontWeight.w700))
        ],
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.5, color: gray),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 이전 버튼 ------------------------------------------------------
              IconButton(
                icon: Icon(Icons.arrow_back_ios, color: colorBlack),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                iconSize: 21,
                onPressed: () {},
              ),
              Text(
                '2022년 6월 3주 리포트',
                textScaleFactor: 0.9,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: colorRed,
                ),
              ),
              // 이후 버튼 ------------------------------------------------------
              IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: colorBlack),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                iconSize: 21,
                onPressed: () {},
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorWeight: 6, // 라벨 꽉 차게
            indicatorColor: colorRed,
            labelColor: black,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
            tabs: const [
              Tab(
                text: '혈당 정보',
              ),
              Tab(text: '영양 정보'),
            ],
          ),
        ),
        body: Container(
          color: colorLightGray,
          child: TabBarView(
            children: [
              // 혈당 정보 ------------------------------------------------------
              Center(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 혈당섭취 정보
                    sugarConsumeInfo(),
                    // 혈당섭취 비교 그래프
                    sugarCompareInfo(),
                  ],
                ),
              )),

              // 영양 정보 ------------------------------------------------------
              Container(
                color: colorLightGray,
                child: Center(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // 칼로리 섭취량 그래프 -------------------------------------
                      calConsumeInfo(),
                      // 섭취 영양소 그래프 --------------------------------------
                      nutConsumeInfo(),
                    ],
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 혈당 섭취량 정보
  Widget sugarConsumeInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '혈당 섭취량 그래프',
                textScaleFactor: 1.1,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: colorRed,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    series: <CartesianSeries>[
                      LineSeries<BloodData, String>(
                        dataSource: bloodData,
                        xValueMapper: (BloodData data, _) => data.x,
                        yValueMapper: (BloodData data, _) => data.y,
                        color: colorRed,
                        markerSettings:
                            MarkerSettings(isVisible: true, color: colorRed),
                      ),
                    ]),
              ),
              infoWidget('평균 섭취량', '102g', labelColor: colorRed),
              infoWidget('최고 섭취량', '160g'),
              infoWidget('최저 섭취량', '79g')
            ],
          ),
        ),
      ),
    );
  }

  // 혈당섭취 비교 그래프
  Widget sugarCompareInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '섭취량 비교 그래프',
                textScaleFactor: 1.1,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: colorRed,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 250,
                child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    series: <CartesianSeries>[
                      BarSeries<EatChartData, String>(
                        dataSource: eatChartData,
                        xValueMapper: (EatChartData data, _) => data.x,
                        yValueMapper: (EatChartData data, _) => data.y,
                        color: colorRed,
                        width: 0.5,
                      ),
                      BarSeries<EatChartData, String>(
                        dataSource: eatChartData,
                        xValueMapper: (EatChartData data, _) => data.x,
                        yValueMapper: (EatChartData data, _) => data.y_user,
                        color: colorBlack,
                        width: 0.5,
                      )
                    ]),
              ),
              RichText(
                textScaleFactor: 1.1,
                text: TextSpan(
                  text: '저번 주 보다 ',
                  style: TextStyle(color: black, fontWeight: FontWeight.w400),
                  children: <TextSpan>[
                    TextSpan(
                        text: '혈당을 18% 더 섭취',
                        style: TextStyle(
                            color: colorRed, fontWeight: FontWeight.w600)),
                    const TextSpan(text: '하고 있어요.')
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // 칼로리 섭취량 그래프
  Widget calConsumeInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '칼로리 섭취량 그래프',
                textScaleFactor: 1.1,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: colorRed,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: SfCartesianChart(
                    enableSideBySideSeriesPlacement: false,
                    series: <ChartSeries<ChartData, int>>[
                      // Renders column chart
                      ColumnSeries<ChartData, int>(
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        width: 0.5,
                        color: colorRed,
                      )
                    ]),
              ),
              // 열량 정보  ------------------------------------
              infoWidget('평균 섭취량', '1,702kcal', labelColor: colorRed),
              infoWidget('최고 섭취량', '1,890kcal'),
              infoWidget('최저 섭취량', '1,414kcal'),
            ],
          ),
        ),
      ),
    );
  }

  // 섭취 영양소 그래프
  Widget nutConsumeInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '섭취 영양소 그래프',
                textScaleFactor: 1.1,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: colorRed,
                ),
              ),
              // 섭취 영양소 차트 ------------------------------
              SizedBox(
                height: 250,
                //Radar Chart
                child: RadarChart(
                  values: const [9.0, 10.3, 8.9, 13.5, 10.1],
                  labels: const [
                    "탄수화물",
                    "단백질",
                    "지방",
                    "나트륨",
                    "콜레스트롤",
                  ],
                  maxValue: 15,
                  fillColor: colorRed,
                  strokeColor: colorDarkGray,
                  chartRadiusFactor: 0.8,
                ),
              ),
              Center(
                child: RichText(
                    textScaleFactor: 1.1,
                    text: TextSpan(
                      text: '나트륨을 ',
                      style:
                          TextStyle(color: black, fontWeight: FontWeight.w400),
                      children: <TextSpan>[
                        TextSpan(
                            text: '너무 과도하게 섭취',
                            style: TextStyle(
                                color: colorRed, fontWeight: FontWeight.w600)),
                        const TextSpan(text: '하고 있어요.')
                      ],
                    )),
              ),
              SizedBox(height: 20),
              infoWidget('탄수화물 섭취량', '90%'),
              infoWidget('단백질 섭취량', '103%'),
              infoWidget('지방 섭취량', '89%'),
              infoWidget('나트륨 섭취량', '135%', labelColor: colorRed),
              infoWidget('콜레스트롤 섭취량', '101%'),
            ],
          ),
        ),
      ),
    );
  }
}
